import 'package:firebase_auth/firebase_auth.dart';

import 'package:localcommunity/services/database_service.dart';

import 'package:localcommunity/utils/constants.dart';

class AuthService extends DatabaseService {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Future<User?> getCureentUser() async => auth.currentUser!;
}
