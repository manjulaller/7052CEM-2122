import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class AddIssueBloc with ChangeNotifier {
  String pickedImage = '';
  final nameC = TextEditingController();
  final locationC = TextEditingController();
  final issueC = TextEditingController();
  bool addLoading = false;
  Map? myLocation;

  toggleLoading(bool load) {
    addLoading = load;
    notifyListeners();
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) pickedImage = image.path;
    notifyListeners();
  }

  Future getMyCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return context.showToast(msg: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return context.showToast(msg: "Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
      return context.showToast(
          msg:
              "Location permissions denied forever. we cannot request permissions");
    }

    final ml = await Geolocator.getCurrentPosition();
    myLocation = {'lat': ml.latitude, 'lng': ml.longitude};
    notifyListeners();
  }
}
