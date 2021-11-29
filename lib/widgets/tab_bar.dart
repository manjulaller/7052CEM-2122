import 'package:flutter/material.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:velocity_x/velocity_x.dart';

TabBar customTabBar({
  List<Widget>? tabs,
  TabController? controller,
  bool? isScroll = false,
}) =>
    TabBar(
      indicator: BoxDecoration(
        border: Border(bottom: BorderSide(color: kPrimaryTextColor, width: 1)),
      ),
      // overlayColor: MaterialStateProperty.all(lightGreyColor),
      // indicatorSize: TabBarIndicatorSize.label,
      isScrollable: isScroll! ? true : false,
      tabs: tabs!,
      controller: controller,
      indicatorColor: kPrimaryTextColor,
      labelColor: kPrimaryColor,
      labelStyle: TextStyle(
          fontSize: gw(14), fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      unselectedLabelColor: kSecondryColor,
      unselectedLabelStyle: TextStyle(
          fontSize: gw(14), fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    );

Widget bottomNavBtn(
        {required String title,
        required Function() onpress,
        bool isDeal = false,
        Color? color}) =>
    title.text
        .size(gw(15))
        .medium
        .white
        .makeCentered()
        .box
        .width(screenWidth)
        .height(screenHeight * 0.09)
        .color(isDeal ? color! : kPrimaryColor)
        .make()
        .onInkTap(onpress);
