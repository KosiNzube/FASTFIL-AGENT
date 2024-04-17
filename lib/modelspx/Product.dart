
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Product {
   String description;
   String mrp;
   int saleprice;
   String image;
   String id;
   Timestamp timestamp;

   Product({
      required this.description,
      required this.mrp,
      required this.saleprice,
      required this.image,
      required this.id,
      required this.timestamp
   });



}
List<Product> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Product(
         description: doc.get('description') ,
         mrp: doc.get('mrp'),
         saleprice: doc.get('saleprice'),
         image: doc.get('image'),
         id: doc.get('id'),
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}




Stream<List<Product>> get getProducts{

   return FirebaseFirestore.instance.collection("Products").snapshots().map(items);
}





