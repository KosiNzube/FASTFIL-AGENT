
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillfastAG/screen/pickAgentScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';




import '../../../constants.dart';


import 'package:flutter/foundation.dart' show kIsWeb;


import '../auth/database.dart';
import '../card/orderCard.dart';
import '../components/custom_text.dart';
import '../mainx.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Cart.dart';
import '../modelspx/Order.dart';
import '../modelspx/Product.dart';
import '../modelspx/Quantity.dart';
import '../modelspx/hostels.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../style.dart';
import 'liveTrack.dart';

class Afrostore extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar:AppBar(
          centerTitle: false,




          bottom: TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontFamily: 'Quicksand'),
            tabs: [
              Tab(text:'Market',),
              Tab(text:'Cart',),

              Tab(text:'Order History'),
            ],
          ),
          title: Text('Fastfil Store',),
        ),
        body:TabBarView(
          children: [
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getProducts, initialData: null),
                  StreamProvider.value(
                      value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

                ],
                child: products()),
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getusercart, initialData: null),

                  StreamProvider.value(
                      value: getHostels, initialData: null),

                  StreamProvider.value(
                      value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

                ],
                child: usercat()),

            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: inprogress, initialData: null),


                ],
                child: faves_prov3())
          ],
        ),

      ),
    );
  }
}


class makeOrderGas extends StatefulWidget {
  final List<Hostel?> hostels;
  final StudentData? student;
  final String? des;
  final double? price;

  bool xyx=false;

  String kg="";
  int xxx=0;
  String hostelname="Enter Hostel name";
  String hostelID="";
  TextEditingController fullname = new TextEditingController();
  TextEditingController phonenumber = new TextEditingController();
  TextEditingController blockno = new TextEditingController();
  TextEditingController roomno = new TextEditingController();

  makeOrderGas({ required this.hostels,required this.student, required this.des, required this. price});

  @override
  State<makeOrderGas> createState() => _makeOrderState();
}

class _makeOrderState extends State<makeOrderGas> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if(widget.student!=null && widget.hostels!=null) {
    }
    return Scaffold(

      appBar:AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Delivery Location"),
        ),

// like this!
      ),



      body: widget.student!=null && widget.hostels!=null? SingleChildScrollView(
        physics: BouncingScrollPhysics(),


        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Full name",
                    size: 20,
                  ),

                  Icon(Icons.person),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.fullname,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter full name ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Phone number",
                    size: 20,
                  ),

                  Icon(Icons.phone),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.phonenumber,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                      labelText: "Enter Phone number ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),

              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Block number",
                    size: 20,
                  ),

                  Icon(Icons.account_balance_outlined),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.blockno,
                  keyboardType: TextInputType.number,

                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Block number ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Room number",
                    size: 20,
                  ),

                  Icon(Icons.room_outlined),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.roomno,
                  keyboardType: TextInputType.number,

                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Room number ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),

              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Purchasing...",
                    size: 20,
                  ),

                  Icon(Icons.shopping_cart),

                ],
              ),
              SizedBox(height: 19.0),

              InkWell(
                onTap: (){
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    border: Border.all(),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                  Container(

          child: Column(

            children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: kDefaultPadding / 2),



                      Expanded(

                        child: Text(widget.des!),
                      ),

                    ],
                  ),
            ],
          ),

        ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 19.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Hostel name",
                    size: 20,
                  ),

                  Icon(Icons.home_filled),

                ],
              ),
              SizedBox(height: 19.0),

              InkWell(
                onTap: (){
                  showAlertDialogxxx(context);


                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    border: Border.all(),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Container(

                        child: Column(

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: kDefaultPadding / 2),



                                Expanded(

                                  child: Text(widget.hostelname),
                                ),

                              ],
                            ),
                          ],
                        ),

                      ),
                      Positioned.fill(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Icon( CupertinoIcons.chevron_up_chevron_down),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 19.0),


              InkWell(
                onTap: ()   {




                  if (int.parse( widget.roomno.text)>-1) {
                    if (widget.xyx==true) {
                      if (int.parse( widget.blockno.text)>-1) {
                        if (int.parse( widget.phonenumber.text)>1) {
                          if (widget.fullname.text.length>1) {
                            if (widget.kg.length>2) {



                              Orderx coux = Orderx(
                                  userID: widget.student!.id,
                                  name: widget.fullname.text,
                                  hostelname: widget.hostelname,
                                  price: widget.price!.toInt(),
                                  blockNO: widget.blockno.text,
                                  roomNO: widget.roomno.text,
                                  stateBool: false,
                                  kg: widget.kg,
                                  userphone: widget.phonenumber.text,
                                  hostelID: widget.hostelID,
                                  agentID: "",
                                  service: "In Store Purchase",

                                  state: "Pick Agent",
                                  agent: "",
                                  id: "",
                                  deliveryDate: Timestamp.fromDate(DateTime.now()),
                                  timestamp: Timestamp.fromDate(DateTime.now()));

                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen:MultiProvider(
                                    providers: [
                                      StreamProvider.value(
                                          value: getActiveAgents, initialData: null),


                                    ],
                                    child:pickAgentScreen(orderx: coux,student: widget.student!),
                                ),







                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation
                                    .cupertino,
                              );




                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        " Enter the Quantity "),

                                  ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      " Enter your name "),

                                ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    " Enter phone number "),

                              ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  " Enter block number "),

                            ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                " Whats the name of your hostel "),

                          ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              " Pick room number  "),

                        ));
                  }


                },
                child: Container(

                  decoration: BoxDecoration(color: active,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    color: Colors.white,
                    text: "Pick a specific agent(Active)",
                  ),
                ),
              ),

              SizedBox(height: 19.0),


            ],
          ),
        ),
      ):CircularProgressIndicator(),
    );
  }


  showAlertDialogxxx(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.hostels!=null? ListView.builder(

          itemCount: widget.hostels!.length,
          // On mobile this active dosen't mean anything
          itemBuilder: (context, index) {
            return AlertDialog(
              content: InkWell(
                onTap: (){
                  widget.hostelname=widget.hostels[index]!.name;

                  setState(() {
                    widget.xyx=true;
                    widget.hostelname=widget.hostels[index]!.name;
                    widget.hostelID=widget.hostels[index]!.id;
                  });
                  print(widget.hostels[index]!.name);
                  Navigator.of(context).pop();
                },
                child: Text(widget.hostels[index]!.name),
              )
            );



          },
        ):Container();
      },
    );
  }




}

class faves_prov3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Orderx>>(context);

    Size _size = MediaQuery
        .of(context)
        .size;
    return orders!=null?

    orders.length>0?

    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,


            itemCount: orders.length,
            // On mobile this active dosen't mean anything
            itemBuilder: (context, index) => orderCard(
              orderx: orders[index]!,
              press: () {

                if(orders[index]!.state=="In Progress"){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:liveTrack(orderx: orders[index]),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );
                }

              },
            ),),
        ],
      ),
    ):Container(

      child: Center(
        child: SingleChildScrollView(
          physics: ScrollPhysics() ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/think.png',
                width: 350,
                height: Responsive.isMobile(context)?300:600,

              ),
              SizedBox(height: 20.0),

              Text(
                'No orders yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.0),

            ],
          ),
        ),
      ),
    ) :Center(child: CircularProgressIndicator());  }
}






