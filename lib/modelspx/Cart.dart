
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../responsive.dart';

class Cart{
   String description;
   String productId;
   String image;
   int numberofproducts;
   int total;
   int saleprice;


   Timestamp timestamp;

   Cart({
      required this.numberofproducts,
      required this.total,
      required this.productId,
      required this.saleprice,

      required this.image,
      required this.description,
      required this.timestamp});
}


List<Cart> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Cart(
         description: doc.get('description') ,
         productId: doc.get('productId') ,
         saleprice: doc.get('saleprice')??0,

         numberofproducts: doc.get('numberofproducts')??0,
         total: doc.get('total')??0,
         image: doc.get('image')??'',
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}








Stream<List<Cart>> get getusercart{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('cart').orderBy('timestamp',descending: true).snapshots().map(items);
}








