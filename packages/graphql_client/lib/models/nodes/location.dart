part of '../../models.dart';

class LocationReturnOptions {
  bool id;
  bool longitude;
  bool latitude;

  LocationReturnOptions({
    this.id = false,
    this.longitude = false,
    this.latitude = false,
  });
  @override
  String toString() {
    String returnOptions = "";
    if (!id && !longitude & !latitude) id = true;
    returnOptions = _addToReturnList(returnOptions, "id", id);
    returnOptions = _addToReturnList(returnOptions, "longitude", longitude);
    returnOptions = _addToReturnList(returnOptions, "latitude", latitude);
    if (returnOptions != "") {
      returnOptions = "location { \n $returnOptions } \n";
    }
    return returnOptions;
  }
}

class Location {
  String id;
  String? longitude;
  String? latitude;

  Location({
    required this.id,
    this.longitude,
    this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? "",
      longitude: json['longitude'] ?? "",
      latitude: json['latitude'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Location(id: $id, longitude: $longitude, latitude: $latitude';
  }
}
