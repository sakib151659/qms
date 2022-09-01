import 'package:flutter/material.dart';

import '../../utils/colors_for_app.dart';
import '../../utils/texts_for_app.dart';

class LocalDropDown extends StatefulWidget {
  final String hintText;
  final List dropDownList;
  final Function callBackFunction;

  const LocalDropDown({
    Key? key,
    required this.hintText,
    required this.dropDownList,
    required this.callBackFunction,
  }) : super(key: key);

  @override
  _LocalDropDownState createState() => _LocalDropDownState();
}

class _LocalDropDownState extends State<LocalDropDown> {
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: MyColors.secondaryTextColor, width: 1)),
      height: 47,
      child: DropdownButton(
        underline: const SizedBox(),

        items: widget.dropDownList
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                  ),
                  value: value,
                ))
            .toList(),
        ////////////////

        /////////////////
        onChanged: (selectedType) {
          setState(() {
            selectedValue = selectedType;
            widget.callBackFunction(selectedType);
          });
        },
        value: selectedValue,

        hint: Text(
          widget.hintText.isEmpty ? MyTexts.selectItem : widget.hintText,
          style: TextStyle(color: MyColors.secondaryTextColor),
        ),
        elevation: 8,
        style: TextStyle(color: Colors.grey[700], fontSize: 12),
        icon: const Icon(Icons.arrow_drop_down_outlined),
        iconEnabledColor: Colors.grey[700],
        isExpanded: true,
      ),
    );
  }
}
