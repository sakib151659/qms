import 'package:flutter/material.dart';
import 'package:qms/services/dataController.dart';

import 'home/admin/admin.dart';
import 'home/counter/counter.dart';
import 'home/user/user.dart';
class DesignationChecker extends StatefulWidget {
  final String currentUserEmail;
  const DesignationChecker({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  State<DesignationChecker> createState() => _DesignationCheckerState();
}

class _DesignationCheckerState extends State<DesignationChecker> {
  bool isAdmin = false;
  bool isUser = false;
  bool isCounter = false;

  int count = 0;

  @override
  Widget build(BuildContext context) {
     if (count<1) {
       DataController.getIsAdmin(widget.currentUserEmail).then((value) => {
             if (value.docs.toList().isNotEmpty)
               {
                 print(value.docs.toString()),
                 print("admin"),

                 setState(() {
                   isAdmin = true;
                   isCounter = false;
                   isUser = false;
                 }),
               }
           });

       DataController.getIsCounter(widget.currentUserEmail).then((value) => {
         if (value.docs.toList().isNotEmpty)
           {
             print(value.docs.toList()),
             print("counter"),
             setState(() {
               isAdmin = false;
               isCounter = true;
               isUser = false;
             }),
           }
       });

       DataController.getIsUser(widget.currentUserEmail).then((value) => {
             if (value.docs.toList().isNotEmpty)
               {
                 print(value.docs.toList()),
                 print("user"),
                 setState(() {
                   isAdmin = false;
                   isCounter = false;
                   isUser = true;
                 }),
               }
           });
     }
     count++;
    return isAdmin? Admin() : isCounter ? CounterPage() : UserPage();
  }
}
