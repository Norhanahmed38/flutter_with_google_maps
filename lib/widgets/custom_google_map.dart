import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(30.57688847003824, 31.509285055789253),
      zoom: 12,
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        mapType: MapType.normal,

        onMapCreated: (controller) {
          googleMapController = controller;
          initmapStyle();
        },
        initialCameraPosition: initialCameraPosition,

        // cameraTargetBounds: CameraTargetBounds(
        //   LatLngBounds(
        //     southwest: LatLng(30.470420322335038, 31.25247963643909),
        //     northeast: LatLng(30.72574765482814, 31.807289205516454),
        //   ),
        // ),
      ),
      Positioned(
        bottom: 16,
        left: 20,
        right: 20,
        child: ElevatedButton(
          onPressed: () {
            CameraPosition newLocation = CameraPosition(
              target: LatLng(31.196991497750247, 29.90543137387283),
              zoom: 10,
            );
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(newLocation),
            );
          },
          child: Text(
            'Change Location',
            style: TextStyle(color: Colors.black),
          ),
        ),
      )
    ]);
  }

  void initmapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }
}
