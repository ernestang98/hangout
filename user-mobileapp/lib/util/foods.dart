import 'package:flutter/material.dart';

List<Map> foods = [
  {
    "img": "assets/stall1.jpeg",
    "trending": 1,
    "name": "Ding Tai Fung"
  },
  {
    "img": "assets/stall2.jpeg",
    "trending": 1,
    "name": "Meat 4 Meat"
  },
  {
    "img": "assets/stall3.jpeg",
    "trending": 1,
    "name": "Ah Ma Chi Mian"
  },
  {
    "img": "assets/stall4.jpeg",
    "trending": 1,
    "name": "McDonald's"
  },
  {
    "img": "assets/stall5.jpeg",
    "name": "KFC"
  },
  {
    "img": "assets/stall6.jpeg",
    "trending": 1,
    "name": "Soon Soon Wanton Noddles"
  },
  {
    "img": "assets/stall7.jpeg",
    "name": "D'Authentic Nasi Lemak"
  },
  {
    "img": "assets/stall8.jpeg",
    "name": "Four Seasons Chendol"
  },
  {
    "img": "assets/stall9.jpeg",
    "trending": 1,
    "name": "Allauddin Briyani"
  },
  {
    "img": "assets/stall10.jpeg",
    "name": "Hass Bawa"
  },
  {
    "img": "assets/stall11.jpeg",
    "name": "Springleaf Prata"
  },
  {
    "img": "assets/stall12.jpeg",
    "name": "AL Yusra"
  },
  {
    "img": "assets/stall13.jpeg",
    "name": "Whampoa Soya Bean"
  },
  {
    "img": "assets/stall14.jpeg",
    "name": "Xing Long Cooked Food"
  },
  {
    "img": "assets/stall15.jpeg",
    "name": "Indian Muslim Food"
  },
  {
    "img": "assets/stall16.jpeg",
    "name": "Tip Top Western Food"
  },
  {
    "img": "assets/stall17.jpeg",
    "name": "Fukudon"
  },
  {
    "img": "assets/stall18.jpeg",
    "name": "Yok Mari Yok Nasi Padang"
  },
  {
    "img": "assets/stall19.jpeg",
    "name": "Homemade Springroll"
  },
  {
    "img": "assets/stall20.jpeg",
    "name": "Emmanuel Peranakan"
  },
];

List<Map> events_list = [
  {
    "img": "assets/event1.jpeg",
    "trending": 1,
    "name": "Zumba Zumba"
  },
  {
    "img": "assets/event2.jpeg",
    "trending": 1,
    "name": "Teamfight Tactics LoL Competition"
  },
  {
    "img": "assets/event3.jpeg",
    "trending": 1,
    "name": "Outdoor Movies"
  },
  {
    "img": "assets/event4.jpeg",
    "trending": 1,
    "name": "Pasar Malam"
  },
  {
    "img": "assets/event5.jpeg",
    "trending": 1,
    "name": "Let's Get Gains"
  }
];

List<Map> placesofinterest_list = [
  {
    "img": "assets/places1.jpg",
    "trending": 1,
    "name": "Singapore River"
  },
  {
    "img": "assets/places2.jpg",
    "trending": 1,
    "name": "Singapore Zoo"
  },
  {
    "img": "assets/places3.png",
    "trending": 1,
    "name": "Botanics Garden"
  },
  {
    "img": "assets/places4.jpg",
    "trending": 1,
    "name": "Esplanade"
  },
  {
    "img": "assets/places5.jpg",
    "trending": 1,
    "name": "Singapore Flyer"
  }
];

List<Map<dynamic, List<Map>>> combineAll = [{"1" : foods}, {"2" : events_list}, {"3" : placesofinterest_list}];