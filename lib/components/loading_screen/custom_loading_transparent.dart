import 'package:flutter/material.dart';
import 'package:qms/utils/colors_for_app.dart';

class CustomLoadingTransparent extends StatelessWidget {
  const CustomLoadingTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black38,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
