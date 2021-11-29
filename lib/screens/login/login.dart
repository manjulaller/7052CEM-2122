import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:localcommunity/blocs/auth_bloc.dart';
import 'package:localcommunity/screens/home/home.dart';

import 'package:localcommunity/screens/login/components.dart';
import 'package:localcommunity/screens/login/email_login/email_login.dart';

import 'package:localcommunity/services/database_service.dart';
import 'package:localcommunity/services/helpers.dart';

import 'package:localcommunity/utils/constants.dart';

import 'package:localcommunity/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final bool isComingFromAuth;

  const LoginPage({Key? key, this.isComingFromAuth = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<AuthBloc>(builder: (context, authBloc, __) {
        return authBloc.addLoading
            ? progressIndicator(color: kPrimaryColor)
            : Form(
                key: authBloc.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Create\nNew Account!".text.xl4.bold.make(),
                    gh(20).heightBox,
                    CustomtextField(
                      controller: authBloc.emailC,
                      validator: validateEmail,
                      hint: "Email address",
                    ),
                    gh(20).heightBox,
                    CustomtextField(
                      controller: authBloc.passC,
                      validator: passwordValidation,
                      isPassword: true,
                      hint: "Password",
                    ),
                    gh(20).heightBox,
                    CustomtextField(
                      controller: authBloc.nameC,
                      validator: nameValidation,
                      hint: "Full Name",
                    ),
                    gh(20).heightBox,
                    customLoginButton(
                      isCustom: true,
                      color: kPrimaryColor,
                      title: "SignUp".text.xl.white.makeCentered(),
                      onPressed: () async {
                        if (authBloc.formKey.currentState!.validate())
                          try {
                            authBloc.toggleLoading(true);
                            final UserCredential? user = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: authBloc.emailC.text,
                                    password: authBloc.passC.text);
                            if (user != null) {
                              PrefHelper().saveUserEmail(authBloc.emailC.text);
                              PrefHelper().saveUserName(authBloc.nameC.text);
                              DatabaseService()
                                  .createUserProfile(user.user!.uid, context);
                            }
                            await navigateAndReplace(context, HomePage());
                            authBloc.toggleLoading(false);
                            authBloc.emailC.clear();
                            authBloc.passC.clear();
                            authBloc.nameC.clear();
                          } on FirebaseAuthException catch (e) {
                            authBloc.toggleLoading(false);
                            context.showToast(msg: e.message!);
                          }
                      },
                    ),
                    gh(20).heightBox,
                    customLoginButton(
                      isCustom: true,
                      color: kSecondryColor.withOpacity(.5),
                      title: "Already have account? Login Now!"
                          .text
                          .xl
                          .white
                          .makeCentered(),
                      onPressed: () => isComingFromAuth
                          ? customNavigatorPushSlideRight(context,
                              LoginWithEmailPage(isComingFromAuth: true))
                          : context.pop(),
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
