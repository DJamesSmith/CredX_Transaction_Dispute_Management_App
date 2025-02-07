import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_dispute/constants/string_constant.dart';
import 'package:transaction_dispute/controllers/transaction_controller.dart';
import 'package:transaction_dispute/utils/data.dart';
import 'package:transaction_dispute/widgets/custom_bottom_sheet.dart';
import 'package:transaction_dispute/widgets/custom_toast.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/widgets/generate_referenceid_credit.dart';

class TransactionDetailsBottomsheet extends StatelessWidget {
  final String transactionId;
  final VoidCallback? onDisputeRaised;

  const TransactionDetailsBottomsheet({
    super.key,
    required this.transactionId,
    this.onDisputeRaised,
  });

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final String selectedCardId = transactionController.selectedCardId.value;

    final selectedTransaction = transactionController.transactions.firstWhere(
      (tx) =>
          tx['transactionId'] == transactionId &&
          tx['cardId'] == selectedCardId,
      orElse: () => {},
    );

    final bool isCredited = selectedTransaction.isNotEmpty &&
        (selectedTransaction['credited'] is bool
            ? selectedTransaction['credited'] as bool
            : false);

    if (selectedTransaction.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Text(StringConstant.tranNotFound),
        ),
      );
    }

    final card = cardData.firstWhere(
      (card) => card['id'] == selectedTransaction['cardId'],
      orElse: () => {},
    );

    final dateTime = DateTime.parse(selectedTransaction['date'].toString());
    final formattedDate = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    final formattedTime = '${dateTime.hour}:${dateTime.minute}';

    final isDisputed =
        transactionController.isTransactionDisputed(transactionId);
    final disputeStatus = transactionController.getDisputeStatus(transactionId);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ColorFile.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedTransaction['transactionName'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorFile.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isDisputed ? disputeStatus : StringConstant.completed,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDisputed ? ColorFile.orange : ColorFile.green,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isDisputed && !isCredited,
                child: IconButton(
                  icon: Icon(
                    Icons.flag_outlined,
                    color: ColorFile.grey600,
                    size: 24,
                  ),
                  onPressed: () {
                    _showDisputeConfirmationDialog(context, transactionId);
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          _buildCardDetailsSection(card),
          const SizedBox(height: 20),
          _buildTransactionDetailsSection(
            selectedTransaction,
            formattedDate,
            formattedTime,
            isCredited,
          ),
          const SizedBox(height: 20),
          if (isDisputed) _buildDisputeStatusSection(disputeStatus),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorFile.blue800,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                StringConstant.close,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorFile.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  void _showDisputeBottomSheet(BuildContext context, String transactionId) {
    final transactionController = Get.find<TransactionController>();
    final selectedCardId = transactionController.selectedCardId.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CustomBottomSheet(
            content: StringConstant.raiseDisputeQ2,
            confirmButtonText: StringConstant.raiseDispute,
            onConfirm: () {
              transactionController.raiseDispute(selectedCardId, transactionId);
              // Navigator.pop(context);
              if (onDisputeRaised != null) {
                onDisputeRaised!();
              }
            },
            onCancel: () {
              debugPrint(StringConstant.disputeCancelled);
            },
            onReasonSubmitted: (String reason) {
              debugPrint('${StringConstant.disputeReason} $reason');
            },
            isSuccessSheet: false,
          ),
        );
      },
    );
  }

  void _showDisputeConfirmationDialog(
    BuildContext context,
    String transactionId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(StringConstant.raiseDispute),
          content: const Text(
            StringConstant.raiseDisputeQ1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(StringConstant.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                final transactionController = Get.find<TransactionController>();
                final status =
                    transactionController.getDisputeStatus(transactionId);
                if (transactionController
                    .isTransactionDisputed(transactionId)) {
                  CustomToast.show(status);
                  return;
                }
                _showDisputeBottomSheet(context, transactionId);
              },
              child: const Text(StringConstant.confirm),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCardDetailsSection(Map<String, dynamic> card) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          color: ColorFile.blue500,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstant.cardUsed,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorFile.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              card['name'].toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorFile.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              card['cardNumber'].toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorFile.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetailsSection(
    Map<String, dynamic> transaction,
    String date,
    String time,
    bool isCredited,
  ) {
    final referenceCode = generateRandomAlphanumeric(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstant.transDetails,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorFile.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
            StringConstant.amount, transaction['amount'].toString()),
        _buildDetailRow(StringConstant.type,
            isCredited ? StringConstant.credit : StringConstant.debit),
        _buildDetailRow(StringConstant.date, date),
        _buildDetailRow(
            StringConstant.referenceNum,
            transaction['transactionName'].toString().contains('Refund for')
                ? referenceCode
                : transaction['refNumber']),
      ],
    );
  }

  Widget _buildDisputeStatusSection(String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorFile.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorFile.orange.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ColorFile.orange800,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${StringConstant.disputeStatus} $status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorFile.orange800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorFile.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorFile.black87,
            ),
          ),
        ],
      ),
    );
  }
}
