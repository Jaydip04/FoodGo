import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future add_favorite_details(
      Map<String, dynamic> favorite_info, String id) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid.toString())
        .doc(id)
        .set(favorite_info);
  }

  Future<Stream<QuerySnapshot>> get_favorite_details() async {
    return await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots();
  }

  // Future updateEmployeeDetails(String id,Map<String,dynamic> updateInfo)async{
  //   return await FirebaseFirestore.instance.collection("Employee").doc(id).update(updateInfo);
  // }

  Future delete_favorite_details(String id)async{
    return await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid.toString()).doc(id).delete();
  }
}
