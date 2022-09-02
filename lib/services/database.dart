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


//add Scammers information

//   final CollectionReference scammerCollection = Firestore.instance.collection('scammer');
//   Future setScammerData(String name ,String mobileNumber, String scamType,  String paidNumber, String email, String socialMedia, String description, String postDate , String postedBy) async {
//     return await scammerCollection.document(uid).setData({
//       'name' : name,
//       'mobileNumber' : mobileNumber,
//       'scamType' : scamType,
//       'paidNumber' : paidNumber,
//       'email' : email,
//       'socialMedia' : socialMedia,
//       'description' : description,
//       'postDate' : postDate,
//       'postedBy' : postedBy,
//
//     });
//   }
//
//
// //add Payment information
//   final CollectionReference paymentCollection = Firestore.instance.collection('Payment');
//   Future setPaymentData(String paymentMethod , String packageType, String startDate, String expireDate, int payableAmount, int paidAmount, String status, String paidNumber, String transactionID, String email, ) async {
//     return await paymentCollection.document(uid).setData({
//       'paymentMethod' : paymentMethod,
//       'packageType' : packageType,
//       'startDate' : startDate,
//       'expireDate' : expireDate,
//       'payableAmount' : payableAmount,
//       'paidAmount' : paidAmount,
//       'status' : status,
//       'paidNumber' : paidNumber,
//       'transactionID' : transactionID,
//       'email' : email,
//     });
//   }
//
//
// //add withdraw information
//   final CollectionReference withdrawCollection = Firestore.instance.collection('Withdraw');
//   Future setWithdrawData(String paymentMethod , String withdrawRequestDate, int payableAmount, int creditAmount, String status, String moneyReceiveNumber, String email, ) async {
//     return await withdrawCollection.document(uid).setData({
//       'paymentMethod' : paymentMethod,
//       'withdrawRequestDate' : withdrawRequestDate,
//       'payableAmount' : payableAmount,
//       'creditAmount' : creditAmount,
//       'status' : status,
//       'moneyReceiveNumber' : moneyReceiveNumber,
//       'email' : email,
//     });
//   }
//
//   //add reported scammer
//   final CollectionReference reportedScammerCollection = Firestore.instance.collection('reportedScammer');
//   Future setReportedScammer(String mobileNumber, String paidNumber, String scammerEmail, int numberOfReport, String reportType, String comment, String reportedBy, String status , String reportDate) async {
//     return await reportedScammerCollection.document(uid).setData({
//       'scammerMobileNumber' : mobileNumber,
//       'scammerPaidNumber' : paidNumber,
//       'scammerEmail' : scammerEmail,
//       'numberOfReport' : numberOfReport,
//       'reportType' : reportType,
//       'reporterComment' : comment,
//       'reportedBy' : reportedBy,
//       'status' : status,
//       'reportDate' : reportDate,
//     });
//   }
//
//
//   final _auth = FirebaseAuth.instance;
//   dynamic user;
//   //String userEmail;
//   Future getCurrentUserInfo() async {
//     user = await _auth.currentUser();
//     String userEmail = user.email;
//     return userEmail;
//   }
//
//
//
//
//
//   //Userdata from snapshot for personal profile
//   UserData _userDataSnapshot(DocumentSnapshot snapshot){
//     return UserData(
//       uid: uid,
//       name: snapshot.data['name'],
//       email: snapshot.data['email'],
//       credit: snapshot.data['credit'],
//     );
//   }
//
//   // get user data for personal profile
//   Stream<UserData> get userData  {
//     return userCollection.document(uid).snapshots()
//         .map(_userDataSnapshot);
//   }
//
//
//   UserDataForCreditPayment _userDataSnapshot2(DocumentSnapshot snapshot){
//     return UserDataForCreditPayment(
//       uid: uid,
//       name: snapshot.data['name'],
//       email: snapshot.data['email'],
//       credit: snapshot.data['credit'],
//       mobileNumber: snapshot.data['mobileNumber'],
//       gender: snapshot.data['gender'],
//       joiningDate: snapshot.data['joiningDate'],
//       address: snapshot.data['address'],
//     );
//   }
//
//   Stream<UserDataForCreditPayment> get userDataForCreditPayment  {
//     return userCollection.document(uid).snapshots()
//         .map(_userDataSnapshot2);
//   }
//
//
//
//
//   UserDataForProfileUpdate _userDataSnapshot3(DocumentSnapshot snapshot){
//     return
//
//       UserDataForProfileUpdate(
//         uid: uid,
//         name: snapshot.data['name'],
//         email: snapshot.data['email'],
//         credit: snapshot.data['credit'],
//         mobileNumber: snapshot.data['mobileNumber'],
//         gender: snapshot.data['gender'],
//         joiningDate: snapshot.data['joiningDate'],
//         address: snapshot.data['address'],
//       );
//   }
//
//   Stream<UserDataForProfileUpdate> get userDataForProfileUpdate  {
//     return userCollection.document(uid).snapshots()
//         .map(_userDataSnapshot3);
//   }


// Future getCurrentUserJoiningDate() async {
//
//   user = await _auth.currentUser();
//   String userJoiningDate = user.created;
//   return userJoiningDate;
// }






}