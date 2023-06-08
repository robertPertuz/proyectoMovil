import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart';

class KMLParser {
  static Future<List<LatLng>> getRouteCoordinates(String filePath) async {
    final File file = File(filePath);
    final String fileContent = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileContent);

    final List<LatLng> coordinates = [];

    final Iterable<XmlElement> placemarkElements =
        document.findAllElements('Placemark');
    for (final XmlElement placemarkElement in placemarkElements) {
      final XmlElement lineStringElement =
          placemarkElement.findElements('LineString').first;
      final XmlElement coordinatesElement =
          lineStringElement.findElements('coordinates').first;
      final String coordinatesText = coordinatesElement.text.trim();

      final List<String> coordinatePairs = coordinatesText.split(' ');
      for (final String coordinatePair in coordinatePairs) {
        final List<String> coordinateValues = coordinatePair.split(',');
        if (coordinateValues.length == 2) {
          final double latitude = double.parse(coordinateValues[1]);
          final double longitude = double.parse(coordinateValues[0]);
          final LatLng coordinate = LatLng(latitude, longitude);
          coordinates.add(coordinate);
        }
      }
    }

    return coordinates;
  }
}
