import 'package:cloud_firestore/cloud_firestore.dart';

class IssueModel {
  final String? issueName;
  final String? issueDescription, locationDesc;
  final String? image, posterId, status, posterName;
  final Map? location;
  final List? files;

  final DateTime? timeStamp;
  final DocumentReference? ref;

  IssueModel({
    this.issueName,
    this.issueDescription,
    this.image,
    this.posterId,
    this.location,
    this.timeStamp,
    this.status,
    this.ref,
    this.posterName,
    this.locationDesc,
    this.files,
  });

  factory IssueModel.fromJson(DocumentSnapshot issue) => IssueModel(
        image: issue['url'],
        issueName: issue['name'],
        posterId: issue['poster_id'],
        posterName: issue['poster_name'],
        ref: issue.reference,
        timeStamp: (issue['timeStamp'] as Timestamp).toDate(),
        issueDescription: issue['issue'],
        status: issue['status'],
        location: issue['location'],
        locationDesc: issue['issue_location'],
        files: issue['urls'],
      );
}
