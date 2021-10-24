import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map> categories_food = [
  {
    "name": "Hawker",
    "icon": FontAwesomeIcons.utensils,
    "items": 4
  },
  {
    "name": "Restaurant",
    "icon": FontAwesomeIcons.wineBottle,
    "items": 2
  },
  {
    "name": "Fast Food",
    "icon": FontAwesomeIcons.hamburger,
    "items": 2
  },
];

List<Map> categories_event = [
  {
    "name": "Fitness",
    "icon": FontAwesomeIcons.utensils,
    "items": 4
  },
  {
    "name": "Chill",
    "icon": FontAwesomeIcons.wineBottle,
    "items": 2
  },
  {
    "name": "Family Friendly",
    "icon": FontAwesomeIcons.hamburger,
    "items": 2
  },
];

List<Map> categories_placesofinterest = [
  {
    "name": "Iconics",
    "icon": FontAwesomeIcons.utensils,
    "items": 4
  },
  {
    "name": "Adventures",
    "icon": FontAwesomeIcons.wineBottle,
    "items": 1
  },
  {
    "name": "Arts & Culture",
    "icon": FontAwesomeIcons.hamburger,
    "items": 2
  },
];

List<Map<dynamic, List<Map>>> categories = [{"1" : categories_food}, {"2" : categories_event}, {"3" : categories_placesofinterest}];