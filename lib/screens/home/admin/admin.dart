import 'package:flutter/material.dart';
import 'package:qms/components/appbar/appbar.dart';
import 'package:qms/utils/colors_for_app.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "Admin Panel"),
    );
  }
}
