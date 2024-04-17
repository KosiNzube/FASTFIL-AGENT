import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../modelspx/student.dart';


class StudentService {
  final String? uid;

  StudentService({this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  Future updateUserData( String? name,String x,int y,int z) async {
    return await _reference.doc(uid).update({
      'phone': x,
      'name': name,
      'blocknumber': y,
      'roomnumber': z,


    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }



  Future updateCourseArray( String? list) async {
    return await _reference.doc(uid).update({
      'list': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future negupdateCourseArray( String? list) async {
    return await _reference.doc(uid).update({
      'list': FieldValue.arrayRemove([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }

  Future updateLikeArray( String? list) async {
    return await _reference.doc(uid).update({
      'loved': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future updateWishArray( String? list) async {
    return await _reference.doc(uid).update({
      'liked': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future negupdateWishArray( String? list) async {
    return await _reference.doc(uid).update({
      'liked': FieldValue.arrayRemove([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future updatePurchased( String? list) async {
    return await _reference.doc(uid).update({
      'purchased': FieldValue.arrayUnion([list]),

    }).then((value) => print("purchased update"))
        .catchError((error) => print("Failed to update purchase: $error"));

  }




  Future updateFaculty( String faculty)  {

    return  _reference.doc(uid).update({
      'faculty': faculty,
    }).then((value) => print("faculty update"))
        .catchError((error) => print("Failed to update user: $error"));

  }


  /// [TestData] list from snapshot.

  /// user data from snapshot
  StudentData _userDataFromSnapshot(DocumentSnapshot? snapshot) {
    return StudentData(
      id:  snapshot!.data().toString().contains('id') ? snapshot.get('id') : '',
      name:  snapshot.data().toString().contains('name') ? snapshot.get('name') : '',
      hostelname:  snapshot.data().toString().contains('hostelname') ? snapshot.get('hostelname') : '',
      phone:  snapshot.data().toString().contains('phone') ? snapshot.get('phone') : '',
      disable: snapshot.data().toString().contains('disable') ? snapshot.get('disable') : true,
      disablestamp:snapshot.data().toString().contains('disablestamp') ? snapshot.get('disablestamp') : Timestamp(0, 0),
      blocknumber: snapshot.get('blocknumber')??0,
      engagements: snapshot.data().toString().contains('engagements') ? snapshot.get('engagements') : true,
      email: snapshot.data().toString().contains('email') ? snapshot.get('email') : '',
      roomnumber: snapshot.get('roomnumber')??0,

      timestamp:snapshot.data().toString().contains('timestamp') ? snapshot.get('timestamp') : Timestamp(0, 0),
    );
  }

  /// get stream

  /// get user doc stream
  Stream<StudentData?> get userData {
    return _reference.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}
