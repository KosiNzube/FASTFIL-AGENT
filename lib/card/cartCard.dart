
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Cart.dart';
import '../modelspx/Product.dart';
import '../modelspx/student.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.press,
    required this.student,

    required this.cart,
  }) : super(key: key);

  final Product cart;
  final VoidCallback press;
  final StudentData student;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Image.network(cart.image),
                ),
              ),

              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.description,
                    style: TextStyle( fontSize: 16),
                  ),
                  SizedBox(height: 5),


                  Text("${cart.saleprice}", style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.deepOrange,fontSize: 16),),
                  SizedBox(height: 5),

                  SizedBox(
                    height: 33,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        primary: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance
                            .collection('students')
                            .doc(firebaseAuth.currentUser!.uid)
                            .collection('cart').doc(cart.id).set({
                          'numberofproducts': 1, // John Doe
                          'image': cart.image, // Stokes and Sons
                          'description': cart.description,
                          'saleprice': cart.saleprice,
                          'total': 1,
                          'productId': cart.id,

                          'timestamp': Timestamp.now() // 42
                        });


                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  cart.description+" added"),

                            ));

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,0,12,0),
                        child: Text(
                          "Add to Cart",
                          style: GoogleFonts.asapCondensed(
                              textStyle: const TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ],
          ),
          Icon(CupertinoIcons.cart)
        ],
      ),
    );
  }
}