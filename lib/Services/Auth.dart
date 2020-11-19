import 'dart:convert';
import 'package:http/http.dart' as http;
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

  signUp(
      String email, String password, String name, int tier, int phoneNo) async {
    String signUpUrl = "";
    var response = await http.post(signUpUrl, body: {
      "email": email,
      "password": password,
      "name": name,
      "tier": tier,
      "phoneNo": phoneNo
    });
    var data = json.decode(response.body);
    return data['status'];
  }
}
