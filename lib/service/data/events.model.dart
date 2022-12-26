import 'package:dubai_events/service/data/events.contact.model.dart';
import 'package:dubai_events/service/data/events.date.model.dart';
import 'package:dubai_events/service/data/events.location.model.dart';
import 'package:dubai_events/service/data/events.time.model.dart';

class EventModel {
  String id;
  String uniqueEventId;

  String name;
  String shortDescription;
  String description;

  String coverImageUrl;
  List<String> galleryImageUrls;

  int eventCreatedTimestamp;
  EventTimeModel? eventTime;
  EventDateModel? eventDate;

  double ticketPrice;
  String reservationUrl;
  List<String> categories;
  bool published;

  EventContactModel? eventContact;
  EventLocationModel? eventLocation;

  // user dto fields
  bool saved = false;

  EventModel(
      this.id,
      this.uniqueEventId,
      this.name,
      this.shortDescription,
      this.description,
      this.coverImageUrl,
      this.galleryImageUrls,
      this.eventCreatedTimestamp,
      this.eventDate,
      this.eventTime,
      this.ticketPrice,
      this.reservationUrl,
      this.categories,
      this.published,
      this.eventContact,
      this.eventLocation);

  static List<EventModel> fromJsonList(List<dynamic> parsedJsonList) {
    List<EventModel> result = [];

    for (var element in parsedJsonList) {
      result.add(EventModel.fromJson(element));
    }

    return result;
  }

  factory EventModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventModel(
      parsedJson['id'] as String,
      parsedJson['uniqueEventId'] as String,
      parsedJson['name'] as String,
      parsedJson['shortDescription'] as String,
      parsedJson['description'] as String,
      parsedJson['coverImageUrl'] as String,
      List<String>.from(parsedJson['galleryImageUrls'] as List),
      parsedJson['eventCreatedTimestamp'] as int,
      parsedJson['eventDate'] == null
          ? null
          : EventDateModel.fromJson(parsedJson['eventDate']),
      parsedJson['eventTime'] == null
          ? null
          : EventTimeModel.fromJson(parsedJson['eventTime']),
      parsedJson['ticketPrice'] as double,
      parsedJson['reservationUrl'] as String,
      List<String>.from(parsedJson['categories'] as List),
      parsedJson['published'] as bool,
      parsedJson['eventContact'] == null
          ? null
          : EventContactModel.fromJson(parsedJson['eventContact']),
      parsedJson['eventLocation'] == null
          ? null
          : EventLocationModel.fromJson(parsedJson['eventLocation']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueEventId': uniqueEventId,
        'name': name,
        'shortDescription': shortDescription,
        'description': description,
        'coverImageUrl': coverImageUrl,
        'galleryImageUrls': galleryImageUrls,
        'eventCreatedTimestamp': eventCreatedTimestamp,
        'eventDate': eventDate,
        'eventTime': eventTime,
        'ticketPrice': ticketPrice,
        'reservationUrl': reservationUrl,
        'categories': categories,
        'published': published,
        'eventContact': eventContact,
        'eventLocation': eventLocation
      };
}
