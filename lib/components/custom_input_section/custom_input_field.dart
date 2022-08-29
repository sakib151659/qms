import 'package:flutter/material.dart';
import '../../utils/colors_for_app.dart';
import '../custom_text_style/custom_text_style_class.dart';

class MyTextField extends StatefulWidget {
  final bool isSecure;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Widget prefix;
  final Widget suffix;
  final String hintText;
  final String? Function(String?)? validatorFunction;
  const MyTextField(
      {Key? key,
      this.isSecure = false,
      required this.controller,
      required this.textInputType,
      required this.prefix,
      required this.suffix,
      required this.hintText,
      this.validatorFunction
      })
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validatorFunction,
      style: MyTextStyle.regularStyle(fontSize: 13),
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isSecure,
      cursorColor: MyColors.secondaryColor,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: widget.hintText,

        hintStyle: MyTextStyle.regularStyle(
            fontColor: MyColors.secondaryTextColor, fontSize: 13),
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: MyColors.secondaryTextColor,
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: MyColors.secondaryColor,
            width: 0.9,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.9,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.9,
          ),
        ),
      ),
    );
  }
}
