// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/event.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/slider_item.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/util/trending.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';

class events extends StatefulWidget {
  @override
  _eventsState createState() => _eventsState();
}

class _eventsState extends State<events> with AutomaticKeepAliveClientMixin<events>{

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;
  static var rng = new Random();
  static int randomNumber = rng.nextInt(150);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),

        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Events",
          style: TextStyle(
            color: Colors.black,
          ),

        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,

              size: 22.0,
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return Notifications();
                  },
                ),
              );
            },
            tooltip: "Notifications",
          ),
        ],

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[

            SizedBox(height: 5.0),

            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                border:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending Events",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here
            //ToDo combine with backend firebase
            CarouselSlider(
              items: map<Widget>(
                trending,
                    // this is the function handler which returns a slider item
                    (index, i){
                  Map events = event[index];
                  return SliderItem(
                    img: events['img'],
                    isFav: false,
                    name: events['name'],
                    rating: 5.0,
                    raters: 59,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height/2.4,
                autoPlay: true,
//                enlargeCenterPage: true,
                viewportFraction: 1.0,
//              aspectRatio: 2.0,
              ),
            ),
            // SizedBox(height: 1.0),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "All Nearby Events",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: event == null ? 0 :event.length,
              itemBuilder: (BuildContext context, int index) {
                Map events = event[index];
                return GridProduct(
                  img: events['img'],
                  isFav: false,
                  name: events['name'],
                  // rating: 5.0,
                  // raters: 59,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
