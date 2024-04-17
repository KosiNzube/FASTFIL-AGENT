import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fillfastAG/pages/page_home.dart';
import 'package:fillfastAG/services/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'auth/auth.dart';
import 'auth/controller2.dart';
import 'comp2/DarkThemeProvider.dart';
import 'comp2/Styles.dart';
import 'modelspx/Agents.dart';
import 'modelspx/student.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
  //  name:"Fast-fil-agent",

    options:FirebaseOptions(apiKey: "AIzaSyBRWe6ljejI4tJLMTfjjfISQniFbNK-S6M", appId: "1:500621667467:web:83e9b590c05ed1f591788e", messagingSenderId: "500621667467", projectId: "afri-gas",storageBucket: "afri-gas.appspot.com",),);

  if(kIsWeb){

  }else{

    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );


    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
    );



    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
    );
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));


  runApp( MyApp());


}



class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }


  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();


    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              initialRoute: Routes.home,
              onGenerateRoute: (RouteSettings settings) {
                return Routes.fadeThrough(settings, (context) {
                  final settingsUri = Uri.parse(settings.name!);
                  final postID = settingsUri.queryParameters['id'];
                  print(postID); //will print "123"




                  if (settings.name!.contains(Routes.privacy)) {
                    return  HomePage();
                  }

                  if (settings.name ==Routes.home) {
                    return MultiProvider(
                        providers: [
                          StreamProvider<Agent?>.value(
                            value: AuthSerives().user,
                            initialData: null,
                          )
                        ],

                        child: Controller2());
                  }


                  return Center(child: CircularProgressIndicator());
                });
              },
            );
          },
        ),);
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}





