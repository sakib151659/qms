import 'package:flutter/material.dart';
import 'package:qms/components/custom_input_section/signin_custom_input_field.dart';
import 'package:qms/components/custom_text_style/custom_text_style_class.dart';
import 'package:qms/components/loading_screen/custom_loading.dart';
import 'package:qms/screens/designation_checker.dart';
import 'package:qms/screens/wrapper.dart';
import 'package:qms/utils/colors_for_app.dart';
import 'package:qms/utils/texts_for_app.dart';

import '../../components/snackbar/custom_snackbar.dart';
import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSecure = true;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading? const CustomLoading():
    Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      //color: Colors.black54,
                      borderRadius: const BorderRadius.all( Radius.circular(180 / 2)),
                      border: Border.all(
                        color: Colors.green,
                        width: 6.0,
                      ),
                    ),
                    child: const ClipOval(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.green,
                        size: 160,
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 20.0),

                const Text("SIGN IN",
                  style: TextStyle(color: MyColors.primaryTextColor, fontSize: 40.0, ),
                ),

                const SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      const SizedBox(height: 20.0),
                      MyTextFieldSignIn(
                        controller: passwordController,
                        textInputType: TextInputType.text,
                        prefix: const Icon(Icons.vpn_key_rounded),
                        suffix: _passwordVisibility(),
                        hintText: "Enter your password",
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
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),

                MaterialButton(
                  color: MyColors.customGreen,
                    onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());
                      if(result == null){
                        setState(() {
                          isLoading = false;
                        });

                        CustomSnackBar(context: context, isSuccess: false, message: 'Invalid Credentials!').show();
                      }else{
                        CustomSnackBar(context: context, isSuccess: true, message: 'Signed in successfully!').show();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Wrapper())) ;

                        setState(() {
                          isLoading = false;
                        });
                      }
                    }

                    },
                  child: Text(MyTexts.signIn, style: MyTextStyle.regularStyle(fontColor: Colors.white), ),
                ),

                const SizedBox(height: 30.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const FittedBox(
                        child: Text(
                          "Don't have an Account?",
                          style: TextStyle(color: MyColors.primaryTextColor, fontSize: 15.0),
                        ),
                      ),
                      InkWell(
                        child: const FittedBox(
                          child: Text(
                            " SIGN UP",
                            style: TextStyle(color: Colors.orange, fontSize: 19.0, ),
                          ),
                        ),
                        onTap: () async{
                          widget.toggleView();
                        },
                      ),


                    ],
                  ),
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
