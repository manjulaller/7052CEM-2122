import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';

import 'package:localcommunity/models/issue.dart';
import 'package:provider/provider.dart';

class IssueDetailBlocAndMapViewBloc with ChangeNotifier {
  String issueLocation = '';
  double distance = 0;
  List<PlatformFile> files = [];

  // get location of the issue
  Future getLocationFromLatLng(IssueModel issue) async {
    final location = await GeocodingPlatform.instance.placemarkFromCoordinates(
        issue.location!['lat'], issue.location!['lng']);
    final placemark = location[0];
    final address =
        "${placemark.street}, ${placemark.locality}, ${placemark.subLocality}, ${placemark.postalCode}, ${placemark.country}";
    issueLocation = address;
    notifyListeners();
  }

  calculateDistance(BuildContext context, num lat2, num lon2) {
    final issueBloc = Provider.of<AddIssueBloc>(context, listen: false);

    final lat1 = issueBloc.myLocation!['lat'];
    final lon1 = issueBloc.myLocation!['lng'];

    final d = GeolocatorPlatform.instance
        .distanceBetween(lat1, lon1, lat2.toDouble(), lon2.toDouble());
    distance = d;
    notifyListeners();
  }

  Future pickFiles() async {
    final pickedFiles =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (pickedFiles != null)
      pickedFiles.files.forEach((file) {
        files.add(file);
        notifyListeners();
        print(file.name);
      });
  }

  deleteSingleFileLocallly(PlatformFile file) {
    files.remove(file);
    notifyListeners();
  }
}
