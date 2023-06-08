import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:com.proyecto.busmate/domain/controller/gestionKML.dart';

class BusRouteMap extends StatefulWidget {
  const BusRouteMap({Key? key}) : super(key: key);

  @override
  _BusRouteMapState createState() => _BusRouteMapState();
}

class _BusRouteMapState extends State<BusRouteMap> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.46314, -73.25322);
  Position? _currentPosition;
  List<LatLng> _routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _determinePosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _loadRoute() async {
    var kmlPath = 'assets/Ruta100.kml';
    try {
      final routeCoordinates = await KMLParser.getRouteCoordinates(kmlPath);
      setState(() {
        _routeCoordinates = routeCoordinates;
      });
    } catch (e) {
      print('Error loading route: $e');
    }
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
                polylines: {
                  Polyline(
                    polylineId: PolylineId('ruta'),
                    color: Colors.blue,
                    width: 2,
                    points: _routeCoordinates,
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: _currentPosition != null
                    ? {
                        Marker(
                          markerId: MarkerId('currentPosition'),
                          position: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          infoWindow: InfoWindow(
                            title: 'Current Position',
                          ),
                        ),
                      }
                    : {},
              ),
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    _loadRoute();
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('Ruta 1'),
                    ),
                  ),
                ),
                // Otros contenedores de ruta
              ],
            ),
          ),
        ],
      ),
    );
  }
}
