import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:http_app/Model/User.dart';
import 'package:http_app/services/Database.dart';

class AuthCheck {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser) => _userFireBase(user));
        .map((_userFireBase));
  }

  Future signInAnym() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFireBase(user);
    } catch (e) {
      return null;
    }
  }

  User _userFireBase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future register(
      String email, String pass, String name, String place, int age) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      //creating database
      await DataBaseService(uid: user.uid)
          .UpdateUserData(email, name, place, age);
      return _userFireBase(user);
    } catch (e) {
       print(e); 
      print("register failed");
      return null;
    }
  }

  Future checkSign(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFireBase(user);
    } catch (e) {
      print(e);
      print("register failed");
      return null;
    }
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("failed task");
      return null;
    }
  }
}
