import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newsapp/IndividualView.dart';
import 'package:permission_handler/permission_handler.dart';

class mapsview extends StatefulWidget {
  const mapsview({Key? key}) : super(key: key);

  @override
  State<mapsview> createState() => _mapsviewState();
}

class _mapsviewState extends State<mapsview> {
  List<LatLng> newslocation = [
    LatLng(27.150368, 72.340910),
    LatLng(30.971408, 63.418259),
    LatLng(40.629018, 64.422796),
    LatLng(41.253910, 77.481775),
  ];
  bool showmaps = false;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    loadlocation();
  }

  loadlocation() async {
// make sure to initialize before map loading
    Permission.locationWhenInUse.request().then((value) {
      if (value.isGranted) {
        Permission.locationAlways.request().then((value) async {
          if (value.isGranted) {
            LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
            }
            if (permission == LocationPermission.whileInUse ||
                permission == LocationPermission.always) {
              BitmapDescriptor startpointicon =
                  await BitmapDescriptor.fromAssetImage(
                      ImageConfiguration(size: Size(1, 1)),
                      'assets/staringpoint.png');
              BitmapDescriptor drivericon =
                  await BitmapDescriptor.fromAssetImage(
                      ImageConfiguration(size: Size(1, 1)),
                      'assets/drivericon.png');

              BitmapDescriptor endpointicon =
                  await BitmapDescriptor.fromAssetImage(
                      ImageConfiguration(size: Size(7, 7)),
                      'assets/endpoint.png');
              await loadissues();
              setState(() {
                showmaps = true;
              });
            }
          }
        });
      }
    });
  }

  loadissues() {
    newslocation.forEach((element) {
      _markers.add(Marker(
          markerId: MarkerId(element.toString()),
          position: element,
          onTap: () {
            mapsdialog();
          }));
    });
  }

  mapsdialog() {
    AwesomeDialog(
      customHeader: Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(
                  "assets/auction.jpg",
                ),
                fit: BoxFit.cover)),
      ),
      context: context,
      dialogBackgroundColor: Colors.black,
      dialogType: DialogType.INFO_REVERSED,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: [
          Text('Issue name',
              style: TextStyle(
                  color: Colors.white, fontFamily: "Trajan Pro", fontSize: 25)),
          Text('Description of issue',
              style: TextStyle(
                  color: Colors.white, fontFamily: "Trajan Pro", fontSize: 25)),
        ],
      ),
      btnOkText: "view",
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => individualview(tag: "d"),));
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          child: showmaps
              ? GoogleMap(
                  markers: Set<Marker>.of(_markers),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(33.691463, 73.159572), zoom: 1))
              : Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                )),
    );
  }
}
