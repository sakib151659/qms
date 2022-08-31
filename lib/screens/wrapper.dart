import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qms/screens/home/admin/admin.dart';
import '../models/user.dart';
import 'auth/authenticate.dart';
class Wrapper extends StatelessWidget {

  // @override
  // Widget build(BuildContext context) {
  //   final user = Provider.of<CurrentUserModel?>(context);
  //   //final CurrentUserModel user = Provider.of<CurrentUserModel?>(context);
  //
  //   if (user == null){
  //     return const Authenticate();
  //   } else {
  //     //return Home();
  //     //return mainNavigation();
  //     return const Admin();  // just for test
  //   }
  //   //return const Authenticate();
  // }


  @override
  Widget build(BuildContext context) =>Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Admin();
        }
        else{
          return Authenticate();
        }
      },
    ),
  );
}