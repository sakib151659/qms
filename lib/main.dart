import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qms/screens/wrapper.dart';
import 'package:qms/utils/colors_for_app.dart';

import 'components/custom_text_style/custom_text_style_class.dart';


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
    return const MaterialApp(
        home: SplashScreen(),

    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("QMS",
              style: MyTextStyle.regularStyle4(
                  fontColor: MyColors.primaryTextColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w600
              ),),
            Text("Que Management System",
              style: MyTextStyle.regularStyle4(
                  fontColor: MyColors.primaryTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),),
          ],
        )
      ),
    );
  }
}
