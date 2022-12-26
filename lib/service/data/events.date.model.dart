class EventDateModel {
  String dateType;
  int dateMillis;
  List<String> days;
  int fromMillis;
  int toMillis;

  EventDateModel(this.dateType, this.dateMillis, this.days, this.fromMillis,
      this.toMillis);

  factory EventDateModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventDateModel(
      parsedJson['dateType'] as String,
      parsedJson['dateMillis'] as int,
      List.from(parsedJson['days']),
      parsedJson['fromMillis'] as int,
      parsedJson['toMillis'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'dateType': dateType,
        'dateMillis': dateMillis,
        'days': days,
        'fromMillis': fromMillis,
        'toMillis': toMillis,
      };
}
