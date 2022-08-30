import 'package:firebase_auth/firebase_auth.dart';
import 'package:qms/models/user.dart';

import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create an user object based on firebase user
  CurrentUserModel? _userFromFirebaseUser(User user) {
    return user != null ? CurrentUserModel (uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CurrentUserModel?> get user{
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));
  }



  //sign in anonomusly
  // Future SignInAnon() async{
  //   try {
  //     AuthResult result =  await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //
  //   }catch(e){
  //     //print(e.toString());
  //     return null;
  //
  //   }
  //
  // }


  //sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      //print(e.toString());
      return null;

    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String password, String name, String branchName, String counterNumber, String designation) async {

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user

      await DatabaseService(uid: user!.uid).updateUserData(name, result.user!.email.toString(), branchName, counterNumber, designation);
      return _userFromFirebaseUser(user);
    } catch(e){
      //print(e.toString());
      return null;

    }
  }


  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e){
      //print(e.toString());
      return null;

    }
  }

}