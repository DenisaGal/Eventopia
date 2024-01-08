import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MapPage());

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

  class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.8434, 24.9719);

  void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Eventopia'),
          backgroundColor: Colors.blue[500],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ), // CameraPosition
        ), // GoogleMap
      ), // Scaffold
    ); // MaterialApp
  }
  }