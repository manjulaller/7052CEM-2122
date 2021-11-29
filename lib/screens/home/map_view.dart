import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';

import 'package:localcommunity/screens/issue_detail/issue_detail.dart';
import 'package:localcommunity/services/auth_service.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localcommunity/models/issue.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final List<IssueModel> allIssues;
  const MapView({Key? key, required this.allIssues}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition? cameraPosition;
  Set<Marker> _markers = {};

  Completer<GoogleMapController> completer = Completer();
  @override
  void initState() {
    final addIssueBloc = Provider.of<AddIssueBloc>(context, listen: false);
    _calculateDistanceAndAddMarkers();

    cameraPosition = CameraPosition(
        target: LatLng(
            addIssueBloc.myLocation!['lat'], addIssueBloc.myLocation!['lng']));

    super.initState();
  }

  // Future _zoomInOrOut() async {
  //   final controller = await completer.future;
  //   final s =await controller.;
  // }

  void _calculateDistanceAndAddMarkers() {
    widget.allIssues
        .where((i) =>
            i.posterId != AuthService().currentUserId && i.status != 'fixed')
        .forEach((issue) {
      final distance = _calculateDistance(context, issue);
      final id = issue.ref!.id;
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(issue.location!['lat'], issue.location!['lng']),
          infoWindow: InfoWindow(
            title: issue.posterName!.firstLetterUpperCase(),
            snippet: issue.issueDescription,
            onTap: () => customNavigatorPushSlideRight(
                context, IssueDetailsPage(gotIssue: issue)),
          ),
        ),
      );

      setState(() {});
      print("distance $distance");
    });
  }

  _calculateDistance(BuildContext context, IssueModel issue) {
    final addIssueBloc = Provider.of<AddIssueBloc>(context, listen: false);

    return GeolocatorPlatform.instance.distanceBetween(
        addIssueBloc.myLocation!['lat'],
        addIssueBloc.myLocation!['lng'],
        issue.location!['lat'],
        issue.location!['lng']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      GoogleMap(
        markers: _markers,
        onMapCreated: (d) {
          _calculateDistanceAndAddMarkers();
          completer.complete(d);
        },
        gestureRecognizers: [
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        ].toSet(),
        initialCameraPosition: cameraPosition!,
        myLocationButtonEnabled: false,
        rotateGesturesEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference(15, 21),
      ).w(screenWidth).h(screenHeight * 0.9),

    );
  }
}
