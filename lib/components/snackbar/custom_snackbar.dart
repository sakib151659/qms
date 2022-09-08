import 'package:flutter/material.dart';
class CustomSnackBar {
  final BuildContext? context;
  final String? message;
  final bool? isSuccess;
  CustomSnackBar({
    this.context,
    this.message,
    this.isSuccess,
  });
  show() {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  //width: 30,
                  child: Icon(
                    isSuccess! ? Icons.check : Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSuccess! ? Colors.green : Colors.red,
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: SizedBox(
                  //width: MediaQuery.of(context!).size.width*.75,
                  child: Text(message != null ? message! : "Something Went Wrong",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSuccess! ? Colors.green : Colors.red,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ),
      ));
  }
}