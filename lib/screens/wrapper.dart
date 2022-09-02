import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qms/screens/designation_checker.dart';
import 'package:qms/services/local_storage_manager.dart';
import 'package:qms/utils/texts_for_app.dart';
import 'auth/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // @override
  String currentUserEmail = '';

  bool isAdmin = false;

  bool isUser = false;

  bool isCounter = false;

  //String userEmail = LocalStorageManager.readData(MyTexts.email).toString();


  void check() async {}
  int count = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            //checking user either signed in or signed out
            if (snapshot.hasData) {

              final user = FirebaseAuth.instance.currentUser!;
              currentUserEmail = user.email.toString();

              print(currentUserEmail);

              return DesignationChecker(currentUserEmail: currentUserEmail,);
            } else {
              return const Authenticate();
            }
          },
        ),
      );
}
