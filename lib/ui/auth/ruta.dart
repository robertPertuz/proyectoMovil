import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusRouteMap extends StatefulWidget {
  const BusRouteMap({Key? key}) : super(key: key);

  @override
  _BusRouteMapState createState() => _BusRouteMapState();
}

class _BusRouteMapState extends State<BusRouteMap> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuentra tú BusMate 🚌'),
        backgroundColor: const Color(0xff88d948),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'A donde se dirige?...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Lógica del botón de búsqueda
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 1'),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 2'),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 3'),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 4'),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 5'),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Ruta 6'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
