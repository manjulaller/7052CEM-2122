import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localcommunity/blocs/auth_bloc.dart';
import 'package:localcommunity/screens/home/home.dart';
import 'package:localcommunity/screens/login/components.dart';
import 'package:localcommunity/screens/login/login.dart';

import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginWithEmailPage extends StatelessWidget {
  final bool isComingFromAuth;

  const LoginWithEmailPage({Key? key, this.isComingFromAuth = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<AuthBloc>(builder: (context, authBloc, __) {
        return authBloc.addLoading
            ? progressIndicator(color: kPrimaryColor)
            : Form(
                key: authBloc.formKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Login Now!".text.xl4.bold.make(),
                    gh(20).heightBox,
                    CustomtextField(
                      controller: authBloc.emailCLogin,
                      validator: validateEmail,
                      hint: "Email address",
                    ),
                    gh(20).heightBox,
                    CustomtextField(
                      controller: authBloc.passCLogin,
                      validator: passwordValidation,
                      isPassword: true,
                      hint: "Password",
                    ),
                    gh(20).heightBox,
                    customLoginButton(
                      isCustom: true,
                      color: kPrimaryColor,
                      title: "Login!".text.xl.white.makeCentered(),
                      onPressed: () async {
                        if (authBloc.formKeyLogin.currentState!.validate())
                          try {
                            authBloc.toggleLoading(true);
                            await auth.signInWithEmailAndPassword(
                                email: authBloc.emailCLogin.text,
                                password: authBloc.passCLogin.text);
                            navigateAndReplaceUntil(context, HomePage());
                            authBloc.toggleLoading(false);
                            authBloc.emailCLogin.clear();
                            authBloc.passCLogin.clear();
                          } on FirebaseAuthException catch (e) {
                            authBloc.toggleLoading(false);
                            context.showToast(msg: e.message!);
                          }
                      },
                    ),
                    gh(20).heightBox,
                    customLoginButton(
                      isCustom: true,
                      color: kSecondryColor.withOpacity(.2),
                      title: "Signup!".text.xl.black.makeCentered(),
                      onPressed: () => isComingFromAuth
                          ? context.pop()
                          : customNavigatorPushSlideRight(
                              context, LoginPage(isComingFromAuth: false)),
                    )
                  ],
                ),
              ).px24();
      }),
    );
  }

  String? passwordValidation(String? val) {
    if (val!.isEmpty) {
      return 'Password can\'t be empty';
    } else if (val.length <= 5) {
      return 'Password should be at least 6 characters';
    }
  }

  String? nameValidation(String? val) {
    if (val!.isEmpty) {
      return 'Name can\'t be empty';
    } else if (val.length <= 5) {
      return 'Name should be at least 6 characters';
    }
  }

  String? validateEmail(String? email) {
    final regEx =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");

    if (!regEx.hasMatch(email!) || email.isEmpty) return "Enter valid email";
  }
}
