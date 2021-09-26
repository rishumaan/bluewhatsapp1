import 'package:bluewhatsapp/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Flexible(//Takes height according to screen vertical distance
                child: Hero(
                  tag: 'Logo',
                  child: Container(
                    child: Image.asset('assets/logo.png'),

                    height: 150.0,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Text(
                'REGISTER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                //Adds @ button in keyboard
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Email', labelText: 'Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password', labelText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              //Using rounded button as only title, color, pressed is changed
              RoundedButton(
                  title: 'Sign Up',
                  colour: Colors.deepPurple,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}