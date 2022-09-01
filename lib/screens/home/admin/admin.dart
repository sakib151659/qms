import 'package:flutter/material.dart';
import 'package:qms/components/appbar/appbar.dart';
import 'package:qms/components/custom_text_style/custom_text_style_class.dart';
import 'package:qms/utils/colors_for_app.dart';

import '../../../components/custom_input_section/signin_custom_input_field.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: CustomAppbar.getAppBar(context, "Admin Panel"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
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
            )
          ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
              ),




              const SizedBox(
                height: 15,
              ),
              MyTextFieldSignIn(
                controller: emailController,
                textInputType: TextInputType.text,
                prefix: const Icon(Icons.email),
                suffix: const SizedBox(),
                hintText: "Enter your Email",
                validatorFunction: (value){
                  if(value == null || value.isEmpty){
                    return "Field can not be empty";
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                        }
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      color: Colors.orangeAccent,
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
                          const Icon(Icons.person_add, color: Colors.white,),
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
    );
  }

}
