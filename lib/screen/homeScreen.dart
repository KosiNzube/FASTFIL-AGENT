import 'package:flutter/material.dart';

import '../comp2/Appjumbotron.dart';
import '../comp2/footer.dart';
import '../comp2/jumbotron.dart';

import '../components/side_menu.dart';



class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: SideMenu(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[ AppJumbotron(), Footer()],
            ),
          ),
        ),
      ),
    );
  }
}
