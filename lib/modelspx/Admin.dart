
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Admin {
   String courseprice;
   String password;
   String id;

   int naira;

   Admin({
      required this.courseprice,
      required this.password,
      required this.naira,
      required this.id,

   });




   /// get stream

   /// get user doc stream


}
Admin _userDataFromSnapshot(DocumentSnapshot? snapshot) {
   return Admin(
      id:  snapshot!.data().toString().contains('id') ? snapshot.get('id') : '',
      password:  snapshot.data().toString().contains('password') ? snapshot.get('password') : '',
      courseprice:  snapshot.data().toString().contains('courseprice') ? snapshot.get('courseprice') : '',
      naira: snapshot.get('naira')??0,

   );
}
Stream<Admin> get adminData {
   final CollectionReference _reference =
   FirebaseFirestore.instance.collection('ADMIN');
   return _reference.doc("op*********aOfwnd").snapshots().map(_userDataFromSnapshot);
}





