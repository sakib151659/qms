import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../components/loading_screen/custom_loading.dart';
import '../../../utils/colors_for_app.dart';
import '../../../utils/texts_for_app.dart';

class UserListScreen extends StatefulWidget {
  final String branchName;
  final String counterNumber;
  final String status;
  const UserListScreen({Key? key,
    required this.branchName,
    required this.counterNumber,
    required this.status
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
              return Card(
                color: Colors.black54,
                child: Column(
                  children: [
                    ListTile(
                      leading:const Icon(Icons.person, size: 30, color: MyColors.customOrange,),
                      title: Text('\n'+document['email'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                      subtitle: Text('\n'+document[MyTexts.branchName].toString() +' , ' + document[MyTexts.counterNumber].toString()+'\n',
                          style: const TextStyle(
                            color: Colors.white,
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
    );
  }
}
