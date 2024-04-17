import 'package:fillfastAG/comp2/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../constants.dart';
import '../responsive.dart';
import '../services/routes.dart';

class Footer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) ? DesktopFooter() : MobileFooter();
  }
}

class DesktopFooter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              kIsWeb?Navigator.pushNamed(context, Routes.privacy):{};

            },
            child: Text(
              'All Right Reserved | Privacy',
              style: TextStyle(fontSize:Responsive.isMobile(context)? 10:16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NavItem(
                title: 'Twitter',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Facebook',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Linkedin',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Instagram',
                tapEvent: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MobileFooter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              kIsWeb?Navigator.pushNamed(context, Routes.privacy):{};

            },
            child: Text(
              'All Right Reserved | Privacy',
              style: TextStyle(fontSize:Responsive.isMobile(context)? 10:16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NavItem(
                title: 'Twitter',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Facebook',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Linkedin',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Instagram',
                tapEvent: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({required this.title, required this.tapEvent});

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: TextStyle(color: kBadgeColor, fontSize:Responsive.isMobile(context)? 12:22),
        ),
      ),
    );
  }
}
