import 'package:firebase_auth/firebase_auth.dart';
import 'package:qms/models/user.dart';
import 'package:qms/utils/texts_for_app.dart';
import 'database.dart';
import 'local_storage_manager.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create an user object based on firebase user
  CurrentUserModel? _userFromFirebaseUser(User user) {
    return  CurrentUserModel (uid: user.uid);
  }


  // auth change user stream
  Stream<CurrentUserModel?> get user{
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));
  }

  //Stream<CurrentUserModel?> get authStateChanges => _auth.authStateChanges();




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
      _sharedPreference(user!);
      return _userFromFirebaseUser(user);
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
      _sharedPreferenceDataRemove();
      return await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;

    }


  }


  //save data at shared preference
  _sharedPreference(User user) {
    print('uid: ${user.uid}');
    LocalStorageManager.saveData(MyTexts.uid, user.uid);
    LocalStorageManager.saveData(MyTexts.email, user.email);
  }

  //delete data at shared preference
  _sharedPreferenceDataRemove() {
    LocalStorageManager.deleteData(
      MyTexts.uid,
    );
    LocalStorageManager.deleteData(
      MyTexts.email,
    );
  }

}