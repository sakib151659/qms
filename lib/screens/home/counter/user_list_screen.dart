import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_text_style/custom_text_style_class.dart';
import '../../../components/loading_screen/custom_loading.dart';
import '../../../utils/colors_for_app.dart';
import '../../../utils/texts_for_app.dart';

class UserListScreen extends StatefulWidget {
  final String branchName;
  final String counterNumber;
  final String status;
  final String buttonTitle;
  final Function() acceptFunction;
  final Function() rejectFunction;

  const UserListScreen({Key? key,
    required this.branchName,
    required this.counterNumber,
    required this.status,
    required this.buttonTitle,
    required this.acceptFunction,
    required this.rejectFunction

  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  CollectionReference regRef = FirebaseFirestore.instance.collection("queTable");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: regRef
            .where(MyTexts.branchName, isEqualTo: widget.branchName)
            .where(MyTexts.counterNumber, isEqualTo: widget.counterNumber)
            .where(MyTexts.status, isEqualTo: widget.status)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            //print(snapshot.data.documents.toString());

            return const CustomLoading();

          }
          return  ListView(
            children: snapshot.data!.docs.map((document){
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(document['email'],
                        style: const TextStyle(
                          color: MyColors.primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    const SizedBox(height: 5,),

                    Text(document[MyTexts.branchName].toString() +' , ' + document[MyTexts.counterNumber].toString(),
                        style: const TextStyle(
                          color: MyColors.primaryTextColor,
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                          //letterSpacing: 2,
                        )),
                    const SizedBox(height: 5,),
                    Text("Status : "+document['status'],
                        style: const TextStyle(
                          color: MyColors.primaryTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25, width: 100,
                          child: MaterialButton(
                            color:MyColors.editIconBG,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.done, color: MyColors.editIcon, size: 12,),
                                const SizedBox(width: 3,),
                                Text(widget.buttonTitle, style: MyTextStyle.regularStyle(fontSize: 12),),
                              ],
                            ),
                            onPressed: widget.acceptFunction,
                          ),
                        ),

                        const SizedBox(width: 10,),
                        SizedBox(
                          height: 25, width: 100,
                          child: MaterialButton(
                            color:MyColors.deleteBackground,
                            onPressed: widget.rejectFunction,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.close, color: MyColors.deleteIcon, size: 12,),
                                const SizedBox(width: 3,),
                                Text("Reject", style: MyTextStyle.regularStyle(fontSize: 12),),
                              ],
                            ),

                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        }
    );
  }
}
