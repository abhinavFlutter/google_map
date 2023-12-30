import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class LatLaung extends StatefulWidget {
  const LatLaung({super.key});

  @override
  State<LatLaung> createState() => _LatLaungState();
}

class _LatLaungState extends State<LatLaung> {

  var gps = false;
  var permission = false;
  late StreamSubscription<Position>positionStream;

  late LocationPermission locationPermission;
  late Position position;

  String lat = '';
  String lung = "";

  //method to check gps is enabled or not and ask permission to allow/deney gps access in app
  checkGpsandPermission() async {
    gps = await Geolocator.isLocationServiceEnabled();
    if (gps) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          print("denied");
        }
        else if (locationPermission == LocationPermission.deniedForever) {
          print("permanently denied");
        }
        else {
          permission = true;
        }
      }
      else {
        permission = true;
      }
      if (permission) {
        setState(() {

        });
        getLocation();
      }
      else {
        print("GPS not enabled,turn on GPS");
      }
      setState(() {

      });
    }
  }

  //  getLocation()async{
  //    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //    print(position.latitude);
  //    print(position.longitude);
  //
  //    lat=position.latitude.toString();
  //    lung=position.longitude.toString();
  //
  //  LocationSettings locationSettings=const LocationSettings(
  //    accuracy: LocationAccuracy.high,
  //    distanceFilter: 100
  //  );
  // StreamSubscription<Position> positionStream=Geolocator.getPositionStream(
  //   locationSettings: locationSettings).listen((Position position) {
  //     print(position.longitude);
  //     print(position.latitude);
  //
  //     lung = position.longitude.toString();
  //     lat = position.latitude.toString();
  //
  //
  //
  // });
  //
  //  }
  getLocation() async {
    position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    lung = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      lung = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      checkGpsandPermission();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Text(
            "$lat, $lung"
        ),
      );
    }
  }



