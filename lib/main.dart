import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';
import 'package:localcommunity/blocs/auth_bloc.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';

import 'package:localcommunity/screens/home/home.dart';

import 'package:localcommunity/screens/login/login.dart';

import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddIssueBloc>(create: (_) => AddIssueBloc()),
        ChangeNotifierProvider<IssueDetailBlocAndMapViewBloc>(
            create: (_) => IssueDetailBlocAndMapViewBloc()),
        ChangeNotifierProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(
        theme: appTheme(),
        home: AuthCheckWidget(),
      ),
    );
  }
}

class AuthCheckWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (_, snapshot) => snapshot.hasData ? HomePage() : LoginPage(),
    );
  }
}
