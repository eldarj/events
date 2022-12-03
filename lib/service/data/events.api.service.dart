class EventLocationModel {
  String? googleMapsUrl;
  double latitude;
  double longitude;

  EventLocationModel({
    this.googleMapsUrl,
    required this.latitude,
    required this.longitude,
  });
}

class EventContactModel {
  String? phone;
  String? whatsappNumber;

  String? email;

  String? instagramUrl;
  String? twitterUrl;
  String? facebookUrl;

  String? reservationUrl;

  EventContactModel({
    this.phone,
    this.whatsappNumber,
    this.email,
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,
    this.reservationUrl,
  });
}

class EventModel {
  String id;

  String name;
  String description;

  String coverImagePath;
  List<String> galleryImagePaths;

  String type;
  String timestamp;
  String location;
  String ticketPrice;
  String url;

  EventContactModel eventContact;
  EventLocationModel eventLocation;

  // user related fields
  bool saved;

  EventModel(
      this.id,
      this.name,
      this.description,
      this.coverImagePath,
      this.timestamp,
      this.location,
      this.type,
      this.ticketPrice,
      this.saved,
      this.eventContact,
      this.eventLocation,
      {this.galleryImagePaths = const [],
      this.url =
          'https://dubai.platinumlist.net/event-tickets/80632/the-green-planet-dubai'});
}

class EventsAPIService {
  static List<EventModel> getEvents() {
    List<EventModel> events = getMockData();
    return events;
  }

  static List<EventModel> getMockData() {
    List<EventModel> events = [];

    events.add(EventModel(
      '1',
      'Zero Gravity - Grand Opening',
      'Attend the biggest Grand Opening - Zero Gravity ever. '
          'Zero Gravity is the best pool and beach bar night club in Dubai. '
          'We are offering the Best Ladies night and DJs party in Dubai, UAE. '
          'Relaxed eatery at a private pool & beach club offering a varied menu for breakfast, lunch & dinner.',
      'https://comingsoon.ae/wp-content/uploads/2016/11/zero-grav-1.jpg',
      '1672002133000',
      'Zero Gravity',
      'Beach Club',
      '300',
      false,
      EventContactModel(
        email: 'reservations@0gravity.com',
        instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
        phone: '+38762871955',
        whatsappNumber: '+38762871955',
        reservationUrl: 'https://www.google.com/maps/reserve/partners',
      ),
      EventLocationModel(
        googleMapsUrl:
            'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
        latitude: 25.0890189,
        longitude: 55.1374003,
      ),
      galleryImagePaths: [
        'https://comingsoon.ae/wp-content/uploads/2016/11/zero-grav-1.jpg',
        'https://www.0-gravity.ae/sites/default/files/home-hilite1.jpg',
        'https://www.0-gravity.ae/sites/default/files/events_2.jpg',
        'https://www.0-gravity.ae/sites/default/files/Salut%20Photo.jpeg',
        'https://www.0-gravity.ae/sites/default/files/Zero_033_19.jpg'
      ],
    ));

    events.add(EventModel(
        '1',
        'Jazz Classics',
        """
On Saturday 1st October, we invite you to an extraordinary evening of Jazz Classics by Dubai Opera Big Band! 
An exquisite collection of compositions from the repertoire of legends from the world of jazz. 

In this special event, Dubai Opera Big Band will be paying tribute to the compositions of iconic artists such as Frank Sinatra, Ella Fitzgerald, Aretha Franklin, Nina Simone and Nat King Cole.

Expect to hear unforgettable songs, include: Fly Me To The Moon, My Way, Respect, I Put A Spell on You, Summertime, What A Wonderful World, The Girl From Ipanema and many, many more.  

The Dubai Opera Big Band features twenty of the very best Jazz musicians in the UAE and GCC, led by the talented Adam Long and Musical Director Andy Berryman.

The orchestral sound is topped off by the stunning vocals of three exceptional artists, Andrea Florez, Naz Holland and Ciaran Fox. 
      """,
        'https://cdncms.dubaiopera.com/wp-content/uploads/2022/05/1OCT-HERO.jpg',
        '1672002133000',
        'Dubai Opera',
        'Opera',
        '250',
        false,
        EventContactModel(
          email: 'reservations@0gravity.com',
          instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
          phone: '+38762871955',
          whatsappNumber: '+38762871955',
          reservationUrl: 'https://www.google.com/maps/reserve/partners',
        ),
        EventLocationModel(
          googleMapsUrl:
              'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
          latitude: 25.0890189,
          longitude: 55.1374003,
        )));

    events.add(EventModel(
        '1',
        'ARTE, THE MAKERS’ MARKET',
        '''
ARTE, the acronym for ‘Artisans of the Emirates’ and known to be the biggest market for handmade products provides artistic arts, design, fashion, crafts, some sweet delights, all handmade right here in the UAE by its vendors.

See you there!

Location: First Floor
      ''',
        'https://www.mercatoshoppingmall.com/wp-content/uploads/2022/09/Oct-Mercato-4.png',
        '1672002133000',
        'Mercato - The Good Life',
        'Movie Premiere',
        '125.50',
        false,
        EventContactModel(
          email: 'reservations@0gravity.com',
          instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
          phone: '+38762871955',
          whatsappNumber: '+38762871955',
          reservationUrl: 'https://www.google.com/maps/reserve/partners',
        ),
        EventLocationModel(
          googleMapsUrl:
              'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
          latitude: 25.0890189,
          longitude: 55.1374003,
        )));

    events.add(EventModel(
        '1',
        'Leading with Agility and Resilience',
        '''
The course uses a mix of interactive techniques such as brief presentations by the participants, role plays (rehearsed and impromptu), playback of videotaped performances, individual and group feedback, individual exercises, and team exercises.

Course Objectives
By the end of the course, participants will be able to:

Recognize the importance of leading agile and resilient organizations during turbulent times
Assess leadership capabilities for agility and resilience
Lead and develop proactive mechanisms to withstand environmental disruptions
Create compelling strategies to lead and drive agility and resilience
Execute strategies to build and enhance agile and resilient organizations
Target Audience
Executives, directors, senior managers, division managers, team leaders and all professionals who want to be updated with the latest trends in management and leadership

Target Competencies
Organizational resilience
Workforce agility
Self-awareness
Process innovation
Empowerment
Engagement
Managing disruptions
Strategic versatility
      ''',
        'https://www.meirc.com/assets/images/course-image/course/leading-agility-resilience-courses.jpg',
        '1672002133000',
        'Meirc Training & Consulting',
        'Conference',
        '800',
        false,
        EventContactModel(
          email: 'reservations@0gravity.com',
          instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
          phone: '+38762871955',
          whatsappNumber: '+38762871955',
          reservationUrl: 'https://www.google.com/maps/reserve/partners',
        ),
        EventLocationModel(
          googleMapsUrl:
              'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
          latitude: 25.0890189,
          longitude: 55.1374003,
        )));

    events.add(EventModel(
        '1',
        'Zero Gravity - Grand Opening',
        'Attend the biggest Grand Opening - Zero Gravity ever. '
            'Zero Gravity is the best pool and beach bar night club in Dubai. '
            'We are offering the Best Ladies night and DJs party in Dubai, UAE. '
            'Relaxed eatery at a private pool & beach club offering a varied menu for breakfast, lunch & dinner.',
        'https://comingsoon.ae/wp-content/uploads/2016/11/zero-grav-1.jpg',
        '1672002133000',
        'Zero Gravity',
        'Beach Club',
        '300',
        false,
        EventContactModel(
          email: 'reservations@0gravity.com',
          instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
          phone: '+38762871955',
          whatsappNumber: '+38762871955',
          reservationUrl: 'https://www.google.com/maps/reserve/partners',
        ),
        EventLocationModel(
          googleMapsUrl:
              'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
          latitude: 25.0890189,
          longitude: 55.1374003,
        )));

    events.add(EventModel(
        '1',
        'Scalathon - Learn How to Grow Your Business',
        '''
      Find your company’s hidden, untapped value with the help of eight world-class coaches. Kane and Alessia Minkus, Kelly Lundberg, Sir Brad Blazar, Matt Elwell, Nick James, Christopher Kai and Ted McGrath will be leading this two-day convention from 2-3 October at the 
      Dubai World Trade Centre
      , teaching you all the tips and tricks to scale your business from five to seven figures and more.
      Become a networking champion and acquire the necessary skills to automate your sales and marketing for accelerated growth. Scalathon will provide product owners, entrepreneurs and investors knowledge to up your game, build a reliable future for your brand and increase your profits. Sign up today.
          ''',
        'https://www.visitdubai.com/-/media/gathercontent/event/s/scaleathon-eventorganiser-aug-2022.jpg?rev=c8b0b0cf3bfe464ab8b5a358f7857836&cx=0.49&cy=0.42&cw=795&ch=595',
        '1672002133000',
        'Scalathon - Avenue 36th',
        'Conference',
        '920.10',
        false,
        EventContactModel(
          email: 'reservations@0gravity.com',
          instagramUrl: 'https://www.instagram.com/zerogravitydubai/?hl=en',
          phone: '+38762871955',
          whatsappNumber: '+38762871955',
          reservationUrl: 'https://www.google.com/maps/reserve/partners',
        ),
        EventLocationModel(
          googleMapsUrl:
              'https://www.google.com/maps/place/Zero+Gravity+Dubai/@25.0890189,55.1352116,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f14b2cdab2381:0x65be5b0cfdf7dfa!8m2!3d25.0890189!4d55.1374003',
          latitude: 25.0890189,
          longitude: 55.1374003,
        )));

    return events;
  }
}
