import 'package:flutter/material.dart';
import 'package:qms/utils/colors_for_app.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
