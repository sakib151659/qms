import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qms/components/appbar/appbar.dart';
import 'package:qms/components/custom_dropdown/custom_dropdown.dart';
import 'package:qms/components/custom_text_style/custom_text_style_class.dart';
import 'package:qms/utils/colors_for_app.dart';
import 'package:qms/utils/texts_for_app.dart';

import '../../../components/custom_input_section/signin_custom_input_field.dart';
import '../../../components/loading_screen/custom_loading.dart';
import '../../../components/snackbar/custom_snackbar.dart';
import '../../../models/counter_model.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List <String> branchNameList = [MyTexts.branchA, MyTexts.branchB, MyTexts.branchC];
  List <String> counterNoList = [MyTexts.counter1,MyTexts.counter2, MyTexts.counter3];
  CollectionReference regRef = FirebaseFirestore.instance.collection("registerTableCounter");
  String branchName = "";
  String counterNo = "";
  bool isSecure = true;
  final AuthService _auth = AuthService();
  void _branchNameCallback(value) {
    if (value != null) {
      setState(() {
        branchName = value.toString();
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

  void _clearFields(){
    emailController.clear();
    passwordController.clear();
    branchName = "";
    counterNo = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "Admin Panel"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
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
                  const SizedBox(height: 20,),
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
                      Text("Add Counter", style: MyTextStyle.regularStyle(fontColor: Colors.white),)
                    ],),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),


              // StreamBuilder(
              //   stream: regRef.snapshots(),
              //     builder: (context, snapshot){
              //     if(snapshot.hasError){
              //       return Text("Error");
              //      }
              //     if(snapshot.hasData){
              //       return ListView.builder(
              //         itemCount: snapshot.data.toString().length,
              //           itemBuilder: (context, index){
              //           DocumentSnapshot doc = snapshot.data!.;
              //           return Text("${snapshot.data!.d}");
              //           });
              //        }
              //     return Text("loading");
              //     }
              //
              // ),

              Text("All Counters",
                style: MyTextStyle.regularStyle4(
                    fontColor: MyColors.primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),),

              const SizedBox(height: 10,),
              SizedBox(
                height: MediaQuery.of(context).size.height*.57,
                child: StreamBuilder(
                    stream: regRef.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData){
                        //print(snapshot.data.documents.toString());

                        return const CustomLoading();

                      }
                      return  ListView(
                        children: snapshot.data!.docs.map((document){
                          return Card(
                            color: Colors.white,
                            elevation: 2,
                            margin:const EdgeInsets.symmetric(vertical: 7),
                            child: Column(
                              children: [
                                ListTile(
                                  leading:const Icon(Icons.person, size: 30, color: MyColors.customOrange,),
                                  title: Text('\n'+document['email'],
                                      style: const TextStyle(
                                        color: MyColors.primaryTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  subtitle: Text('\n'+document[MyTexts.branchName].toString() +' , ' + document[MyTexts.counterNumber].toString()+'\n',
                                      style: const TextStyle(
                                        color: MyColors.primaryTextColor,
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        letterSpacing: 2,
                                      )),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                ),
              )




            ],
          ),
        ),
      ),
    );
  }

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
                  Text("Register Counter",
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
                // const SizedBox(
                //   height: 15,
                // ),
                LocalDropDown(
                    hintText: "Select Branch Name",
                    dropDownList: branchNameList,
                    callBackFunction: _branchNameCallback
                ),
                const SizedBox(
                  height: 15,
                ),

                LocalDropDown(
                    hintText: "Select Counter No",
                    dropDownList: counterNoList,
                    callBackFunction: _counterNoCallback
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextFieldSignIn(
                  controller: emailController,
                  textInputType: TextInputType.text,
                  prefix: const Icon(Icons.email),
                  suffix: const SizedBox(),
                  hintText: "Enter an email for counter",
                  validatorFunction: (value){
                    if(value == null || value.isEmpty){
                      return "Field can not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextFieldSignIn(
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  prefix: const Icon(Icons.lock),
                  suffix: _passwordVisibility(),
                  hintText: "Enter an password for counter",
                  isSecure: isSecure,
                  validatorFunction: (value){
                    if(value == null || value.isEmpty){
                      return "Field can not be empty";
                    }
                    else if(value.length < 8){
                      return "Password less than 8";
                    }
                    return null;
                  },
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
                            dynamic result = await _auth.registerCounterWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim(), branchName, counterNo, MyTexts.counter) ;
                            if(result == null){
                              // setState(() {
                              //   isLoading = false;
                              // });
                              CustomSnackBar(context: context, isSuccess: false, message: 'Please enter valid credentials!').show();
                            }else{
                              CustomSnackBar(context: context, isSuccess: true, message: 'Registered successfully!').show();
                              _clearFields();
                              // setState(() {
                              //   isLoading = false;
                              // });

                            }
                          }
                          Navigator.of(context, rootNavigator: true).pop();
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

  Widget _passwordVisibility() {
    return InkWell(
      onTap: () {
        setState(() {
          isSecure = !isSecure;
        });
      },
      child: Icon(isSecure ? Icons.visibility_off : Icons.visibility, size: 18),
    );
  }

}
