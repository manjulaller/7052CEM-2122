import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthBloc with ChangeNotifier {
  bool addLoading = false;
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final emailCLogin = TextEditingController();
  final passCLogin = TextEditingController();
  final nameC = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKeyLogin = GlobalKey<FormState>();

  toggleLoading(bool load) {
    addLoading = load;
    notifyListeners();
  }
}
