class EventContactModel {
  String phoneNumber;
  String whatsappNumber;

  String email;

  String instagramUrl;
  String twitterUrl;
  String facebookUrl;

  EventContactModel(
    this.phoneNumber,
    this.whatsappNumber,
    this.email,
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,
  );

  factory EventContactModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventContactModel(
      parsedJson['phoneNumber'] as String,
      parsedJson['whatsappNumber'] as String,
      parsedJson['email'] as String,
      parsedJson['instagramUrl'] as String,
      parsedJson['twitterUrl'] as String,
      parsedJson['facebookUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'whatsappNumber': whatsappNumber,
        'email': email,
        'instagramUrl': instagramUrl,
        'twitterUrl': twitterUrl,
        'facebookUrl': facebookUrl,
      };
}
