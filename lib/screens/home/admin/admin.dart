import 'package:flutter/material.dart';
import 'package:qms/components/appbar/appbar.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.getAppBar(context, "Admin Panel"),
    );
  }
}
