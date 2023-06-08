import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;

class KMLParser {
  static Future<List<LatLng>> getRouteCoordinates(String filePath) async {
    final String fileContent = await rootBundle.loadString(filePath);
    final XmlDocument document = XmlDocument.parse(fileContent);

    final List<LatLng> coordinates = [];

    final Iterable<XmlElement> coordinatesElements =
        document.findAllElements('LineString');
    for (final XmlElement coordinatesElement in coordinatesElements) {
      final String coordinatesText = coordinatesElement.text.trim();
      final List<String> coordinatePairs = coordinatesText.split(' ');
      for (final String coordinatePair in coordinatePairs) {
        final List<String> coordinateValues = coordinatePair.split(',');
        final double? longitude = coordinateValues.isNotEmpty
            ? double.tryParse(coordinateValues[0])
            : null;
        final double? latitude = coordinateValues.length > 1
            ? double.tryParse(coordinateValues[1])
            : null;
        if (longitude != null && latitude != null) {
          final LatLng coordinate = LatLng(latitude, longitude);
          coordinates.add(coordinate);
        }
      }
    }

    return coordinates;
  }
}
