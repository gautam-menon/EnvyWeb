import 'package:envyweb/Models/EditorModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ApiFunctions -Admin.dart';

class AuthService {
  Future<UserModel> logIn(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      UserModel user =
          await ApiFunctionsAdmin().loginCheck(userCredential.user.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> createAccount(String email, String password) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return usercredential.user.uid;
    } catch (e) {
      return null;
    }
    //if user exists, return the uid of that account.
  }
}
