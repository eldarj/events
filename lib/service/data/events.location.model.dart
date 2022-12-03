class EventLocationModel {
  String id;

  String name;

  String address;
  double latitude;
  double longitude;

  String googleMapsUrl;
  String mapImageUrl;

  bool displayLocationMap;

  EventLocationModel(
      this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.googleMapsUrl,
      this.mapImageUrl,
      this.displayLocationMap);

  factory EventLocationModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventLocationModel(
      parsedJson['id'] as String,
      parsedJson['name'] as String,
      parsedJson['address'] as String,
      parsedJson['latitude'] as double,
      parsedJson['longitude'] as double,
      parsedJson['googleMapsUrl'] == null
        ? ""
        : parsedJson['googleMapsUrl'] as String,
      parsedJson['mapImageUrl'] as String,
      parsedJson['displayLocationMap'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'googleMapsUrl': googleMapsUrl,
        'mapImageUrl': mapImageUrl,
        'displayLocationMap': displayLocationMap,
      };
}
