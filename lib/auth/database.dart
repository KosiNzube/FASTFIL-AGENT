import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../modelspx/Agents.dart';
import '../modelspx/student.dart';


class DataBaseService {
  final String? uid;
  final String? email;

  DataBaseService({required this.email, this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Agents');

  Future updateUserData( String? name,String hostel,String hostelID,String number) async {
    return await _reference.doc(uid).update({
      'number': number,
      'hostel': hostel,
      'hostelID': hostelID,
      'name': name,
      'image':"https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/iconel.png?alt=media&token=c5f41a18-e5ac-42f6-98f3-8141be3b3f59"


    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }

  Future updateActive( bool xx) async {
    return await _reference.doc(uid).update({
      'active': xx,


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


  Future<void> addUser(String? name,bool? substate, Timestamp? timestamp)  async {

    QuerySnapshot snapshot= await _reference.where("id",isEqualTo: uid).get();

    if(snapshot.docs.isNotEmpty){

    }else{
      return _reference.doc(uid).
      set({
        'id': uid, // John Doe
        'number': "", // Stokes and Sons
        'name': "",
        'active': true,
        'online': true,

        'state':'',
        'image':"",
        'disable':true,
        'hostel': "",
        'disablestamp':timestamp,// 42
        'rating':0,
        'deliveries':0,

        'hostelID':"",

      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

    }

    // Call the user's CollectionReference to add a new user
  }




  /// [TestData] list from snapshot.

  /// user data from snapshot
  AgentData _userDataFromSnapshot(DocumentSnapshot? snapshot) {
    if (snapshot == null || !snapshot.exists) {
      print('nuller');



      x_Snulle=false;
      // Return a default or empty AgentData if the snapshot is null or doesn't exist
      return AgentData(
        id: '',
        image: '',
        hostel: '',
        hostelID: '',
        name: '',
        number: '',
        rating: 0,
        deliveries: 0,
        active: false,
        state: '',
        online: false,
        disable: false,
        disablestamp: Timestamp(0, 0),
      );
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return AgentData(
      id: data?['id'] ?? '',
      image: data?['image'] ?? '',
      hostel: data?['hostel'] ?? '',
      hostelID: data?['hostelID'] ?? '',
      name: data?['name'] ?? '',
      number: data?['number'] ?? '',
      rating: data?['rating'] ?? 0,
      deliveries: data?['deliveries'] ?? 0,
      active: data?['active'] ?? false,
      state: data?['state'] ?? '',
      online: data?['online'] ?? false,
      disable: data?['disable'] ?? false,
      disablestamp: data?['disablestamp'] ?? Timestamp(0, 0),
    );
  }
  /// get stream

  /// get user doc stream
  Stream<AgentData?> get userData {
    return _reference.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}
