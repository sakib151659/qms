import 'package:flutter/material.dart';
import 'package:qms/components/snackbar/custom_snackbar.dart';
import '../../components/custom_input_section/signin_custom_input_field.dart';
import '../../components/custom_text_style/custom_text_style_class.dart';
import '../../services/auth.dart';
import '../../utils/colors_for_app.dart';
import '../../utils/texts_for_app.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  const SignUp({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSecure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        color:  MyColors.customOrange,
                        width: 6.0,
                      ),
                    ),
                    child: const ClipOval(
                      child: Icon(
                        Icons.person_rounded,
                        color: MyColors.customOrange,
                        size: 160,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                const Text("SIGN UP",
                  style: TextStyle(color: Colors.white, fontSize: 40.0, ),
                ),

                const SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFieldSignIn(
                        controller: nameController,
                        textInputType: TextInputType.text,
                        prefix: const Icon(Icons.person),
                        suffix: const SizedBox(),
                        hintText: "Enter your Name",
                        validatorFunction: (value){
                          if(value == null || value.isEmpty){
                            return "Field can not be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),

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
                        prefix: const Icon(Icons.lock),
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
                  color: MyColors.customOrange,
                  onPressed: ()async {
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.registerWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim()) ;
                      if(result == null){
                        setState(() {
                          //loading = false;
                        });

                        CustomSnackBar(context: context, isSuccess: false, message: 'Please enter a valid email!').show();
                      }else{
                        CustomSnackBar(context: context, isSuccess: true, message: 'Registered successfully!').show();
                      }
                    }

                  },
                  child: Text(MyTexts.signUp, style: MyTextStyle.regularStyle(fontColor: Colors.white), ),
                ),

                const SizedBox(height: 30.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const FittedBox(
                        child: Text(
                          "Already have an Account?",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                      InkWell(
                        child: const FittedBox(
                          child: Text(
                            " SIGN IN",
                            style: TextStyle(color: Colors.green, fontSize: 19.0, ),
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
