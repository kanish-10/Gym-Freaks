import 'package:gfg_hackathon5/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon5/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gfg_hackathon5/components/rounded_button.dart';
import 'package:gfg_hackathon5/screens/user_screen.dart';

class WelcomeScreen extends StatefulWidget {
   const WelcomeScreen({Key? key}) : super(key: key);
  static String id = 'welcome_screen';


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

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
                      'Are You A...',
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
                  MaterialPageRoute(builder: (context) => const UserScreen(gymf: true, gymo: false)),
                );
              },
              title: 'Gym Freak!',
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen(gymf: false, gymo: true)),
                );
              },
              title: 'Gym Owner?',
            ),
          ],
        ),
      ),
    );
  }
}

