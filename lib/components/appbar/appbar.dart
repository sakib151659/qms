
import 'package:flutter/material.dart';
import 'package:qms/services/auth.dart';
import 'package:qms/utils/colors_for_app.dart';

class CustomAppbar{
  final AuthService _auth = AuthService();
static getAppBar(BuildContext context, String title) {

  return AppBar(
    //backwardsCompatibility: false,
    //systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
    backgroundColor: MyColors.secondaryColor,
    elevation: 1,
    actions: [
      IconButton(
          icon: const Icon(
            Icons.logout,
            color: MyColors.customOrange,
          ),
          onPressed: () async {
            await AuthService().signOut();
          }),
    ],
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 22),),

  );
 }
}
