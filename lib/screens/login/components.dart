import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

final enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: kSecondryColor.withOpacity(0.5)),
    borderRadius: BorderRadius.circular(gw(10)));

final errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: kErrorColor),
    borderRadius: BorderRadius.circular(gw(10)));

class CustomtextField extends StatelessWidget {
  final String? hint;
  final bool? isPassword;

  final TextEditingController? controller;

  final String? Function(String?)? validator;

  const CustomtextField({
    Key? key,
    required this.hint,
    required this.validator,
    this.isPassword = false,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // readOnly: enabled,

      // autofillHints: autofillHints,
      // autofocus: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      obscureText: isPassword! ? true : false,
      decoration: InputDecoration(
        labelText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
        disabledBorder: enabledBorder,
        focusedErrorBorder: errorBorder,
        focusedBorder: enabledBorder,
      ),
    );
  }
}

Widget customLoginButton(
        {Function()? onPressed,
        Widget? title,
        bool? isCustom = false,
        Color? color}) =>
    Container(
      child: TextButton(onPressed: onPressed, child: title!),
    )
        .backgroundColor(isCustom! ? color! : kPrimaryTextColor)
        .h(gh(60))
        .cornerRadius((gw(10)));
