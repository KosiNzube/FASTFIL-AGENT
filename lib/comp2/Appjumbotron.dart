import 'package:cached_network_image/cached_network_image.dart';
import 'package:fillfastAG/comp2/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';


import 'package:flutter_animator/flutter_animator.dart';

import '../constants.dart';
import '../responsive.dart';
import '../screen/welcome_screen.dart';
import 'main_button.dart';

class AppJumbotron extends StatefulWidget {


  @override
  State<AppJumbotron> createState() => _JumbotronState();
}

class _JumbotronState extends State<AppJumbotron> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Row(
          children: <Widget>[



            Expanded(
                child: Column(
                  mainAxisAlignment: !isMobile(context)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  crossAxisAlignment: !isMobile(context)
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 5,),

                    if (isMobile(context))
                      Image.asset(
                        kIsWeb?'assets/images/xl.png':'assets/images/xxx.png',
                        width: 300,
                        height: Responsive.isMobile(context)?300:600,

                      ),
                    RichText(
                        textAlign: !isMobile(context)
                            ? TextAlign.start
                            : TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Welcome To\n',
                              style: GoogleFonts.caladea(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blueGrey,

                                  fontSize: Responsive.isDesktop(context)? 40:20)),
                          TextSpan(
                              text: kIsWeb? "Fastfil Agent":"Fastfil Agent",
                              style: GoogleFonts.montserrat(
                                  color: kBadgeColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Responsive.isDesktop(context)? 64:32)),
                        ])),
                    Text(
                      'Uber for Gas',
                      textAlign:
                          !isMobile(context) ? TextAlign.start : TextAlign.center,
                      style: GoogleFonts.marcellus(

                          fontWeight:FontWeight.w600,
                          fontSize: Responsive.isDesktop(context)? 40:20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fastfil is a gas delivery startup that aims to relieve students of the stress of walking over long distances to refill their gas cylinders',
                      textAlign:
                          isMobile(context) ? TextAlign.center : TextAlign.start,
                      style:Responsive.isDesktop(context)?GoogleFonts.marcellus(

                          fontSize: Responsive.isDesktop(context)? 36:19):GoogleFonts.marcellus(

                          fontSize: Responsive.isDesktop(context)? 36:19),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          MainButton(
                            title: 'GET STARTED',
                            color: kBadgeColor,
                            tapEvent: () {

                              setState(() {
                                tutotAcc=false;

                              });

                              WelcomeScreen.of(context).jumpSign();

                            },
                          ),
                          MainButton(
                            title: 'BROWSE',
                            color: kBadgeColor,
                            tapEvent: () {

                              setState(() {
                                tutotAcc=true;

                              });


                              WelcomeScreen.of(context).jumpSign();


                            },
                          )
                        ],
                      ),
                    ),



                  ],
                )),
            if (isDesktop(context) || isTab(context))
              Expanded(
                  child: Image.asset(
                'assets/images/xl.png',
                height: size.height * 0.5,
              ))
          ],
        ));
  }
}

bool tutotAcc=false;