import 'package:fillfastAG/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';



class Registermob extends StatefulWidget {
  Registermob({
    Key? key,
    required this.formKeys,
    required this.textControllers,
    required this.nodes,
  }) : super(key: key);

  final GlobalKey<FormState> formKeys;
  final List<TextEditingController> textControllers;
  final List<FocusNode> nodes;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Registermob> {
  AuthSerives _serives = AuthSerives();

  String? mail;

  String? password;

  void logIn(BuildContext context) async {
    final check = widget.formKeys.currentState!.validate();

    mail = widget.textControllers[0].text;
    password = widget.textControllers[1].text;
    if (mail!.isNotEmpty && password!.isNotEmpty) {
      await _serives.registerMailPasword(mail, password,context);
    } else if (mail!.isNotEmpty && password!.isEmpty) {
      FocusScope.of(context).requestFocus(widget.nodes[1]);
    }
  }

  void back(BuildContext context) {
    WelcomeScreen.of(context).onBack();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Back'),
        leading: IconButton(
          onPressed: () => back(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),


      body: Responsive(
        mobile:RegisterCenter(size, context),
        tablet: RegisterCenter(size, context),
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
              child: RegisterCenter(size, context),
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

  Center RegisterCenter(Size size, BuildContext context) {
    return Center(

        child: SingleChildScrollView(
          physics: ScrollPhysics(),

          child: Column(
            children: [
              SizedBox(height: 20.0),

              Image.asset(
                'assets/images/yl.png',
                width: 300,
              ),
              Text(
                'Your new here?',
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
                width: size.width * .8,
                height: 40,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  color: Colors.blue,
                  elevation: 0,
                  textColor: Colors.white,
                  child: Text('Register'),
                  onPressed: () => logIn(context),
                ),
              ),
              SizedBox(height: 70.0),

              /*ChangeNotifierProvider(
                  create: (context)=>GoogleSignInProvider(),


                  child: GoogleSignupButtonWidget()),

               */

            ],
          ),
        ),
      );
  }
}
