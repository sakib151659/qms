import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'auth/authenticate.dart';
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //final user = Provider.of<User>(context);


    // if (user == null){
    //   return Authenticate();
    // } else {
    //   //return Home();
    //   //return mainNavigation();
    //   return Authenticate();  // just for test
    // }
    return Authenticate();
  }
}