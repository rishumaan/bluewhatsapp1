import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bluewhatsapp/AuthScreens/registration_screen.dart';
import 'package:bluewhatsapp/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Animation anim;
  AnimationController cont;

  //Controller for playback
  RiveAnimationController _controller;
  //Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
    cont = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 100.0,
    );
    cont.forward();
    cont.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

  void dispose() {
    cont.stop();
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Hero Animation
            Hero(
              tag: 'Logo',
              child: Container(
                child: Image.asset('assets/logo.png'),

                height: cont.value,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            AnimatedTextKit(
              repeatForever: false,
              animatedTexts: [
                TyperAnimatedText(
                  'Chat App',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Text(
              '${cont.value.toInt()}%',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Sign Up',
              colour: Colors.lightBlue,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
                //Go to registration screen.
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        backgroundColor: Color(0xFF128C7E),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}