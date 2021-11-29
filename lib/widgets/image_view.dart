import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:velocity_x/velocity_x.dart';

Widget imageView({required String url, required double radius}) {
  const noPersonImage =
      "https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255532-stock-illustration-profile-placeholder-male-default-profile.jpg";
  return VxBox()
      .roundedFull
      .bgImage(
        DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(url.isEmpty ? noPersonImage : url),
        ),
      )
      .make()
      .circle(
          radius: gw(radius),
          backgroundColor: kSecondryColor.withOpacity(.2),
          border: url.isNotEmpty
              ? Border()
              : Border.all(color: kSecondryColor.withOpacity(.04)));
}

Widget horizontalImageView(String url) {
  return VxBox(
          child: CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (_, s) => VxShimmer(
      child: VxBox().width(screenWidth * .9).height(screenHeight * .3).make(),
    ),
  ))
      .width(screenWidth * .9)
      .height(screenHeight * .3)
      .make()
      .cornerRadius(gw(10));
}

Future showPickerOptions(BuildContext context,
    {required VoidCallback onCameraPress,
    required VoidCallback onGalleryPress}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => VxBox(
      child: Column(
        children: [
          "Choose an option".text.medium.xl2.makeCentered(),
          gh(20).heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomButton(
                bgColor: Colors.transparent,
                borderColor: kSecondryColor.withOpacity(.3),
                onPressed: onCameraPress,
                textColor: kPrimaryTextColor,
                title: "Camera",
              ),
              bottomButton(
                bgColor: kPrimaryColor,
                borderColor: Colors.transparent,
                onPressed: onGalleryPress,
                textColor: whiteColor,
                title: "Gallery",
              ),
            ],
          ),
        ],
      ).px16().py20(),
    ).width(screenWidth).height(gh(190)).make(),
  );
}

Widget bottomButton(
        {Color? bgColor,
        Color? borderColor,
        Color? textColor,
        String? title,
        Function()? onPressed}) =>
    VxBox(
            child: TextButton(
                onPressed: onPressed,
                child: title!.text.color(textColor!).makeCentered()))
        .color(bgColor!)
        .roundedSM
        .border(color: borderColor!)
        .make()
        .w(gw(150))
        .h(gh(55));
