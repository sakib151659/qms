import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qms/utils/texts_for_app.dart';


//var now = Jiffy().format("yyyy-MM-dd HH:mm:ss");
class DataController extends GetxController{
  Future getData(String collection) async{
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }


  static Future <QuerySnapshot<Map<String, dynamic>>>getIsCounter(String queryEmail, ) async{
    return await FirebaseFirestore.instance.collection('registerTableCounter')
        .where('email', isEqualTo: queryEmail)
        .where('designation', isEqualTo: MyTexts.counter)
        .get();
  }

  static Future <QuerySnapshot<Map<String, dynamic>>>getIsUser(String queryEmail, ) async{
    return FirebaseFirestore.instance.collection('registerTableUser')
        .where('email', isEqualTo: queryEmail)
        .where('designation', isEqualTo: MyTexts.user)
        .get();
  }

  // Future queryMobile(String queryString) async{
  //   return Firestore.instance.collection('scammer').where(
  //       'mobileNumber', isEqualTo:queryString
  //   ).getDocuments();
  // }
  //
  // Future queryPaidNumber(String queryString) async{
  //   return Firestore.instance.collection('scammer').where(
  //       'paidNumber', isEqualTo:queryString
  //   ).getDocuments();
  // }
  //
  // Future queryScammerEmail(String queryString) async{
  //   return Firestore.instance.collection('scammer').where(
  //       'email', isEqualTo:queryString
  //   ).getDocuments();
  // }
  //
  // Future queryMobile2(String queryString) async{
  //   return Firestore.instance.collection('scammer').where(
  //       'mobileNumber', isGreaterThan:queryString
  //   ).getDocuments();
  // }
  //
  // Future queryPaidNumber2(String queryString) async{
  //   return Firestore.instance.collection('scammer').where(
  //       'paidNumber', isGreaterThan:queryString
  //   ).getDocuments();
  // }
  //
  // Future queryEmailStatus(String queryEmail, ) async{
  //   //String now = Jiffy().format("dd/MM/yyy");
  //   return Firestore.instance.collection('Payment')
  //       .where('email', isEqualTo: queryEmail)
  //       .where('status', isEqualTo: 'confirmed')
  //   //.where('expireDate', isLessThanOrEqualTo: now)
  //       .getDocuments();
  // }
  //
  // Future queryEmailStatusUnconfirmed(String queryEmail, ) async{
  //   return Firestore.instance.collection('Payment')
  //       .where('email', isEqualTo: queryEmail)
  //       .where('status', isEqualTo: 'unconfirmed')
  //       .getDocuments();
  // }
  //
  // Future queryEmailStatusExpired(String queryEmail, ) async{
  //   return Firestore.instance.collection('Payment')
  //       .where('email', isEqualTo: queryEmail)
  //       .where('status', isEqualTo: 'expired')
  //       .getDocuments();
  // }
  //
  // Future queryUserJoiningDate(String queryEmail, ) async{
  //   String now = Jiffy().format("dd/MM/yyy");
  //   return Firestore.instance.collection('users')
  //       .where('email', isEqualTo: queryEmail)
  //       .where('joiningDate', isEqualTo: now)
  //       .getDocuments();
  // }


}
