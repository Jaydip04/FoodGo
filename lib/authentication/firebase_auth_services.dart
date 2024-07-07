import 'package:firebase_auth/firebase_auth.dart';

import '../common/toast.dart';

class firebase_auth_services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        show_toast(message: "The email address is already in use.");
      }else{
        show_toast(message: "An error occurred: ${e.code}");
      }
    }
    return null;
  }
  Future<User?> signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        show_toast(message: "Invalid email or password.");
      }else{
        show_toast(message: "An error occurred: ${e.code}");
      }
    }
    return null;
  }
}
