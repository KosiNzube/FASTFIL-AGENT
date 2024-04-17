import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Hostel{
  String id, name;


  Hostel({
    required this.name,

    required this.id,
    });
}


List<Hostel> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Hostel(
      name: doc.get('name') ,
      id: doc.get('id'),

    );
  }).toList();
}




Stream<List<Hostel?>> get getHostels{

  return FirebaseFirestore.instance.collection("Hostels").snapshots().map(items);
}
