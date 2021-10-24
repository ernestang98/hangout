class Event {
  String keyID;
  String joined;
  String name;
  String description;
  DateTime eventDate;
  String date;
  String day;
  String month;
  String week;
  String image;
  String category;
  String location;
  String organizer;
  List participants;
  num price;

  Event({
    this.eventDate,
    this.keyID,
    this.joined,
    this.image,
    this.location,
    this.name,
    this.organizer,
    this.participants,
    this.price,
    this.description,
    this.category,
    this.date,
    this.month,
    this.day,
    this.week,
  });

  void splitJoin() {
    this.participants = [];
    //this.participants.add("Aang");
    if (this.joined == null) {
      print("forget it");
    }
    else if (this.joined.contains(",")){
      var join = this.joined.split(",");
      for (int i = 0; i < join.length; i++) {
        this.participants.add(join[i].trim());
      }
    }
    else{
      this.participants.add(this.joined.trim());
    }

  }




}

final List<Event> upcomingEvents = [
  Event(
      name: "Cook with Me!",
      eventDate: DateTime.now().add(const Duration(days: 24)),
      image: 'https://source.unsplash.com/800x600/?cook',
      description:
          "All the cooking enthusiast let's get together and exchange our culinary skills!",
      location: "Tampines Street 81",
      organizer: "Vivian Tan",
      participants: ["Jethro", "Alicia"]
      //price: 30,
      ),
  Event(
    name: "Explore our area together",
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://source.unsplash.com/800x600/?community',
    description:
        "Let us go on an adventure to explore our beautiful community together! We will be exploring these areas:",
    location: "Tampines",
    organizer: "Bryan Ong",
    //price: 30,
  ),
  Event(
    name: "Musicians of the area",
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://source.unsplash.com/800x600/?music',
    description:
        "Musicians of Tampines unite! Let us come together, play some songs and enjoy ourselves!",
    location: "Tampines East CC Music Room",
    organizer: "Lisbeth Ang",
    //price: 30,
  ),
];

final List<Event> nearbyEvents = [
  Event(
    name: "Cook with Me!",
    eventDate: DateTime.now().add(const Duration(days: 24)),
    image: 'https://source.unsplash.com/800x600/?cook',
    description:
        "All the cooking enthusiast let's get together and exchange our culinary skills!",
    location: "Tampines Street 81",
    organizer: "Vivian Tan",
    //price: 30,
  ),
  Event(
    name: "Badminton Buddies",
    eventDate: DateTime.now().add(const Duration(days: 4)),
    image: 'https://source.unsplash.com/600x800/?badminton',
    description: "Looking for buddies to play badminton together!",
    location: "Tampines Hub",
    organizer: "Westfield Centre",
    //price: 30,
  ),
  Event(
    name: "Mahjong Kakis",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://source.unsplash.com/600x800/?mahjong',
    description:
        "Anyone keen to play mahjong together? Come join us! We need 2 more people!",
    location: "Tampines Street 33",
    organizer: "Tan Hui Hui",
    //price: 30,
  ),
  Event(
    name: "Calling all KDrama Lovers!",
    eventDate: DateTime.now().add(const Duration(days: 21)),
    image: 'https://source.unsplash.com/600x800/?korea',
    description:
        "Calling all Korean Drama lovers! We can meet up to explore new dramas to watch, discuss popular dramas and have fun!",
    location: "Tampines Mall",
    organizer: "KdramaLover",
    //price: 32,
  ),
  Event(
    name: "Chinese Drama Lovers here!",
    eventDate: DateTime.now().add(const Duration(days: 16)),
    image: 'https://source.unsplash.com/600x800/?china',
    description:
        "This meetup is for all the chinese drama lovers! Hope to see yall there!",
    location: "Tampines Chinese Centre",
    organizer: "CdramaLover",
    //price: 14,
  ),
];

final List<Event> myEvents = [
  Event(
    name: "Cook with Me!",
    eventDate: DateTime.now().add(const Duration(days: 24)),
    //image: 'https://source.unsplash.com/800x600/?cook',
    // description:
    //     "All the cooking enthusiast let's get together and exchange our culinary skills!",
    location: "Tampines Street 81",
    // organizer: "Vivian Tan",
    //price: 30,
  ),
  Event(
    name: "Badminton Buddies",
    eventDate: DateTime.now().add(const Duration(days: 4)),
    //image: 'https://source.unsplash.com/600x800/?badminton',
    // description: "Looking for buddies to play badminton together!",
    location: "Tampines Hub",
    // organizer: "Westfield Centre",
    //price: 30,
  ),
  Event(
    name: "Mahjong Kakis",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    //image: 'https://source.unsplash.com/600x800/?mahjong',
    // description:
    //     "Anyone keen to play mahjong together? Come join us! We need 2 more people!",
    location: "Tampines Street 33",
    // organizer: "Tan Hui Hui",
    //price: 30,
  ),
  Event(
    name: "Calling all KDrama Lovers!",
    eventDate: DateTime.now().add(const Duration(days: 21)),
    //image: 'https://source.unsplash.com/600x800/?korea',
    //description:
    //"Calling all Korean Drama lovers! We can meet up to explore new dramas to watch, discuss popular dramas and have fun!",
    location: "Tampines Mall",
    // organizer: "KdramaLover",
    //price: 32,
  ),
  Event(
    name: "Chinese Drama Lovers here!",
    eventDate: DateTime.now().add(const Duration(days: 16)),
    //image: 'https://source.unsplash.com/600x800/?china',
    //description:
    // "This meetup is for all the chinese drama lovers! Hope to see yall there!",
    location: "Tampines Chinese Centre",
    // organizer: "CdramaLover",
    //price: 14,
  ),
];
