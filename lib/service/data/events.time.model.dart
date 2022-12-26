class EventTimeModel {
  bool allDayTime;
  int minutesFrom;
  int minutesTo;

  EventTimeModel(this.allDayTime, this.minutesFrom, this.minutesTo);

  factory EventTimeModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventTimeModel(
      parsedJson['allDayTime'] as bool,
      parsedJson['minutesFrom'] as int,
      parsedJson['minutesTo'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'allDayTime': allDayTime,
        'minutesFrom': minutesFrom,
        'minutesTo': minutesTo,
      };
}
