import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qms/screens/home/counter/user_list_screen.dart';

import '../../../components/appbar/appbar.dart';
import '../../../components/custom_text_style/custom_text_style_class.dart';
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
  bool isRequestedSelected = true;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15,),
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
              Text(counterOfficerBranchName +" , "+counterOfficerCounterNumber,
                style: MyTextStyle.regularStyle4(
                    fontColor: MyColors.primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                ),),
              const SizedBox(height: 20,),


              // Tab bar Container
              Row(
                children: <Widget>[
                  Expanded(
                    flex:1,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isRequestedSelected? MyColors.secondaryColor : Colors.white,
                          border: isRequestedSelected? Border.all(width: 1, color: MyColors.secondaryColor) : Border.all(width: 1, color: MyColors.secondaryTextColor),
                        ),
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(width: 5,),
                            Icon(Icons.list,color: isRequestedSelected?Colors.white :  MyColors.primaryTextColor , size: 18,),
                            const SizedBox(width: 5,),
                            Text("Requested",
                              style: MyTextStyle.regularStyle(fontColor: isRequestedSelected? Colors.white :  MyColors.primaryTextColor, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          isRequestedSelected = true;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isRequestedSelected? Colors.white : MyColors.secondaryColor,
                          border: isRequestedSelected? Border.all(width: 1, color: MyColors.secondaryTextColor) : Border.all(width: 1, color: MyColors.secondaryColor),
                        ),
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(width: 5,),
                            Icon(Icons.list_alt,color: isRequestedSelected? MyColors.primaryTextColor : Colors.white, size: 18,),
                            const SizedBox(width: 5,),
                            Text("Task",
                              style: MyTextStyle.regularStyle(fontColor: isRequestedSelected? MyColors.primaryTextColor : Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          isRequestedSelected = false;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              isRequestedSelected?
              SizedBox(
                height: MediaQuery.of(context).size.height*.65,
                  child: UserListScreen(
                    branchName: counterOfficerBranchName,
                    counterNumber: counterOfficerCounterNumber,
                    status: MyTexts.requested,
                    buttonTitle: "Approve",
                    updateButtonStatus: MyTexts.approved,
                  )):
              SizedBox(
                height: MediaQuery.of(context).size.height*.65,
                  child: UserListScreen(
                    branchName: counterOfficerBranchName,
                    counterNumber: counterOfficerCounterNumber,
                    status: MyTexts.approved,
                    buttonTitle: "Complete",
                    updateButtonStatus: MyTexts.complete,
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
