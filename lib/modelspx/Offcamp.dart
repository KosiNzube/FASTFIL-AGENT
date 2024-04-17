import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Offcamp{
  String id, name;


  Offcamp({
    required this.name,

    required this.id,
    });
}


List<Offcamp> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Offcamp(
      name: doc.get('name') ,
      id: doc.get('id'),

    );
  }).toList();
}




Stream<List<Offcamp?>> get getOffcamps{

  return FirebaseFirestore.instance.collection("Offcamp").snapshots().map(items);
}
