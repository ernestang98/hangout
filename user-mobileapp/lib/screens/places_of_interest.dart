// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/event.dart';
import 'package:restaurant_ui_kit/util/placesofinterest.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/slider_item.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/util/categories_placesofinterest.dart';
import 'package:restaurant_ui_kit/util/trending.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';

class placesOfInterest extends StatefulWidget {
  @override
  _placesOfInterestState createState() => _placesOfInterestState();
}

class  _placesOfInterestState extends State<placesOfInterest> with AutomaticKeepAliveClientMixin< placesOfInterest>{

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
          "Places Of Interest",
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
                  "Trending",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here
            CarouselSlider(
              items: map<Widget>(
                trending,
                    (index, i){
                  Map pois = placesofinterest[index];
                  return SliderItem(
                    img: pois['img'],
                    isFav: false,
                    name: pois['name'],
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

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories_placesofinterest == null?0:categories_placesofinterest.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories_placesofinterest[index];
                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: true,
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "All Nearby Places of Interest",
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
              itemCount: placesofinterest == null ? 0 :placesofinterest.length,
              itemBuilder: (BuildContext context, int index) {
                Map pois = placesofinterest[index];
                return GridProduct(
                  img: pois['img'],
                  isFav: false,
                  name: pois['name'],
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
