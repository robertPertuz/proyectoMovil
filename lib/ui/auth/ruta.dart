import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusRouteMap extends StatefulWidget {
  @override
  _BusRouteMapState createState() => _BusRouteMapState();
}

class _BusRouteMapState extends State<BusRouteMap> {
  late GoogleMapController mapController;

  final LatLng _initialPosition =
      const LatLng(37.77483, -122.41942); // San Francisco
  LatLng _lastMapPosition = const LatLng(37.77483, -122.41942); // San Francisco

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Route Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: _markers,
            onCameraMove: (CameraPosition position) {
              _lastMapPosition = position.target;
            },
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter starting point',
                          border: InputBorder.none,
                          icon: Icon(Icons.location_on, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter destination',
                          border: InputBorder.none,
                          icon: Icon(Icons.location_on, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
