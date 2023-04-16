import 'package:flutter/material.dart';
import 'package:gfg_hackathon5/components/rounded_button.dart';
import 'package:gfg_hackathon5/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:gfg_hackathon5/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.gymf, this.gymo}) : super(key: key);
  static String id = 'login_screen';
  final gymf;
  final gymo;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late Animation animation;
  // final _auth = FirebaseAuth.instance;
  // bool showSpinner = false;
  var email;
  var password;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter email',
                ),
                // style: kTextfieldTextStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter password'),
                // style: kTextfieldTextStyle,
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'LogIn',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    try{

                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if(user != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoadingScreen(gymf: gymf, gymo: gymo)),
                      );
                    }


                    } catch(e){
                      print(e);
                    }



                    // setState(() {
                    //   showSpinner = true;
                    // });
                    // try {
                    //   final newUser = await _auth.createUserWithEmailAndPassword(
                    //       email: email, password: password);
                    //   if(newUser != null){
                    //     Navigator.pushNamed(context, ChatScreen.id);
                    //   }
                    //   setState(() {
                    //     showSpinner = false;
                    //   });
                    // } catch(e) {
                    //   print(e);
                    // }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
