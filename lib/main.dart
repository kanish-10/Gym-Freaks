// import 'package:gfg_hackathon5/screens/chat_screen.dart';
import 'package:gfg_hackathon5/screens/login_screen.dart';
import 'package:gfg_hackathon5/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon5/screens/user_screen.dart';
import 'package:gfg_hackathon5/screens/welcome_screen.dart';
import 'package:gfg_hackathon5/screens/mapbox_mymap.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        UserScreen.id: (context) => const UserScreen(),
        MapboxMyMap.id: (context) => const MapboxMyMap(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}