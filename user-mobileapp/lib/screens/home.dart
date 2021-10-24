// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/dishes.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';
import 'package:restaurant_ui_kit/widgets/slider_item.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/util/trending.dart';
import 'package:restaurant_ui_kit/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';


// The screen that is the same template to display for all Food, Events and Places of Interest.
// Uses only 2 database for now which is combineAll from foods.dart under utils and categories under categories.dart.
class Home extends StatefulWidget {
  final int index;
  final String title;
  final String city;

  // Home({
  //   Key key,
  //   @required this.index,
  //   @required this.title,
  //   @required this.city,})
  //     : super(key: key);
  const Home(this.index, this.title, this.city);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home>{

  List<Map<dynamic, List<Map>>> combineAll = [];
  List<Map> food = [];
  List<Map> event = [];
  List<Map> places_of_interest = [];
  List favourited = [];
  String username;


  void initState(){
    checkForFavorite();
    super.initState();
    // getFood();
    // getEvent();
    // getPlacesofInterest();
    // getFavoritedList();

    //getCombinedList();

  }

  getFood() async {
    dynamic resultant = await DatabaseManager().getFood(widget.city);
    if (resultant == "null"){
      print("Unable to retrieve food");
    }
    else {
      setState(() {
        this.food = resultant;
        combineAll.add({"1" : this.food});
      });
    }
  }

  getEvent() async {
    dynamic resultant = await DatabaseManager().getEvents(widget.city);
    if (resultant == null){
      print("Unable to retrieve event");
    }
    else {
      setState(() {
        this.event = resultant;
        combineAll.add({"2": this.event});
      });
    }
  }

  getPlacesofInterest() async {
    dynamic resultant = await DatabaseManager().getPlacesOfInterest(widget.city);
    if (resultant == null) {
      print("Unable to retrieve places of interest");
    }
    else {
      setState(() {
        this.places_of_interest = resultant;
        combineAll.add({"3": this.places_of_interest});
      });
    }
  }

  getFavoritedList() async {
    dynamic resultant = await DatabaseManager().getFavouritedList(widget.city);
    if (resultant == null) {
      print("Unable to retrieve places of interest");
    }
    else {
      setState(() {
        this.favourited = resultant;
      });
    }
  }

  void checkForFavorite() async {
    await getFood();
    await getEvent();
    await getPlacesofInterest();
    await getFavoritedList();
    //print(combineAll);
    print(favourited);
    for (int i = 0; i < combineAll[widget.index]["${widget.index+1}"].length; i++ ) {
      for (int j = 0; j <favourited.length; j++ ) {
        if (combineAll[widget.index]["${widget.index + 1}"][i]['name'] == favourited[j]) {
          combineAll[widget.index]["${widget.index + 1}"][i]['isFav'] = true;
          break;
        }
        else {
          combineAll[widget.index]["${widget.index + 1}"][i]['isFav'] = false;
        }
      }

    }
    print(combineAll[widget.index]["${widget.index + 1}"]);


  }



  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    if (list == null) {
      sleep(const Duration(seconds: 5));
    }
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  // checks through the list map of Food/Events/Places of Interest to see if trending is true or not.
  List<T> mapTrending<T>(List list, Function handler) {
    List<T> result = [];
    if (list == null) {
      sleep(const Duration(seconds: 5));
    }
    for (var i = 0; i < list.length; i++) {
      if (list[i]["trending"] == true) {
        result.add(handler(i, list[i]));
      }
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
          "${widget.title}",
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
              items: mapTrending<Widget>(
                combineAll[widget.index]["${widget.index+1}"],
                    (index, i){ // function handler
                  Map food = combineAll[widget.index]["${widget.index+1}"][index];
                  return SliderItem(
                    location: food['location'],
                    img: food['img'],
                    isFav: food['isFav'],
                    name: food['name'],
                    rating: 5.0,
                    raters: 59,
                    index: widget.index,
                    listIndex: index,

                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height/2.5,
                autoPlay: true,
//                enlargeCenterPage: true,
                viewportFraction: 1.0,
//              aspectRatio: 2.0,
              ),
            ),
            // SizedBox(height: 1.0),

            Text(
              "Categories", // changed from cuisine type
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              // Listview here helps to put all the container in one row.
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories[widget.index]["${widget.index+1}"] == null?0:categories[widget.index]["${widget.index+1}"].length,
                itemBuilder: (BuildContext context, int index) {
                  // ToDo change categories as well
                  Map cat = categories[widget.index]["${widget.index+1}"][index];
                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: true,
                    index: widget.index,
                    listIndex: index,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "All Locations",
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
                    (MediaQuery.of(context).size.height / 1.3),
              ),
              itemCount: combineAll[widget.index]["${widget.index+1}"] == null ? 0 :combineAll[widget.index]["${widget.index+1}"].length,
              itemBuilder: (BuildContext context, int index) {
                Map food = combineAll[widget.index]["${widget.index+1}"][index];
                return GridProduct(
                  location: food['location'],
                  img: food['img'],
                  isFav: food['isFav'],
                  name: food['name'],
                  // rating: 5.0,
                  // raters: 59,
                  index: widget.index,
                  listIndex: index,
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
