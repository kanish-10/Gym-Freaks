import 'package:gfg_hackathon5/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon5/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gfg_hackathon5/components/rounded_button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key, this.gymf, this.gymo}) : super(key: key);
  static String id = 'user_screen';
  final gymf;
  final gymo;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Hero(
                //   tag: 'logo',
                //   child: SizedBox(
                //     height: 60.0,
                //     child: Image.asset('images/logo.png'),
                //   ),
                // ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Want to...',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(gymf: gymf, gymo: gymo)),
                );
              },
              title: 'Log In?',
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen(gymf: gymf, gymo: gymo)),
                );
              },
              title: 'Register?',
            ),
          ],
        ),
      ),
    );
  }
}
