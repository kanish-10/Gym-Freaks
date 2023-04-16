import 'dart:convert';

import 'package:gfg_hackathon5/constants.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon5/components/rounded_button.dart';
import 'package:gfg_hackathon5/screens/loading_screen.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key, this.gymf, this.gymo}) : super(key: key);
  static String id = 'registration_screen';
  final gymf;
  final gymo;
  

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  var email;
  var password;
  var location;
  var gymf;
  var gymo;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    gymf = widget.gymf;
    gymo = widget.gymo;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
              child: gymf ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
// Flexible(
//   child: Hero(
//     tag: 'logo',
//     child: SizedBox(
//       height: 200.0,
//       child: Image.asset('images/logo.png'),
//     ),
//   ),
// ),

                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter email'),
// style: kTextfieldTextStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
// style: kTextfieldTextStyle,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        //print(email);
                        //print(password);
                        try {
                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoadingScreen(gymf: gymf, gymo: gymo)),
                            );

                          }
                        }
                        catch(e){
                          print(e);
                        }


// setState(() {
//   showSpinner = true;
// });
// try {
//   final user = await _auth.signInWithEmailAndPassword(
//       email: email, password: password);
//   Navigator.pushNamed(context, ChatScreen.id);
//   setState(() {
//     showSpinner = false;
//   });
// } catch(e){
//   print(e);
// }
                      })
                ],
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
// Flexible(
//   child: Hero(
//     tag: 'logo',
//     child: SizedBox(
//       height: 200.0,
//       child: Image.asset('images/logo.png'),
//     ),
//   ),
// ),

                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter email'),
// style: kTextfieldTextStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
// style: kTextfieldTextStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      location = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Gym Location'),
// style: kTextfieldTextStyle,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        try {
                          var latitude;
                          var longitude;
                          var url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?proximity=ip&access_token=pk.eyJ1IjoianNkZXZlbG9wZXIxMCIsImEiOiJjbGZwNmhtd3cxMm5mM3ZyazUyeTN4bTAxIn0.Zsu9_wKZ4LTTNY4gtu9Y4w';
                          var response = await http.get(Uri.parse(url));
                          var decodedJson = await jsonDecode(response.body);
                          print(decodedJson['features'][0]['geometry']['coordinates']);
                          latitude = decodedJson['features'][0]['geometry']['coordinates'][1];
                          longitude = decodedJson['features'][0]['geometry']['coordinates'][0];

                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoadingScreen(gymf: gymf, gymo: gymo, olatitude: latitude,olongitude: longitude,)),
                            );

                          }
                        }
                        catch(e){
                          print(e);
                        }




// setState(() {
//   showSpinner = true;
// });
// try {
//   final user = await _auth.signInWithEmailAndPassword(
//       email: email, password: password);
//   Navigator.pushNamed(context, ChatScreen.id);
//   setState(() {
//     showSpinner = false;
//   });
// } catch(e){
//   print(e);
// }
                      })
                ],
              )
          ),
        ),
      ),
    );
  }
}


