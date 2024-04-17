import 'dart:convert';
import 'dart:math';

import 'package:algolia/algolia.dart';
import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fillfastAG/auth/messageDatabase.dart';
import 'package:fillfastAG/auth/studentDatabase.dart';
import 'package:fillfastAG/card/msgCard.dart';
import 'package:fillfastAG/extensions.dart';
import 'package:fillfastAG/modelspx/Message.dart';
import 'package:fillfastAG/modelspx/Offcamp.dart';
import 'package:fillfastAG/pages/about.dart';
import 'package:fillfastAG/pages/contact.dart';
import 'package:fillfastAG/responsive.dart';
import 'package:fillfastAG/screen/ChatScreen.dart';
import 'package:fillfastAG/screen/CheckoutCard.dart';
import 'package:fillfastAG/screen/afrostore.dart';
import 'package:fillfastAG/screen/list_xyy.dart';
import 'package:fillfastAG/screen/liveTrack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/auth.dart';
import 'auth/database.dart';
import 'card/agentCard.dart';
import 'card/cartCard.dart';
import 'card/matchcardyy.dart';
import 'card/orderCard.dart';
import 'card/usercartCard.dart';
import 'comp2/DarkThemeProvider.dart';
import 'comp2/main_button.dart';
import 'components/custom_text.dart';
import 'components/style.dart';
import 'constants.dart';
import 'modelspx/Admin.dart';
import 'modelspx/Agents.dart';
import 'modelspx/Cart.dart';
import 'modelspx/Library.dart';
import 'modelspx/Order.dart';
import 'modelspx/Product.dart';
import 'modelspx/Quantity.dart';
import 'modelspx/State.dart';
import 'modelspx/hostels.dart';
import 'modelspx/student.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curr=0;
  AuthSerives _serives = AuthSerives();
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  void logOut(BuildContext context) async {
    await _serives.logOut();
  }
  bool progress=false;
  List<String> array=[];
  TextEditingController emailController = new TextEditingController();
  TextEditingController emailController2 = new TextEditingController();

  String statename="----";

  List<Widget> listcolors = <Widget>[];
  late TabController _controller;
  Future<String> _dataRequiredForBuild=getinfo();
  TextEditingController number = new TextEditingController();
  TextEditingController name = new TextEditingController();
  @override
  void initState() {



    FirebaseAuth firebaseAuth=FirebaseAuth.instance;


    listcolors.add(List_xxy());
    listcolors.add(MultiProvider(
        providers: [
          StreamProvider.value(
              value: getMsgs, initialData: null),

        ],
        child: chat()));
    listcolors.add( calls());
    listcolors.add(Revenue());

    listcolors.add( Account());




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    final states = Provider.of<List<Statex?>>(context);

    final student = Provider.of<AgentData?>(context);
    PersistentTabController _controller;

      if (x_Snulle==false) {


        logOut(context);

        setState(() {
          x_Snulle=true;
        });
      }


    _controller = PersistentTabController(initialIndex: 0);

    return student!=null?student.state!=null&&student.state.isNotEmpty ? student.hostel.isNotEmpty ? Scaffold(

      body:FutureBuilder<String>(
        future: _dataRequiredForBuild,
        builder: (context, snapshot) {
         return PersistentTabView(
           context,
           backgroundColor: mode.brightness==Brightness.dark?CupertinoColors.darkBackgroundGray :Colors.white,
           controller: _controller,
           screens: listcolors,
           items: _navBarsItems(),
           confineInSafeArea: true,
           // Default is Colors.white.
           handleAndroidBackButtonPress: true,
           // Default is true.
           resizeToAvoidBottomInset: true,
           // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
           stateManagement: true,
           // Default is true.
           hideNavigationBarWhenKeyboardShows: true,
           // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
           decoration: NavBarDecoration(
             boxShadow: <BoxShadow>[
               BoxShadow(
                 color:mode.brightness==Brightness.dark? Colors.white24:Colors.black45,
                 blurRadius: 5,
               ),
             ],
             colorBehindNavBar:mode.brightness==Brightness.dark?CupertinoColors.lightBackgroundGray :Colors.white,
           ),
           popAllScreensOnTapOfSelectedTab: true,
           popActionScreens: PopActionScreensType.all,
           itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
             duration: Duration(milliseconds: 200),
             curve: Curves.ease,
           ),
           screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
             animateTabTransition: true,
             curve: Curves.ease,
             duration: Duration(milliseconds: 200),
           ),
           navBarStyle: NavBarStyle
               .style1, // Choose the nav bar style with this property.

         );

        },
    ),
    ): Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
          child: Column(
            children: [



              SizedBox(height: kDefaultPadding*3),

              Text("Fill in and your good to go",style: TextStyle(fontSize: 39,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),

              SizedBox(height: kDefaultPadding*2),

              TextField(
                controller: name,

                decoration: InputDecoration(
                    labelText: "Your name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: kDefaultPadding),
              TextField(
                controller: number,

                decoration: InputDecoration(
                    labelText: "Phone number ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: kDefaultPadding*2),

              buildDeparment(),
              SizedBox(height: kDefaultPadding*2),
              buildDeparmentxxx(),
              SizedBox(height: kDefaultPadding*2),

              progress==true?CircularProgressIndicator():Center(),
              progress==true?SizedBox(height: kDefaultPadding):Center(),

              InkWell(
                onTap: () async {
                  if (number.text.length > 0) {
                    if (name.text.length > 0) {
                      if (ListSec.xyyy.length > 1) {

                        setState(() {
                          progress=true;
                        });

                        DataBaseService(uid: student.id, email:firebaseAuth.currentUser!.email).updateUserData(name.text, ListSec.xyyy,ListSec.hosID, number.text);

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  " Please select the area most convenient for you to deliver to imminently "),

                            ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                " Please type in your name "),

                          ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              " Please type in your number "),

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
                    text: "Continue",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding*6),


            ],
          ),
        ),
      ),
    ) :Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              SizedBox(height: kDefaultPadding*5),

              Text("State/Residence",style: TextStyle(fontSize: 39,fontWeight: FontWeight.w600,color: active,),textAlign: TextAlign.center,),

              SizedBox(height: kDefaultPadding*2),

              InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return states!=null? Center(
                        child: ListView.builder(

                          itemCount: states.length,
                          // On mobile this active dosen't mean anything
                          itemBuilder: (context, index) {
                            return Center(
                              child: AlertDialog(
                                content: InkWell(
                                  onTap: (){
                                    statename=states[index]!.name;

                                    setState(() {

                                      statename=states[index]!.name;
                                    });
                                    print(states[index]!.name);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(states[index]!.name),
                                ),
                              ),
                            );



                          },
                        ),
                      ):Container();
                    },
                  );

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    //color: active,
                    border: Border.all(color: active),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Container(

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: kDefaultPadding / 2),



                                Expanded(

                                  child: Text(statename,style: TextStyle(color: active,),),
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
                            child: Icon( CupertinoIcons.chevron_up_chevron_down,color: active,),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),


              InkWell(
                onTap: () async {
                  if (statename.length > 0) {



                    await FirebaseFirestore.instance.collection('Agents').doc(student.id).update({'state': statename});
                    setState(() {
                      x_State = statename;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Select state"),

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
                    text: "Continue",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding*6),


            ],
          ),
        ),
      ),
    )  : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );





  }
}
MultiProvider buildDeparment() {
  Stream<List<Hostel>> xxx= FirebaseFirestore.instance.collection("Hostels").where("state", isEqualTo: x_State).snapshots().map(videoitems);

  return
    MultiProvider(
        providers: [
          StreamProvider.value(
              value: xxx, initialData: null
          )
        ],child: ListSec());
}

MultiProvider buildDeparmentxxx() {
  Stream<List<Offcamp>> xxx= FirebaseFirestore.instance.collection("Offcamp").where("state", isEqualTo: x_State).snapshots().map(videoitemsxxx);

  return
    MultiProvider(
        providers: [
          StreamProvider.value(
              value: xxx, initialData: null
          )
        ],child: ListSecxxx());
}



List<Hostel> videoitems(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Hostel(
      name: doc.data().toString().contains('name') ? doc.get('name') : '',
      id: doc.data().toString().contains('id') ? doc.get('id') : '',


    );
  }).toList();
}






List<Offcamp> videoitemsxxx(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Offcamp(
      name: doc.data().toString().contains('name') ? doc.get('name') : '',
      id: doc.data().toString().contains('id') ? doc.get('id') : '',


    );
  }).toList();
}




Future<String> getinfo() async {
  ClientInformation info = await ClientInformation.fetch();

  return info.deviceId;

}
List<PersistentBottomNavBarItem> _navBarsItems() {
  return [

    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.checkmark_seal),
      title: ("Orders"),
      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.chat_bubble_text),
      title: ("Chat"),
      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.call),
      title: ("Call"),
      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.money_yen_circle),
      title: ("Revenue"),
      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),


    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.settings),
      title: ("More"),
      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    )


  ];
}







class chat extends StatefulWidget {

  @override
  State<chat> createState() => _chatState();
}



class _chatState extends State<chat> {
  late List<Message> uniquelist;

  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<Message>?>(context);
    if(brewx!=null) {
      var seen = Set<String>();
       uniquelist = brewx!.where((student) =>
          seen.add(student.student)).toList();
    }
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Chats"),
        ),
        // like this!
      ),

      body: brewx!=null?

      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,


              itemCount: uniquelist.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) => msgCard(
                message: uniquelist[index],
                press: () {


                  PersistentNavBarNavigator.pushNewScreen(

                    context,
                    screen:ChatScreen(message:uniquelist[index]),







                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );

                },
              ),
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );

  }
}


class ListSec extends StatefulWidget {
  static String xyyy="";
  static String hosID="";


  @override
  State<ListSec> createState() => _ListSecState();
}

class _ListSecState extends State<ListSec> {
  String depo="Select the hostel you can deliver to imminently";


  @override
  Widget build(BuildContext context) {

    final array = Provider.of<List<Hostel>?>(context);
    final offcamps = Provider.of<List<Offcamp>?>(context);

    if(array!=null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomText(
            text: depo,
            size: 25,
            weight: FontWeight.w600,
            color: Colors.black87,
          ),
          SizedBox(height: kDefaultPadding),

          Center(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: array.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) {

                return GestureDetector(
                    child: Text(array[index]!.name,style: TextStyle(fontSize: 17),),
                    onTap: () {
                      setState(() {
                        ListSec.xyyy=array[index]!.name;
                        ListSec.hosID=array[index]!.id;
                        depo=array[index]!.name;
                      });
                    }
                );
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(thickness: .5,),

            ),
          ),
        ],
      );
    }else{
      return Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Center(),
      );
    }
  }
}








class ListSecxxx extends StatefulWidget {
  static String xyyy="";
  static String hosID="";


  @override
  State<ListSecxxx> createState() => _ListSecStatexxx();
}

class _ListSecStatexxx extends State<ListSecxxx> {
  String depo="You stay off campus?";


  @override
  Widget build(BuildContext context) {

    final array = Provider.of<List<Offcamp>?>(context);

    if(array!=null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomText(
            text: depo,
            size: 25,
            weight: FontWeight.w600,
            color: Colors.black87,
          ),
          SizedBox(height: kDefaultPadding),

          Center(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: array.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) {

                return GestureDetector(
                    child: Text(array[index]!.name,style: TextStyle(fontSize: 17),),
                    onTap: () {
                      setState(() {
                        ListSec.xyyy=array[index]!.name;
                        ListSec.hosID=array[index]!.id;
                        depo=array[index]!.name;
                      });
                    }
                );
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(thickness: .5,),

            ),
          ),
        ],
      );
    }else{
      return Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

















class calls extends StatelessWidget {
  const calls({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Calls",),
        ),
        // like this!
      ),



      body:Container(

        child: Center(
          child: SingleChildScrollView(
            physics: ScrollPhysics() ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(
                  'assets/images/xl.png',
                  width: 350,
                  height: Responsive.isMobile(context)?300:600,

                ),
                SizedBox(height: 20.0),

                Text(
                  'No calls yet',
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

      ),
    );
  }
}

class Revenue extends StatefulWidget {
  const Revenue({
    Key? key,
  }) : super(key: key);

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    List<OnBoardingModel> xx=[];
    final brewx = Provider.of<AgentData>(context);

    int revenue=brewx.deliveries*100;


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Revenue",),
        ),
        // like this!
      ),



      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),



            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: InkWell(
                onTap: () async {


                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text.rich(


                                  TextSpan(
                                    text: "Status\n",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)?20:  16,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    children: [
                                      TextSpan(
                                        text:brewx.active? "Active":"Inactive",
                                        style: TextStyle(
                                          fontSize: Responsive.isDesktop(context)?22:  18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.redAccent,
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),

                              Checkbox(
                                  value: brewx.active,
                                  onChanged: (bool? value) {
                                    DataBaseService(uid: brewx.id,email: firebaseAuth.currentUser!.email).updateActive(value!);
                                  })
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                        ],
                      ),
                    ).addNeumorphism(
                      blurRadius: mode.brightness==Brightness.dark?0: 15,
                      borderRadius: mode.brightness==Brightness.dark?9: 15,
                      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),



            accardyxxx(s:brewx.deliveries.toString(),x:"Number of deliveries",q:Icons.description,press: (){}),


            accardyxxx(s:revenue.toString(),x:"Total revenue",q: Icons.money,press: (){},),

            SizedBox(height: kDefaultPadding),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () async {
                  if(brewx.deliveries>-1){

                   xx= await fetchOnboarding();

                   PersistentNavBarNavigator.pushNewScreen(
                     context,
                     screen:selBank(brewx: xx),
                     withNavBar: false, // OPTIONAL VALUE. True by default.
                     pageTransitionAnimation: PageTransitionAnimation
                         .cupertino,
                   );




                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "The payment threshold is 5 deliveries"),

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
                    text: "Cash out",
                  ),
                ),
              ),
            ),





          ],
        ),
      ),
    );
  }
}



Future<void> _displayTextInputDialog(BuildContext context, String name,String code) async {
  TextEditingController _textFieldController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("ACCOUNT NUMBER"),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Input account number"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text('PROCEED'),
            onPressed: () async {
              print(_textFieldController.text);

              request(_textFieldController.text, code, context);

              Initiatetransfer(await request(_textFieldController.text, code, context));

              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> Initiatetransfer(String s) async {
  FirebaseAuth auth=FirebaseAuth.instance;
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  Response response;
  response = await dio.post('https://api.paystack.co/transfer', data: {"source": "balance","recipient": s,  "amount": "100", "reference": generateRef(),"reason": "Happy payday" });
  var responsex = jsonDecode(response.toString());
  String title = responsex['data']['status'];
  print(title);
}


Future<String> request(String number,String code,BuildContext context) async {
  FirebaseAuth auth=FirebaseAuth.instance;
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  Response response;
  response = await dio.post('https://api.paystack.co/transferrecipient', data: {"type": "nuban",  "account_number": number, "bank_code": code,"currency": "NGN","name": auth.currentUser!.email });
  var responsex = jsonDecode(response.toString());
  String title = responsex['data']['recipient_code'];
  print(title);
  return title.toString();
}

String generateRef() {
  final randomCode = Random().nextInt(3234234);
  return 'ref-$randomCode';
}






class Account extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<AgentData>(context);
    Size _size = MediaQuery
        .of(context)
        .size;
      return Scaffold(

        appBar: AppBar(
          centerTitle: false,
          title: Container(

            child: Text("Account",),
          ),
          // like this!
        ),


        body:brewx!=null? Responsive(

          // Let's work on our mobile part
          mobile: accolumn(brewx: brewx),
          tablet: accolumn(brewx: brewx),
          desktop: accolumn(brewx: brewx),
        ):Center(child: CircularProgressIndicator()),
      );

  }
}

class accolumn extends StatelessWidget {
  const accolumn({
    Key? key,
    required this.brewx,
  }) : super(key: key);

  final AgentData brewx;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final ThemeData mode=Theme.of(context);

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return Scaffold(



      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),

            accard(s:firebaseAuth.currentUser!.email.toString(),x:"Email",q:Icons.email),


            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: InkWell(
                onTap: () async {


                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text.rich(


                                  TextSpan(
                                    text: "Status\n",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)?20:  16,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    children: [
                                      TextSpan(
                                        text:brewx.active? "Active":"Inactive",
                                        style: TextStyle(
                                          fontSize: Responsive.isDesktop(context)?22:  18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.redAccent,
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),

                              Checkbox(
                                  value: brewx.active,
                                  onChanged: (bool? value) {
                                    DataBaseService(uid: brewx.id,email: firebaseAuth.currentUser!.email).updateActive(value!);
                                  })
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                        ],
                      ),
                    ).addNeumorphism(
                      blurRadius: mode.brightness==Brightness.dark?0: 15,
                      borderRadius: mode.brightness==Brightness.dark?9: 15,
                      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            accard(s:brewx.name,x:"Username",q:Icons.person),


            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: InkWell(
                onTap: () async {


                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text.rich(


                                  TextSpan(
                                    text: "Dark mode\n",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)?20:  16,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    children: [
                                      TextSpan(
                                        text: "Theme",
                                        style: TextStyle(
                                          fontSize: Responsive.isDesktop(context)?22:  18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.redAccent,
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),

                              Checkbox(
                                  value: themeChange.darkTheme,
                                  onChanged: (bool? value) {
                                    themeChange.darkTheme = value!;
                                  })
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                        ],
                      ),
                    ).addNeumorphism(
                      blurRadius: mode.brightness==Brightness.dark?0: 15,
                      borderRadius: mode.brightness==Brightness.dark?9: 15,
                      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            accard(s:brewx.disable==false? "Verified":"Not yet verified",x:"Work Permit",q:brewx.disable==false?Icons.done_all:Icons.timelapse),

            accard(s:brewx.number,x:"Phone number",q:Icons.phone),

            accard(s:brewx.hostel,x:"Hostel",q:Icons.home),
            accard(s:brewx.state,x:"State",q:Icons.home),

            accard(s:"Fastfil Agent 1.0",x:"Version",q: Icons.app_settings_alt),

            accard(s:"Lunosmart labs",x:"Developed by",q: Icons.code),
            accard(s:"Chat with us",x:"Send a Whatsapp chat",q: CupertinoIcons.chat_bubble_text),


            accard(s:"Sign out",x:"Privacy",q: Icons.account_box),
            accardy(s:"About us",x:"",q: CupertinoIcons.chevron_forward,press: () {

              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen:About(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation
                    .cupertino,
              );

            }),
            accardy(s:"Contact us",x:"",q: CupertinoIcons.chevron_forward,press: () {

              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen:Contact(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation
                    .cupertino,
              );

            }),


          ],
        ),
      ),
    );
  }
}



class selBank extends StatelessWidget {
  const selBank({
    Key? key,
    required this.brewx,
  }) : super(key: key);

  final List<OnBoardingModel> brewx;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final ThemeData mode=Theme.of(context);

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return Scaffold(



      body:ListView.builder(
        shrinkWrap: true,


        itemCount: brewx.length,
        // On mobile this active dosen't mean anything
        itemBuilder: (context, index) => accardyxx(
          q: brewx[index]!,
          press: () {

            _displayTextInputDialog(context,brewx[index].name , brewx[index].code);



          },
        ),
      ),
    );
  }
}




class accard extends StatelessWidget {
  const accard({
    Key? key, required this.s, required this.x,required this.q
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: () async {
          if(s.contains("Sign out")){
            logOut(context);

          }
          if(s.contains("Chat with us")){
            var whatsapp = "+2349055772501";
            var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
            if (await canLaunchUrl(whatsappAndroid)) {
          await launchUrl(whatsappAndroid);
          } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("WhatsApp is not installed on the device"),),);
            }
          }

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(


                          TextSpan(
                            text: s.length>1? "${x} \n":"${x}",
                            style: TextStyle(
                              fontSize: Responsive.isDesktop(context)?20:  16,
                              fontWeight: FontWeight.w600,
                            ),

                            children: [

                              TextSpan(
                                text: s,
                                style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)?22:  18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Icon(q)

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}


class accardy extends StatelessWidget {
  const accardy({
    Key? key, required this.s, required this.x,required this.q, required this.press
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(s,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                      ),

                      Icon(q)

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}


class accardyxxx extends StatelessWidget {
  const accardyxxx({
    Key? key, required this.s, required this.x,required this.q, required this.press
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child:Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(


                          TextSpan(
                            text:  "${x} \n",
                            style: TextStyle(
                              fontSize: Responsive.isDesktop(context)?20:  16,
                              fontWeight: FontWeight.w600,
                            ),

                            children: [

                              TextSpan(
                                text: s,
                                style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)?22:  18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Icon(q)

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}




class today extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<Orderx>>(context);

    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(


      appBar:AppBar(
        centerTitle: false,
        title: Container(

          child: Text(kIsWeb? "AfriGas Mobile":"AfriGas Mobile",),
        ),

        actions: [


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(onPressed: (){
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Container(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

            }, icon: Icon(CupertinoIcons.bell)),
          )

        ],// like this!
      ),






      body:orders!=null?orders.length>0? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),
            InkWell(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Afrostore(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              },
              child: Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "Purchase cylinders and other accesories\n"),
                          TextSpan(
                            text: "AfriGas Store",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(CupertinoIcons.cart,color: Colors.white,)

                  ],
                ),
              ),
            ),
            CustomText(
              text: "RECENT ORDERS",
              size: 20,
            ),
            SizedBox(height: kDefaultPadding/2),
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
      ):SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),
            InkWell(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Afrostore(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              },
              child: Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "Purchase cylinders and other accesories\n"),
                          TextSpan(
                            text: "AfriGas Store",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(CupertinoIcons.cart,color: Colors.white,)

                  ],
                ),
              ),
            ),

            Column(
              children: [
                CustomText(
                  text: "OUR SERVICES",
                  size: 20,
                ),
                SizedBox(height: kDefaultPadding/2),

                EmailCard(isActive: true,image: "https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/gasrefill2.jpg?alt=media&token=ce06945d-e173-44eb-9650-7108e196b6f5",conyext: "Gas refill",press: (){},),

                SizedBox(height: kDefaultPadding/2),


                EmailCard(isActive: true,image: "https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/cyzz.jpeg?alt=media&token=6350486e-b4fa-4e30-b064-fd860523dcfa",conyext: "Selling of gas cylinders and other accessories",press: (){},),

                SizedBox(height: kDefaultPadding/2),


                CustomText(
                  text: "CALL TO ORDER: 08145678960",
                  size: 20,
                ),

              ],
            ),

            SizedBox(height: kDefaultPadding/2),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [

                  Container(
                    padding: EdgeInsets.all(kDefaultPadding/2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(

                      children: [
                        SizedBox(height: kDefaultPadding / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: kDefaultPadding / 2),



                            Expanded(

                              child: Text.rich(


                                TextSpan(
                                  text:"Are you interested in being one of our agents?\n",
                                  style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)?19: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  children: [

                                    TextSpan(
                                      text: "Submit a request  >",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)?20: 16.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                      ],
                    ),
                  ).addNeumorphism(
                    blurRadius: mode.brightness==Brightness.dark?0: 15,
                    borderRadius: mode.brightness==Brightness.dark?9: 15,
                    offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: kDefaultPadding),

          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}


class products extends StatelessWidget {

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    final student = Provider.of<StudentData>(context);
    final products = Provider.of<List<Product>>(context);


    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: products!=null ?

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,


                itemCount: products.length,
                // On mobile this active dosen't mean anything
                itemBuilder: (context, index) => ProductCard(
                  cart: products[index],
                  press: () {

                  }, student: student,
                ),
              ),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

class usercat extends StatefulWidget {
  @override
  State<usercat> createState() => _usercatState();
}

class _usercatState extends State<usercat> {
  double xxx =0;

  String xoxo="";

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final hostels = Provider.of<List<Hostel?>>(context);

    final student = Provider.of<StudentData>(context);
    final products = Provider.of<List<Cart>>(context);
    String cityNames="";

    Size _size = MediaQuery
        .of(context)
        .size;


    if(products!=null) {
      xxx = products!   .fold(0.00, (sum, item) => sum + item.saleprice*item.numberofproducts);

      setState(() {
        cityNames = products.map((city) => city.description+"---"+"Quantity: "+city.numberofproducts.toString()).toString();

      });

    }


    return Scaffold(


      bottomNavigationBar: CheckoutCard(xxx:xxx,student:student,des:cityNames,hostels:hostels),



      body: products!=null ?

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,


                itemCount: products.length,
                // On mobile this active dosen't mean anything
                itemBuilder: (context, index) => usercartCart(

                  cart: products[index],
                  press: () {

                    print(cityNames);
                  }, student: student,
                ),
              ),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}




Future<List<OnBoardingModel>> fetchOnboarding() async {
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  try {
    Response response = await dio.get("https://api.paystack.co/bank?currency=NGN");
    var responsex = jsonDecode(response.toString());

    List<OnBoardingModel> xxx=[];


    (response.data['data']).forEach((element) {
      xxx.add(new OnBoardingModel(name: element['name'].toString(), slug: element['slug'].toString(), code: element['code'].toString(), currency: element['currency'].toString(),));
    });
    print(xxx[0]);

    // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
    return (xxx);
  } catch (error, stacktrace) {
    throw Exception("Exception occured: $error stackTrace: $stacktrace");
  }
}


class OnBoardingModel {




  OnBoardingModel({
    required this.name,
    required this.slug,
    required this.code,
    required this.currency,
  });

  String name;
  String slug;
  String code;
  String currency;

  @override
  String toString() {
    return '$name, $slug,$code, $currency';
  }
}



class accardyxx extends StatelessWidget {
  const accardyxx({
    Key? key, required this.q, required this.press
  }) : super(key: key);

  final OnBoardingModel q;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);



    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(q.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                      ),


                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}










