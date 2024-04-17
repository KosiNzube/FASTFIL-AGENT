import 'package:fillfastAG/screen/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../auth/auth.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';


class Signmob extends StatefulWidget {
  Signmob({
    Key? key,
    required this.formKeys,
    required this.textControllers,
    required this.nodes,
  }) : super(key: key);

  final GlobalKey<FormState> formKeys;
  final List<TextEditingController> textControllers;
  final List<FocusNode> nodes;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Signmob> {
  final AuthSerives _serives = AuthSerives();

  String? mail;

  String? password;

  void signIn(BuildContext context) async {
    widget.formKeys.currentState!.validate();

    mail = widget.textControllers[0].text;
    password = widget.textControllers[1].text;

    if (mail!.isNotEmpty && password!.isNotEmpty) {
      setState(() {
        isLoad = false;
      });
      dynamic user = await _serives.signMailPassword(mail, password,context);
      setState(() {
        isLoad = true;
      });
      if (user == null) {


      } else {
        print('successful signing');
      }
    } else if (mail!.isNotEmpty && password!.isEmpty) {
      FocusScope.of(context).requestFocus(widget.nodes[1]);
    }
  }

  void logIn(BuildContext context) async {
    WelcomeScreen.of(context).jumpLogin();
  }

  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(



      body: Responsive(
          mobile: Signincenter(size, context),
          tablet: Signincenter(size, context),

          desktop: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Expanded(

              flex: size.width > 1340 ? 4 : 7,
              child: Signincenter(size, context),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            ),
          ],
        ),


      ),
    );
  }

  Center Signincenter(Size size, BuildContext context) {
    return Center(
      child: SingleChildScrollView(

        child: Column(
          children: [

            kIsWeb?Container():SizedBox(height: 20.0),


            Image.asset(
              'assets/images/xl.png',
              width: 300,
              height: Responsive.isMobile(context)?300:600,

            ),
            Text(
              'You have an account?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),


            InputWidget(
              formKey: widget.formKeys,
              editController: widget.textControllers,
              itemCount: widget.textControllers.length,
              nodes: widget.nodes,
              icons: [
                Icons.mail,
                Icons.lock,
              ],
              type: [
                TextInputType.emailAddress,
                TextInputType.visiblePassword,
              ],
              titles: [
                'e-mail',
                'password',
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: size.width * .9,
              height: 40,
              child: MaterialButton(
                elevation: 0,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                color: Colors.red,
                textColor: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0.0,
                      child: !isLoad
                          ? Container(

                              width: 20.0,
                              height: 20.0,
                              child: Center(child: CircularProgressIndicator()))
                          : SizedBox.shrink(),
                    ),
                    Center(child: Text('Sign In')),
                  ],
                ),
                onPressed: () => signIn(context),
              ),
            ),
            SizedBox(height: 5,),
            Text('or'),
            SizedBox(height: 5,),

            SizedBox(
              width: size.width * .8,
              height: 38,

              child: MaterialButton(
                elevation: 0,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Register'),
                onPressed: () => logIn(context),
              ),
            ),
            SizedBox(height: kIsWeb? 20.0:70),

            /*
            ChangeNotifierProvider(
              create: (context)=>GoogleSignInProvider(),


                child: GoogleSignupButtonWidget()),

             */

          ],
        ),
      ),
    );
  }
}
