import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/constants/constant_config.dart';
import 'package:transaction_dispute/widgets/custom_toast.dart';

class CustomBottomSheet extends StatefulWidget {
  final String content;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Function(String)? onReasonSubmitted;
  final bool isSuccessSheet;

  const CustomBottomSheet({
    super.key,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirm,
    this.onCancel,
    this.onReasonSubmitted,
    required this.isSuccessSheet,
  });

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _closeBottomSheet() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSuccessSheet) {
      Future.delayed(Duration(seconds: 3), _closeBottomSheet);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 30,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SizedBox(
        height: widget.isSuccessSheet ? 300 : 350,
        child: widget.isSuccessSheet
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AssetConstants.animatedSuccess,
                    repeat: false,
                    reverse: true,
                    width: 100,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.content,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.content,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _reasonController,
                    decoration: InputDecoration(
                      labelText: StringConstant.enterReasonDispute,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onCancel?.call();
                        },
                        child: Text(
                          StringConstant.cancel,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final reason = _reasonController.text.trim();
                          if (reason.isNotEmpty) {
                            Navigator.pop(context);
                            widget.onReasonSubmitted?.call(reason);
                            widget.onConfirm();
                          } else {
                            CustomToast.show(StringConstant.enterReasonToast);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorFile.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.confirmButtonText,
                            style: TextStyle(color: ColorFile.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
