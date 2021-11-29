import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';
import 'package:localcommunity/blocs/auth_bloc.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';

import 'package:localcommunity/services/auth_service.dart';
import 'package:localcommunity/services/storage_service.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class DatabaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storageService = StorageService();

  // create user profile
  Future createUserProfile(String userId, BuildContext context) async {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);

    await _firestore.doc('users/$userId').set({
      'name': authBloc.nameC.text,
      'email': authBloc.emailC.text,
      'pass': authBloc.passC.text
    });
  }

  // database service
  Future createIssue(BuildContext context) async {
    final addIssueBloc = Provider.of<AddIssueBloc>(context, listen: false);
    final filesBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    final user =
        await firestore.doc('users/${AuthService().currentUserId}').get();
    // add issue
    List url = [];
    try {
      addIssueBloc.toggleLoading(true);

      final issue = await _firestore.collection('issues').add({
        'name': addIssueBloc.nameC.text,
        'issue': addIssueBloc.issueC.text,
        // 'location': addIssueBloc.myLocation,
        'location': {
          'lat': addIssueBloc.myLocation!['lat'],
          'lng': addIssueBloc.myLocation!['lng']
        },
        'timeStamp': nowTime,
        'status': 'new',
        'issue_location': addIssueBloc.locationC.text,
        'url': url.isEmpty ? '' : url.first,
        'poster_id': AuthService().currentUserId,
        'poster_name': user['name'],
        'urls': []
      });
      if (addIssueBloc.pickedImage.isNotEmpty) {
        url.add(await _storageService.uploadPhoto(context, issue));
      }
      if (filesBloc.files.isNotEmpty) {
        await _storageService.uploadFiles(context, issue);
      }
      addIssueBloc.toggleLoading(false);
      context.pop();
      filesBloc.files.clear();
      addIssueBloc.pickedImage = '';
      addIssueBloc.issueC.clear();
      addIssueBloc.nameC.clear();
      addIssueBloc.locationC.clear();
      context.showToast(msg: "Issue Added");
    } on FirebaseException catch (e) {
      addIssueBloc.toggleLoading(false);
      context.showToast(msg: e.message!);
    }
  }
}
