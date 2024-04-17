import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import '../auth/orderDatabase.dart';
import '../card/agentCard.dart';
import '../card/orderCard.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Order.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';
import 'ChatScreen.dart';
import 'liveTrack.dart';


String generateRef() {
  final randomCode = Random().nextInt(3234234);
  return 'ref-$randomCode';
}
class pickAgentScreen extends StatefulWidget {
  pickAgentScreen({
    Key? key, required this.orderx,required this.student
  }) : super(key: key);

  final Orderx orderx;
  final StudentData student;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<pickAgentScreen> {



  @override
  Widget build(BuildContext context) {
    Stream<List<AgentData>> xx=FirebaseFirestore.instance.collection("Agents").where('hostelID',isEqualTo: widget.orderx.hostelID).where("active",isEqualTo: true).limit(20).snapshots().map(items);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Pick a specific agent'),

      ),


      body:

      StreamProvider.value(
        value: xx,initialData: null,
        child: NewWidgetcom(student:widget.student,orderx:widget.orderx),),
    );
  }

}
class NewWidgetcom extends StatefulWidget {
  final StudentData student;
  final Orderx orderx;

  const NewWidgetcom({super.key, required this.student, required this.orderx});

  @override
  State<NewWidgetcom> createState() => _NewWidgetcomState();
}

class _NewWidgetcomState extends State<NewWidgetcom> {

  String x="";
  var publicKey = 'pk_test_ace722018a2ed1cf73ce3765356c249bcdafa2c9';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }
  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<Agent>>(context);
    FirebaseAuth _auth = FirebaseAuth.instance;
    Orderx coux = Orderx(
        userID: widget.orderx.userID,
        name: "Service: "+widget.orderx.service,
        hostelname: widget.orderx.hostelname,
        price: widget.orderx.price,
        blockNO: widget.orderx.blockNO,
        userphone: widget.orderx.userphone,

        service: widget.orderx.service,
        roomNO: widget.orderx.roomNO,
        stateBool: widget.orderx.stateBool,
        kg: widget.orderx.kg,
        hostelID: widget.orderx.hostelID,
        state: "Checkout",
        agent: x,
        agentID: "",

        id: widget.orderx.id,
        deliveryDate: Timestamp.fromDate(DateTime.now()),
        timestamp: Timestamp.fromDate(DateTime.now()));

    if(brewx!=null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

          ],
        ),
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _processPayment(String ref, int amount, String email,BuildContext context, FirebaseAuth auth) async {
    Charge charge = Charge()
      ..amount = amount*100
      ..reference = ref
    // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email;
    CheckoutResponse response = await  plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if(response.status==true){
      Orderx coux = Orderx(
          userID: widget.orderx.userID,
          name: widget.orderx.name,
          hostelname: widget.orderx.hostelname,
          price: widget.orderx.price,
          agentID: widget.orderx.agentID,
          userphone: widget.orderx.userphone,

          service: widget.orderx.service,
          blockNO: widget.orderx.blockNO,
          roomNO: widget.orderx.roomNO,
          stateBool: widget.orderx.stateBool,
          kg: widget.orderx.kg,
          hostelID: widget.orderx.hostelID,
          state: "In Progress",
          agent: widget.orderx.agent,
          id: widget.orderx.id,

          timestamp: Timestamp.fromDate(DateTime.now()),
          deliveryDate: Timestamp.fromDate(DateTime.now())


      );
     await orderDatabase(uid:widget.orderx.userID).addOrder(coux).whenComplete(() {


      });


      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));





      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Payment Successful. Your order is on its way to you"),

      ));

    }else{

    }




  }
}

List<AgentData> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return AgentData(
      name: doc.get('name') ,
      image: doc.get('image'),
      online: doc.get('online')??false,
      hostel: doc.get('hostel'),
      hostelID: doc.get('hostelID'),
      id: doc.get('id'),
      number: doc.get("name"),
      active: doc.get('active')??false,
      disable: doc.get('disable')??false,
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),

      state: doc.get('state')??"",

      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,


    );
  }).toList();
}