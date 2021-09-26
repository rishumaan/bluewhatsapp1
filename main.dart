import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '';
import 'AuthScreens/home_screen.dart';
import 'AuthScreens/login_screen.dart';
import 'AuthScreens/registration_screen.dart';
import 'AuthScreens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(



  ));


}
class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,

      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );



  }
}


