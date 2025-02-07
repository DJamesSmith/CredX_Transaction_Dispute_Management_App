import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/constants/string_constant.dart';
import 'package:transaction_dispute/controllers/transaction_controller.dart';
import 'package:transaction_dispute/utils/data.dart';
import 'package:transaction_dispute/widgets/custom_bottom_sheet.dart';

class AppComponents {
  Widget services(BuildContext context) {
    return Container(
      color: ColorFile.grey50,
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 20, bottom: 60),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: creditCardServices.length,
        separatorBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        itemBuilder: (context, index) {
          final creditCardService = creditCardServices[index];
          return Container(
            constraints: BoxConstraints(minHeight: 50),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(creditCardService)),
                Image.network(
                  StringConstant.rightArrowIcon,
                  height: 12,
                  width: 12,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget accountDetails(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Obx(() {
      final selectedCardId = transactionController.selectedCardId.value;
      final selectedCard = cardData.firstWhere(
        (card) => card['id'] == selectedCardId,
        orElse: () => {},
      );

      if (selectedCard == null) {
        return Center(child: Text(StringConstant.noCardSelected));
      }

      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorFile.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorFile.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstant.cardholderName,
              style: TextStyle(
                fontSize: 14,
                color: ColorFile.grey,
              ),
            ),
            SizedBox(height: 5),
            Text(
              (selectedCard['name'] as String?) ?? StringConstant.notApplicable,
            ),
            SizedBox(height: 15),
            Text(StringConstant.cardNumber,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorFile.grey,
                )),
            SizedBox(height: 5),
            Text(
              (selectedCard['cardNumber'] as String?) ??
                  StringConstant.notApplicable,
            ),
            SizedBox(height: 15),
            Text(
              StringConstant.dueAmount,
              style: TextStyle(
                fontSize: 14,
                color: ColorFile.grey,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${StringConstant.rupee} ${selectedCard['dueAmount']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorFile.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(),
            ),
            Text(
              StringConstant.availableCredQ,
              style: TextStyle(fontSize: 14, color: ColorFile.grey),
            ),
            SizedBox(height: 5),
            Text(
              StringConstant.availableCred,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorFile.green,
              ),
            ),
            SizedBox(height: 15),
            Text(
              StringConstant.billDate,
              style: TextStyle(fontSize: 14, color: ColorFile.grey),
            ),
            SizedBox(height: 5),
            Text(
              StringConstant.billDateQ,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final transactionController = Get.find<TransactionController>();
      transactionController.filterTransactionsByDateRange(
          picked.start, picked.end);
    }
  }

  Future<void> showSuccessBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          content: StringConstant.disputeProcessStatement,
          confirmButtonText: StringConstant.ok,
          onConfirm: () {
            debugPrint(StringConstant.disputeSuccessToast);
          },
          isSuccessSheet: true,
        );
      },
    );
  }
}
