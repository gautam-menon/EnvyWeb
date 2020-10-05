import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
    Future logIn(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  logOut() async {
 await FirebaseAuth.instance.signOut();
  }
  signUp(){
    
  }
}