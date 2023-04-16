import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class MapboxMyMap extends StatefulWidget {
  const MapboxMyMap({Key? key, this.latitude, this.longitude}) : super(key: key);
  final latitude;
  final longitude;
  static String id = 'mapbox_mymap';

  @override
  State<MapboxMyMap> createState() => _MapboxMyMapState();
}

class _MapboxMyMapState extends State<MapboxMyMap> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  var latitude;
  var longitude;

  late MapboxMapController mapboxMapController;
  void _onMapCreated(MapboxMapController controller){
    mapboxMapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    latitude = widget.latitude;
    longitude = widget.longitude;
  }
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // height:2* (MediaQuery.of(context).size.height/3),
        child: MapboxMap(
          myLocationEnabled: true,
          accessToken: 'pk.eyJ1IjoianNkZXZlbG9wZXIxMCIsImEiOiJjbGZwNmhtd3cxMm5mM3ZyazUyeTN4bTAxIn0.Zsu9_wKZ4LTTNY4gtu9Y4w',
          styleString: MapboxStyles.DARK,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: LatLng(latitude, longitude)),
          minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (selectedIndex) {
          setState(() {
            _index = selectedIndex;
            if(_index == 0) {
              _auth.signOut();
              Navigator.pop(context);
            }
          });
        },
        currentIndex: _index,
        items: const [BottomNavigationBarItem(
          icon: Icon(Icons.logout, color: Colors.lightBlueAccent,), label: 'Sign Out'),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood, color: Colors.lightBlueAccent,), label: 'Restaurants Table')],

      ),
    );
  }
}

