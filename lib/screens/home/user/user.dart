import 'package:flutter/material.dart';
import 'package:qms/screens/home/user/que_list_page.dart';

import '../../../components/appbar/appbar.dart';
import '../../../components/custom_dropdown/custom_dropdown.dart';
import '../../../components/custom_text_style/custom_text_style_class.dart';
import '../../../services/auth.dart';
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
  String branchName = "";
  String counterNo = "";
  bool isCounterVisible =false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "User Panel"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              counterNo: "Counter 1",
                              total: 20,
                              backgroundColor: MyColors.customPink),
                        ),

                        Expanded(
                          flex: 1,
                          child: _counterDesign(
                              branchName: branchName,
                              counterNo: "Counter 1",
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
}
