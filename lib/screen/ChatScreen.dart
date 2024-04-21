import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:fillfastAG/auth/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../auth/auth.dart';
import '../auth/messageDatabase.dart';
import '../auth/orderDatabase.dart';
import '../auth/studentDatabase.dart';
import '../card/agentCard.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Message.dart';
import '../modelspx/student.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';

import 'package:http/http.dart' as http;

import '../services/yiyi.dart';


class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key, required this.message
  }) : super(key: key);

  final Message message;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();


  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;



    return MultiProvider(

      providers: [
        StreamProvider.value(
            value: StudentService(uid: widget.message.student).userData, initialData: null
        ),
        StreamProvider.value(
            value: DataBaseService(uid: widget.message.agent, email: firebaseAuth.currentUser!.email).userData, initialData: null
        ),


      ],
      child:NewWidgetxxx( formKey: formKey, commentController: commentController, firebaseAuth: firebaseAuth,message:widget.message),
    );


  }

}

class NewWidgetxxx extends StatefulWidget {
  const NewWidgetxxx({
    super.key,
    required this.formKey,
    required this.commentController,
    required this.firebaseAuth, required this.message,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController commentController;
  final FirebaseAuth firebaseAuth;
  final Message message;

  @override
  State<NewWidgetxxx> createState() => _NewWidgetxxxState();
}

class _NewWidgetxxxState extends State<NewWidgetxxx> {

  @override
  Widget build(BuildContext context) {

    final agentdata = Provider.of<AgentData?>(context);
    final studentdata = Provider.of<StudentData?>(context);


    final usersQuery = FirebaseFirestore.instance.collection("Messages").where('agent',isEqualTo: widget.message.agent).where("student",isEqualTo: widget.message.student).orderBy('timestamp',descending: true).limit(50).snapshots().map(itemsmsgs);


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/1personicon4.png?alt=media&token=2661661b-986d-4559-802e-a6ed56678858"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(studentdata!.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text(studentdata!.phone,style: TextStyle( fontSize: 13),),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.phone),
              ],
            ),
          ),
        ),
      ),


      body:MultiProvider(
          providers: [
            StreamProvider.value(
                value: usersQuery, initialData: null),

          ],
          child: chatxxx(agent:agentdata!,student: studentdata!)),










      /*
      Container(
        child: CommentBox(
          userImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/1personicon2.png?alt=media&token=56ed9007-3744-46d1-8272-096aae5baf53") ,
          child: NewWidget(usersQuery: usersQuery,),
          labelText: 'Write a message...',
          withBorder: false,
          errorText: 'Messages cannot be blank',
          sendButtonMethod: () async {
            if (widget.formKey.currentState!.validate()) {
              print(widget.commentController.text);


              sendMessageToTopic(studentdata!.id, agentdata!.name, widget.commentController.text);


              await messageDatabase(
                  uid: widget.firebaseAuth.currentUser!.uid)
                  .addMessage(agentdata!.id, studentdata!.id ,widget.commentController.text,"text",false,Timestamp.fromDate(DateTime.now()),false).whenComplete((){




              });

              widget.commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: widget.formKey,
          commentController: widget.commentController,
          sendWidget: Icon(CupertinoIcons.arrowshape_turn_up_right_fill, size: 30),
        ),
      ),

       */
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
  super.key,
  required this.usersQuery, required this. xx,
  });

  final Query<Message> usersQuery;
  final ScrollController xx;
  @override
  Widget build(BuildContext context) {
    /*
     ScrollController _controller = ScrollController();

     if (_controller.hasClients) {
       _controller.animateTo(
         _controller.position.maxScrollExtent + 300,
         duration: const Duration(
           milliseconds: 200,
         ),
         curve: Curves.easeInOut,
       );
     }

     */

    return FirestoreListView<Message>(
      physics: BouncingScrollPhysics(),

      controller: xx,

      query: usersQuery,
      itemBuilder: (context, snapshot) {
        // Data is now typed!
        Message user = snapshot.data();

        if(user.agentsender==false) {
          messageDatabase(uid: user.id).updateSent();
        }


        return  Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Column(
            children: [
              Align(
                alignment: (user.agentsender == true?Alignment.topLeft:Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (user.agentsender == false?Colors.deepPurple:Colors.blue[300]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(user.content, style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),

              Align(

                  alignment: (user.agentsender == true?Alignment.topLeft:Alignment.topRight),

                  child: Text(DateFormat('HH:mm').format(user.timestamp.toDate())))
            ],
          ),
        );





      },
    );
  }
}

class chatxxx extends StatefulWidget {

  final AgentData agent;
  final StudentData student;

  const chatxxx({super.key, required this.agent, required this.student});
  @override
  State<chatxxx> createState() => _chatState();
}



class _chatState extends State<chatxxx> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  late TextEditingController commentController ;


  String lastMsg="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {

    final brewx = Provider.of<List<Message>?>(context);


    return Scaffold(




        body: yiyi(

          child2:         Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],

            ),
          ),

          userImage: AssetImage('assets/images/qw.png'),
          child: widget.student!=null&& widget.agent!=null && brewx!=null? ListView.builder(
            reverse: true,

            // controller: xx,
            shrinkWrap: true,

            itemCount: brewx.length,


            // On mobile this active dosen't mean anything
            itemBuilder: (context, index) {

              if(brewx[index].agentsender==false) {
                messageDatabase(uid: brewx[index].id).updateSent();

              }


              return GestureDetector(
              onLongPress: () async {
                Clipboard.setData(ClipboardData(text:brewx[index].content));

                // Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          " Text copied "),

                    ));

                /*
              showDialog(context: context, builder:  (context2){
                return SimpleDialog(
                  //   title: const Text('Copy'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () async {
                        Clipboard.setData(ClipboardData(text:brewx[index].content));

                        Navigator.pop(context2);

                        snack("Text copied", context);
                      },
                      child: const Text('Copy text'),
                    ),


                  ],
                );
              });


               */






              },






              child:Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 5,bottom: 5),
                child: Padding(
                  padding: brewx[index].agentsender==true? EdgeInsets.only(right: 15.0):EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: (brewx[index].agentsender == true?Alignment.topLeft:Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (brewx[index].agentsender == false?Colors.deepPurple:Colors.blue[300]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(brewx[index].content, style: TextStyle(fontSize: 15,color: Colors.white),),
                        ),
                      ),
                      Align(

                          alignment: (brewx[index].agentsender == true?Alignment.topLeft:Alignment.topRight),

                          child: Row(
                            mainAxisAlignment: brewx[index].agentsender == true?  MainAxisAlignment.start: MainAxisAlignment.end,

                            children: [
                              Text(DateFormat('HH:mm').format(brewx[index].timestamp.toDate())),
                              SizedBox(width:brewx[index].sent==true? 2:0,),
                              //   Icon(user.sent==true?"Seen":"",style: TextStyle(fontSize: 12),)

                              brewx[index].agentsender == true?Icon(  brewx[index].sent==true?Icons.done_all:brewx[index].del==true?Icons.done:Icons.alarm_outlined,color:brewx[index].sent==true? Colors.blue:null,size: 14.3,):Container()
                            ],
                          ))

                    ],
                  ),
                ),
              ),
            );},
          ):Center(child: CircularProgressIndicator(strokeWidth: 1,)),
          labelText: 'Write a message...',

          withBorder: false,
          errorText: 'Messages cannot be blank',
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {


              String x=commentController.text;
              commentController.clear();

              FocusScope.of(context).unfocus();





              // user.add(Message(student:widget.student.id, agent: widget.agent!.id, type: "text", id: "",  agentsender: false, content: commentController.text, sent: false, timestamp: Timestamp.fromDate(DateTime.now())));



              await messageDatabase(
                  uid: firebaseAuth.currentUser!.uid)
                  .addMessage(widget.agent!.id, widget.student!.id ,widget.agent.name,  x,"text",false,Timestamp.fromDate(DateTime.now()),false).whenComplete((){




              });







              //  messages.add(commentController.text);








              //  commentController.clear();
              //  FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }

          },
          formKey: formKey,
          commentController: commentController,
          sendWidget: Icon(CupertinoIcons.arrowshape_turn_up_right_fill, size: 30),
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
      hostel: doc.get('hostel'),
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),
      disable: doc.get('disable')??false,
      state: doc.get('state')??"",

      hostelID: doc.get('hostelID'),
      id: doc.get('id'),
      number: doc.get("name"),
      active: doc.get('active')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,


    );
  }).toList();
}

void sendMessageToTopic(String topic, String title, String body) async {
  final String serverKey =
      'AAAAdI9gbIs:APA91bGyzl5******************************************************************irh'; // Replace with your FCM server key from the Firebase Console

  final Uri fcmUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> message = {
    'to': '/topics/$topic',
    'notification': {
      'title': title,
      'body': body,
      'sound': 'default',
    },
  };

  try {
    final http.Response response = await http.post(
      fcmUrl,
      headers: headers,
      body: json.encode(message),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully to topic: $topic');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
}
Future<void> launchPhoneDialer(String phoneNumber) async {
  final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunch(phoneLaunchUri.toString())) {
    await launch(phoneLaunchUri.toString());
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

class HandleScrollWidget extends StatefulWidget {
  final BuildContext context;
  final Widget child;
  final ScrollController controller;

  HandleScrollWidget(this.context, {required this.controller, required this.child});

  @override
  _HandleScrollWidgetState createState() => _HandleScrollWidgetState();
}

class _HandleScrollWidgetState extends State<HandleScrollWidget> {
  double? _offset;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(widget.context).viewInsets.bottom;
    if (bottom == 0) {
      _offset = null;
    } else if (bottom != 0 && _offset == null) {
      _offset = widget.controller.offset;
    }
    if (bottom > 0) widget.controller.jumpTo(_offset! + bottom);
    return widget.child;
  }
}

List<Message> itemsmsgs(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Message(
      agent: doc.get('agent') ,
      student: doc.get('student'),
      type: doc.get('type'),
      content: doc.get('content'),
      id: doc.get('id'),
      agentsender: doc.get('agentsender')??false,
      del: doc.get('del')??false,

      sent: doc.get('sent')??false,
      timestamp: doc.get('timestamp')??Timestamp(0, 0),


    );
  }).toList();
}
