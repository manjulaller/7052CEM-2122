import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localcommunity/utils/size_config.dart';

const Color whiteColor = Colors.white;
const kPrimaryColor = Color(0xff0460D9);
const orangeColor = Color(0xffF2B138);
const kPrimaryTextColor = Colors.black;
double screenHeight = SizeConfig.screenHeight!;
double screenWidth = SizeConfig.screenWidth!;
Color kSecondryColor = Color(0xff75879B);
Color kErrorColor = Color(0xffFF4141);
Color kGreenColor = Color(0xff2AC026);

final nowTime = DateTime.now();
final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

const String apiKey = "AIzaSyBRsqInOG4hY-s8ocRzjLuyCqvKI2QLzhU";
//  indicator
Widget progressIndicator({required Color? color}) => CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color!),
    ).centered();

// navigation
Future customNavigatorPushSlideRight(BuildContext ctx, Widget page) async =>
    await Navigator.of(ctx)
        .push(CupertinoPageRoute(builder: (context) => page));

Future navigateAndReplace(BuildContext context, Widget page) async =>
    await Navigator.of(context)
        .pushReplacement(CupertinoPageRoute(builder: (context) => page));

Future navigateAndReplaceUntil(BuildContext context, Widget page) async =>
    await Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => page),
      (route) => false,
    );

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}
