import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  //final String email;
  DatabaseService({required this.uid});
  //add counter information
  final CollectionReference collectionOfRegisterTableCounter= FirebaseFirestore.instance.collection('registerTableCounter');
  Future updateRegisterTableCounter(String email, String branchName, String counterNumber, String designation) async {
    return await collectionOfRegisterTableCounter.doc(uid).set({
      'branchName' : branchName,
      'counterNumber' : counterNumber,
      'email' : email,
      'designation' : designation
    });
  }


  //add users information
  final CollectionReference collectionOfRegisterTableUser= FirebaseFirestore.instance.collection('registerTableUser');
  Future updateRegisterTableUser(String userName, String email, String designation) async {
    return await collectionOfRegisterTableUser.doc(uid).set({
      'userName' : userName,
      'email' : email,
      'designation' : designation
    });
  }


//request que table

  final CollectionReference queCollection = FirebaseFirestore.instance.collection('queTable');
  Future setQueData(
      int slNo ,
      String branchName,
      String counterNumber,
      String email,
      String status
      ) async {
    return await queCollection.doc(uid).set({
      'slNo' : slNo,
      'branchName' : branchName,
      'counterNumber' : counterNumber,
      'email' : email,
      'status' : status
    });
  }

}