import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/constants/string_constant.dart';
import 'package:transaction_dispute/controllers/transaction_controller.dart';

class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final String transactionId;
  final VoidCallback onTap;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onTap,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: transaction['credited']
                          ? ColorFile.green300
                          : ColorFile.red300,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      transaction['credited']
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      size: 20,
                      color: ColorFile.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['transactionName'] as String,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          transaction['date'] as String,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${transaction['credited'] ? '+' : '-'}${transaction['amount']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: transaction['credited']
                          ? ColorFile.green
                          : ColorFile.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () {
              final transactionController = Get.find<TransactionController>();
              final status =
                  transactionController.getDisputeStatus(transactionId);

              return status.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(left: 45.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                      decoration: BoxDecoration(
                        color: status == StringConstant.underDispute
                            ? ColorFile.red600
                            : status == StringConstant.beingReviewed
                                ? ColorFile.orange600
                                : ColorFile.blue600,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(color: ColorFile.white, fontSize: 12),
                      ),
                    )
                  : SizedBox.shrink();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
