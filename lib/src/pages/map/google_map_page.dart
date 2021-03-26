import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_stock/src/constants/asset.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  State<GoogleMapPage> createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initMap = CameraPosition(
    target: LatLng(13.7461216, 100.5325268),
    zoom: 9,
  );

  final dummyData = List<LatLng>();
  final _marker = Set<Marker>();

  @override
  void initState() {
    // TODO: implement initState

    dummyData.add(LatLng(13.5840484, 100.5844849));
    dummyData.add(LatLng(13.5815872, 100.6025952));
    dummyData.add(LatLng(13.5872604, 100.6101483));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            trafficEnabled: true,
            zoomControlsEnabled: false,
            markers: _marker,
            mapType: MapType.normal,
            initialCameraPosition: _initMap,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            left: 6,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              onPressed: _pinMarker,
              label: Text('Pin Biker'),
              icon: Icon(Icons.pin_drop),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pinMarker() async {
    _marker?.clear();
    for (var LatLng in dummyData) {
      await _addMarker(
        LatLng,
        title: "cc",
        snippet: "9iijkfdl",
        isShowInfo: true,
      );
    }

    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, double height) async {
    final byteData = await rootBundle.load(path);
    final codec = await instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetHeight: height.toInt(),
    );
    final frameInfo = await codec.getNextFrame();
    final image = await frameInfo.image.toByteData(format: ImageByteFormat.png);
    return image.buffer.asUint8List();
  }

  Future<void> _addMarker(
    LatLng position, {
    String title = 'none',
    String snippet = 'none',
    String pinAsset = Asset.pinBikerImage,
    bool isShowInfo = false,
  }) async {
    final byteData = await getBytesFromAsset(
      pinAsset,
      MediaQuery.of(context).size.height * 0.2,
    );

    final bitmapDescriptor = BitmapDescriptor.fromBytes(byteData);

    final marker = Marker(
      // important. unique id
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: isShowInfo
          ? InfoWindow(
              title: title,
              snippet: snippet,
              onTap: () {
                // _launchMaps(
                //   position.latitude,
                //   position.longitude,
                // );
              },
            )
          : null,
      icon: bitmapDescriptor,
      onTap: () {
        print('lat: ${position.latitude}, lng: ${position.longitude}');
      },
    );

    _marker.add(marker);
  }
}