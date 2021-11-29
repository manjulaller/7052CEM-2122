import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localcommunity/services/auth_service.dart';
import 'package:provider/provider.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;

  // uploadPhoto
  Future uploadPhoto(BuildContext context, DocumentReference issue) async {
    final addIssueBloc = Provider.of<AddIssueBloc>(context, listen: false);
    final image = await _storage
        .ref("${AuthService().currentUserId}/${issue.id}")
        .putFile(File(addIssueBloc.pickedImage));
    await issue.update({'url': await image.ref.getDownloadURL()});
  }

  Future uploadFiles(BuildContext context, DocumentReference issue) async {
    final addIssueBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);

    try {
      addIssueBloc.files.forEach((file) async {
        final uploadedFile = await _storage
            .ref('${AuthService().currentUserId}/${issue.id}/${file.name}')
            .putFile(File(file.path!));
        await issue.update({
          'urls': FieldValue.arrayUnion([uploadedFile.ref.fullPath])
        });
      });
    } on FirebaseException catch (e) {
      context.showToast(msg: e.message!);
    }
  }
}
