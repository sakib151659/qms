import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qms/components/snackbar/custom_snackbar.dart';
import 'package:qms/screens/home/user/que_list_page.dart';
import 'package:qms/services/database.dart';

import '../../../components/appbar/appbar.dart';
import '../../../components/custom_dropdown/custom_dropdown.dart';
import '../../../components/custom_text_style/custom_text_style_class.dart';
import '../../../components/loading_screen/custom_loading.dart';
import '../../../models/user.dart';
import '../../../services/auth.dart';
import '../../../services/local_storage_manager.dart';
import '../../../utils/colors_for_app.dart';
import '../../../utils/texts_for_app.dart';
import '../../wrapper.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List <String> branchNameList = [MyTexts.branchA, MyTexts.branchB, MyTexts.branchC];
  List <String> counterNoList = [MyTexts.counter1,MyTexts.counter2, MyTexts.counter3];
  CollectionReference queRef = FirebaseFirestore.instance.collection("queTable");
  String branchName = "";
  String counterNo = "";
  String requestedBranchName = "";
  String requestedCounterNo = "";
  String requestedBranchNameValue = "";
  String requestedCounterNoValue = "";
  String currentUserEmail = "";
  String uid = "";
  int queLength = 0;
  bool isCounterVisible =false;
  bool showExistedQueData = false;
  final _formKey = GlobalKey<FormState>();
  void _branchNameCallback(value) {
    if (value != null) {
      setState(() {
        branchName = value.toString();
        isCounterVisible =true;
      });
    }
  }

  void _counterNoCallback(value) {
    if (value != null) {
      setState(() {
        counterNo = value.toString();
      });
    }
  }
  ////////////////////////////////////////
  void _check() async {
    final User? user = _auth.currentUser;
    final userid = user!.uid;
    // String userUid = await LocalStorageManager.readData(MyTexts.uid);
    // if(userUid.isNotEmpty){
    //   setState(() {
    //     uid = userUid;
    //   });
    // }else{
    //   setState(() {
    //     uid = MyTexts.na;
    //   });
    // }

    if(userid.isNotEmpty){
      setState(() {
        uid = userid;
      });
    }else{
      setState(() {
        uid = MyTexts.na;
      });
    }
    String userEmail = await LocalStorageManager.readData(MyTexts.email);
    if(userEmail.isNotEmpty){
      setState(() {
        currentUserEmail = userEmail;
      });
    }else{
      setState(() {
        currentUserEmail = MyTexts.na;
      });
    }
  }
   final FirebaseAuth _auth = FirebaseAuth.instance;
  // // Create an user object based on firebase user
  // CurrentUserModel? _userFromFirebaseUser(User user) {
  //   return  CurrentUserModel (uid: user.uid);
  // }
  //
  //
  // // auth change user stream
  // Stream<CurrentUserModel?> get user{
  //   return _auth.authStateChanges()
  //       .map((User? user) => _userFromFirebaseUser(user!));
  // }

  /////////////////////////
  void hasData(){
    FirebaseFirestore.instance
        .collection('queTable')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(uid);
        setState(() {
          showExistedQueData = true;
        });
      }
    });
  }

  void getQueLength()async{
    final QuerySnapshot qSnap = await FirebaseFirestore.instance.collection('queTable').get();
    final int documents = qSnap.docs.length;
    setState(() {
      queLength = documents;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _check();
    hasData();
    getQueLength();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "User Panel"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
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
              const SizedBox(height: 20,),
              showExistedQueData?_queDataShow():
              _requestForQue(),



            ],
          ),
        ),
      ),
    );
  }

  Widget _counterDesign({required String branchName, required String counterNo, required int total, required Color backgroundColor}){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(branchName),
          Text(counterNo),
          Text("Total : "+total.toString()),

        ],
      ),
    );
  }


  // dialog widget

  Future<void> _addCounter() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (builder) => AlertDialog(
        titlePadding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        insetPadding: const EdgeInsets.all(10),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request for que",
                    style: MyTextStyle.regularStyle(
                        fontColor: Colors.black, fontSize: 22),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
          ],
        ),
        scrollable: true,
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                ),

                Text(branchName),

                const SizedBox(
                  height: 15,
                ),

                LocalDropDown(
                    hintText: "Select Counter No",
                    dropDownList: counterNoList,
                    callBackFunction: _counterNoCallback
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            // dynamic result = await _auth.registerCounterWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim(), branchName, counterNo, MyTexts.counter) ;
                            // if(result == null){
                            //   // setState(() {
                            //   //   isLoading = false;
                            //   // });
                            //   CustomSnackBar(context: context, isSuccess: false, message: 'Please enter valid credentials!').show();
                            // }else{
                            //   CustomSnackBar(context: context, isSuccess: true, message: 'Registered successfully!').show();
                            //   _clearFields();
                            //   // setState(() {
                            //   //   isLoading = false;
                            //   // });
                            //
                            // }

                            await DatabaseService(uid: uid).setQueData(queLength+1, branchName, counterNo, currentUserEmail, MyTexts.requested);
                          }
                          Navigator.of(context, rootNavigator: true).pop();
                          hasData();
                        },
                        color: MyColors.customGreen,
                        height: 40,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.add_to_home_screen, color: Colors.white,),
                            Text("Register",
                              style: MyTextStyle.regularStyle(
                                fontColor: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          //_clearTextField();
                        },
                        color: Colors.red,
                        height: 40,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.close, color: Colors.white,),
                            Text("Cancel",
                              style: MyTextStyle.regularStyle(
                                fontColor: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stattusCard({required String branchAndCounter, required String status , required int slNo}){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.customOrange,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text("Requested for $branchAndCounter"),
          Text("Status : $status"),
          Text("Serial NO : "+slNo.toString()),
        ],
      ),
    );
  }




  // screen switch widgets
  Widget _requestForQue(){
    return Column(
      children: [
        LocalDropDown(
            hintText: "Select Branch Name",
            dropDownList: branchNameList,
            callBackFunction: _branchNameCallback
        ),
        const SizedBox(
          height: 15,
        ),

        Visibility(
            visible: isCounterVisible,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: _counterDesign(
                          branchName: branchName,
                          counterNo: "Counter 1",
                          total: 20,
                          backgroundColor: MyColors.customCyan),
                    ),

                    Expanded(
                      flex: 1,
                      child: _counterDesign(
                          branchName: branchName,
                          counterNo: "Counter 2",
                          total: 20,
                          backgroundColor: MyColors.customPink),
                    ),

                    Expanded(
                      flex: 1,
                      child: _counterDesign(
                          branchName: branchName,
                          counterNo: "Counter 3",
                          total: 20,
                          backgroundColor: MyColors.customYellow),
                    ),
                  ],
                ),

                const SizedBox(height: 10,),
                MaterialButton(
                  onPressed: (){
                    _addCounter();
                  },
                  color: MyColors.customGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_add, color: Colors.white,),
                      const SizedBox(width: 10,),
                      Text("Request for que", style: MyTextStyle.regularStyle(fontColor: Colors.white),)
                    ],),
                ),

              ],
            )
        ),
      ],
    );
  }



  Widget _queDataShow(){
    return Column(
      children: [
        StreamBuilder(
            stream: queRef.where(MyTexts.email, isEqualTo: currentUserEmail).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                //print(snapshot.data.documents.toString());

                return const SizedBox();

              }else if(snapshot.hasData){
                requestedBranchName = snapshot.data!.docs[0]["branchName"].toString();
                requestedCounterNo = snapshot.data!.docs[0]["counterNumber"].toString();
                return  _stattusCard(
                    branchAndCounter: snapshot.data!.docs[0]["branchName"].toString()+" , "+snapshot.data!.docs[0]["counterNumber"].toString(),
                    status: snapshot.data!.docs[0]["status"].toString(),
                    slNo: snapshot.data!.docs[0]["slNo"]
                );

              }
              return  const SizedBox();

            }
        ),

        MaterialButton(
          onPressed: (){
           setState(() {
             requestedBranchNameValue = requestedBranchName;
             requestedCounterNoValue = requestedCounterNo;
           });
          },
          color: MyColors.customGreen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, color: Colors.white,),
              const SizedBox(width: 10,),
              Text("See Que", style: MyTextStyle.regularStyle(fontColor: Colors.white),)
            ],),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Image.asset("assets/images/counter.png"),
        ),
        //Image.asset('assets/images/lake.jpg'),

        SizedBox(
          height: MediaQuery.of(context).size.height*.70,
          child: StreamBuilder(
              stream: queRef.where("status", isEqualTo: MyTexts.approved)
                  .where("branchName", isEqualTo: requestedBranchNameValue)
                  .where("counterNumber", isEqualTo: requestedCounterNoValue)
                  //.orderBy('slNo')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  //print(snapshot.data.documents.toString());
                 // CustomSnackBar(context: context, message: "Wait until approved", isSuccess: false).show();

                  return const SizedBox();

                }
                return  ListView(
                  children: snapshot.data!.docs.map((document){
                    return Container(
                      width: MediaQuery.of(context).size.width*.20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          document['email']==currentUserEmail?
                          Image.asset("assets/images/me_person.png", height: 70, width: 105,):
                          Image.asset("assets/images/single_person.png", height: 70, width: 105,),

                          document['email']==currentUserEmail?
                          Text('      You ( '+document['slNo'].toString()+" )",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              )):
                          Text('Serial No: '+document['slNo'].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              )),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
          ),
        )
      ],
    );
  }
}
