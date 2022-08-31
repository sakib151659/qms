import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qms/models/user.dart';
import 'package:qms/screens/wrapper.dart';
import 'package:qms/services/auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<CurrentUserModel?>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     home: Wrapper(),
    //   ),
    // );
    return MaterialApp(
        home: Wrapper(),

    );
  }
}

