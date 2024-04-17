import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import '../auth/orderDatabase.dart';
import '../components/custom_text.dart';
import '../components/style.dart';
import '../constants.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Order.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';
import 'ChatScreen.dart';


class liveTrack extends StatefulWidget {
  liveTrack({
    Key? key, required this.orderx
  }) : super(key: key);

  final Orderx orderx;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<liveTrack> {
  bool y=false;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Order Details'),

      ),




      body:SingleChildScrollView(
        child: Column(

          children: [

            SizedBox(height: 30,),

            Text(
                 "Service: " +widget.orderx.service,textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),
            SizedBox(height: 10,),


            Text(
                "Location: " +widget.orderx.hostelname  .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold)

            ),
            SizedBox(height: 10,),

        Text(
            "Room number: " +widget.orderx.roomNO.toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

          fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold)

        ),
            SizedBox(height: 10,),

            Text(
                "Block number: " +widget.orderx.blockNO.toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),
            SizedBox(height: 10,),

            Text(
                "KG: " +widget.orderx.kg .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold)

            ),


            SizedBox(height: 10,),
            Text(
                "Phone number: " +widget.orderx.userphone .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),

            SizedBox(height: 10,),
            Text(
                "Customer name: " +widget.orderx.name .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),


            SizedBox(height: 10,),

            Text(
                "Order ID: " +widget.orderx.id .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),
            SizedBox(height: 10,),

            Text(
                "Order price: " +widget.orderx.price .toString(),textAlign: TextAlign.center,style:GoogleFonts.nunito(

              fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,)

            ),


            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  //  widget.animationController.animateTo(0.2);
                  sendMessageToTopic(widget.orderx.userID, widget.orderx!.agent, "Your order is close by!");

                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color(0xff132137),
                  ),
                  child: Text(
                    "Send close-by message",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),


            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  //  widget.animationController.animateTo(0.2);
                  launchPhoneDialer(widget.orderx.userphone);

                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color(0xff132137),
                  ),
                  child: Text(
                    "Call User",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      )
    );
  }

}


List<AgentData> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return AgentData(
      name: doc.get('name') ,
      image: doc.get('image'),
      online: doc.get('online')??false,
      disable: doc.get('disable')??false,
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),
      state: doc.get('state')??"",

      hostel: doc.get('hostel'),
      hostelID: doc.get('hostelID'),
      id: doc.get('id'),
      number: doc.get("name"),
      active: doc.get('active')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,


    );
  }).toList();
}