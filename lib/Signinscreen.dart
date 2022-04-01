import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:newsapp/Homescreen.dart';
import 'package:newsapp/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Sign_in_screen extends StatefulWidget {
  const Sign_in_screen({Key? key}) : super(key: key);

  @override
  State<Sign_in_screen> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<Sign_in_screen> {
  final email_con = TextEditingController();
  final pass_con = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/download.jpg"), fit: BoxFit.fill)
          ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Trajan Pro",
                        fontSize: 35)),
              ],
            ),
            SizedBox(
              height: 34,
            ),
            Form(
              key: _formkey,
                child: Column(
              children: [
                
                SizedBox(
              height: 14,
            ),
                email_field(email_con, "enter email ", "email"),
                SizedBox(
              height: 14,
            ),
                email_field(pass_con, "enter password ", "password"),
               
                SizedBox(
              height: 14,
            ),
              ],
            )),
             SizedBox(
              height: 48,
            ),
            GestureDetector(
              onTap: (() {
               Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Homescreen()));
              }),
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                child: Center(
                  child: Text(
                    "Sign In",
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
             GestureDetector(
              onTap: (() {
                Navigator.pop(context);
              }),
              child: Container(
                height: 50,
                width: size.width,
            decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                child: Center(
                  child: Text(
                    "back",
                    style: TextStyle(
                        fontFamily: "trajan pro",
                        fontSize: 22,
                        color: Colors.blue[900],
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
