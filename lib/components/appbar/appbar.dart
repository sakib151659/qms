
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

      TextButton.icon(
          onPressed: () async {
            await AuthService().signOut();
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          label: const Text("Logout", style: TextStyle(color: Colors.white),)
      )
    ],
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 22),),

  );
 }
}