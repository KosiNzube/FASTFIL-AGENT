
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../auth/cartDatabase.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Cart.dart';
import '../modelspx/student.dart';

class usercartCart extends StatelessWidget {
  const usercartCart({
    Key? key,
    required this.press,
    required this.student,

    required this.cart,
  }) : super(key: key);

  final Cart cart;
  final VoidCallback press;
  final StudentData student;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    int xxx=cart.saleprice*cart.numberofproducts;

    return InkWell(
      onTap: (){
        press();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Image.network(cart.image),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.description,
                  style: TextStyle( fontSize: 16),
                  maxLines: 2,
                ),
                SizedBox(height: 5),


                Text("${cart.saleprice}"+" (Sum: "+ xxx.toString()+")", style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.deepOrange,fontSize: 16),),
                SizedBox(height: 5),

                Row(
                  children: [
                    IconButton(onPressed: (){

                      if(cart.numberofproducts>0){
                        cartDatabase(uid: student.id,productid: cart.productId).removefromcart();
                      }
                      if(cart.numberofproducts==1){
                        cartDatabase(uid: student.id,productid: cart.productId).deletefromcart();
                      }


                    },icon: Icon(Icons.remove),),
                    SizedBox(width: 5),

                    Text(cart.numberofproducts.toString()),
                    SizedBox(width: 5),

                    IconButton(onPressed: (){
                      cartDatabase(uid: student.id,productid: cart.productId).addtocart();

                    },icon: Icon(Icons.add),),

                  ],
                ),



              ],
            )
          ],
        ),
      ),
    );
  }
}