import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/appbar/appbar.dart';
import '../../../services/auth.dart';
import '../../../services/local_storage_manager.dart';
import '../../../utils/colors_for_app.dart';
import '../../../utils/texts_for_app.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  String counterOfficerBranchName = "";
  String counterOfficerCounterNumber = "";
  String userId = FirebaseAuth.instance.currentUser!.uid;

  void _getCounterInfo()async {
    print("userId counter : $userId");
    final collection = FirebaseFirestore.instance.collection('registerTableCounter');
    final docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final valueBranch = data?[MyTexts.branchName];
      final valueCounter = data?[MyTexts.counterNumber];

      setState(() {
        counterOfficerBranchName = valueBranch;
        counterOfficerCounterNumber = valueCounter;
      });

      print(counterOfficerBranchName);
      print(counterOfficerCounterNumber);

      // Call setState if needed.
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    _getCounterInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "Counter Panel"),
    );
  }
}
