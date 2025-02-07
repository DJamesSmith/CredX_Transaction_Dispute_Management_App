import 'package:get/get.dart';
import 'package:transaction_dispute/constants/string_constant.dart';
import 'package:transaction_dispute/widgets/custom_toast.dart';

class TransactionController extends GetxController {
  var disputeStatus = <String, String>{}.obs;
  var selectedCardId = ''.obs;
  var transactions = <Map<String, Object>>[].obs;
  var filteredTransactions = <Map<String, Object>>[].obs;
  final Map<String, List<Map<String, Object>>> refundTransactionsMap = {};

  void filterTransactionsByName(String name) {
    if (name.isEmpty) {
      filteredTransactions.value = transactions;
    } else {
      filteredTransactions.value = transactions
          .where((tx) => tx['transactionName']
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
    }
  }

  void filterTransactionsByDateRange(DateTime startDate, DateTime endDate) {
    filteredTransactions.value = transactions.where((tx) {
      final txDate = DateTime.parse(tx['date'].toString());
      return txDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          txDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  void resetFilters() {
    filteredTransactions.value = transactions;
  }

  void raiseDispute(String cardId, String transactionId) {
    disputeStatus[transactionId] = StringConstant.underDispute;
    disputeStatus.refresh();

    Future.delayed(Duration(seconds: 5), () {
      disputeStatus[transactionId] = StringConstant.beingReviewed;
      disputeStatus.refresh();

      Future.delayed(Duration(seconds: 5), () {
        final transaction = transactions.firstWhere(
          (tx) => tx['transactionId'] == transactionId,
          orElse: () => {},
        );

        if (transaction.isNotEmpty) {
          final Object amount = transaction['amount'] ?? 0;

          final Map<String, Object> refundTransaction = {
            'transactionName': 'Refund for ${transaction['transactionName']}',
            'date': DateTime.now().toString(),
            'amount': amount,
            'credited': true,
            'cardId': cardId,
            'transactionId': 'refund_${DateTime.now().millisecondsSinceEpoch}',
          };

          transactions.insert(0, refundTransaction);

          if (!refundTransactionsMap.containsKey(cardId)) {
            refundTransactionsMap[cardId] = [];
          }
          refundTransactionsMap[cardId]!.insert(0, refundTransaction);

          transactions.refresh();
          setSelectedCard(cardId, transactions.toList());

          CustomToast.show('$amount ${StringConstant.transferStatement}');
          disputeStatus[transactionId] = StringConstant.transacCompletionStatus;
          disputeStatus.refresh();
        }
      });
    });
  }

  String getDisputeStatus(String transactionId) {
    return disputeStatus[transactionId] ?? '';
  }

  bool isTransactionDisputed(String transactionId) {
    return disputeStatus.containsKey(transactionId);
  }

  void setSelectedCard(
      String cardId, List<Map<String, dynamic>> allTransactions) {
    selectedCardId.value = cardId;

    final cardTransactions = allTransactions
        .where((tx) =>
            tx['cardId'] == cardId &&
            !tx['transactionName'].toString().contains('Refund'))
        .map((tx) => Map<String, Object>.from(tx))
        .toList();

    final refundTransactions = refundTransactionsMap[cardId] ?? [];

    transactions.value = [...refundTransactions, ...cardTransactions];
    filteredTransactions.value = transactions;
  }
}
