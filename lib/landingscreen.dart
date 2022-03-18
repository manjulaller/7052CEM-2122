import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:newsapp/Homescreen.dart';
import 'package:newsapp/Signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helpers/helpers.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/download.jpg"), fit: BoxFit.fill)
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Local',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Trajan Pro",
                          fontSize: 37)),
                ],
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Community',
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "lobster",
                        fontSize: 37),
                    colors: animatedtextcolors,
                  ),
                ],
              ),
              SizedBox(
                height: size.width / 2.5,
              ),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: (() {
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Sign_in_screen()));
                }),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      "sign in",
                      style: TextStyle(
                        fontFamily: "trajan pro",
                        fontSize: 22,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 14,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (context) => Homescreen()));
              //       },
              //       child: Text('Skip',
              //           style: TextStyle(
              //               color: Colors.amber,
              //               fontFamily: "lobster",
              //               fontSize: 25)),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
