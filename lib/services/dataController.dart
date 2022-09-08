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

}
