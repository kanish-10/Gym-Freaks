import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gfg_hackathon5/screens/mapbox_mymap.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key, this.olatitude, this.olongitude, this.gymf, this.gymo}) : super(key: key);
  final olatitude;
  final olongitude;
  final gymf;
  final gymo;


  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  var flatitude;
  var flongitude;
  var olatitude;
  var olongitude;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position place = await Geolocator.getCurrentPosition();
    flatitude = await place.latitude!;
    flongitude = await place.longitude;
    print(flatitude);
    print(flongitude);
  }

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    if(widget.gymo){
      olatitude = widget.olatitude;
      olongitude = widget.olongitude;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapboxMyMap(latitude: olatitude, longitude: olongitude,)),
      );
    }else{

      await _determinePosition();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapboxMyMap(latitude: flatitude, longitude: flongitude,)),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
