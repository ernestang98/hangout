// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/util/comments.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

// screens for actual stall details. Called in grid_product and slider_item
// index refer to Food, Events or Places of Interest
// listIndex refer to the list index of the actual stall
// need to change isFav here
class ProductDetails extends StatefulWidget {
  final int index;
  final int listIndex;
  final String name;
  final String location;
  final bool isFav;
  const ProductDetails(this.index, this.listIndex, this.name, this.location, this.isFav);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<Map<dynamic, List<Map>>> combineAll = [];
  List<Map> food = [];
  List<Map> event = [];
  List<Map> places_of_interest = [];
  String username;
  bool isfav ;

  void initState(){
    super.initState();
    print("details widget.isFav is ${widget.isFav}");
    isfav = widget.isFav;
    getFood();
    getEvent();
    getUsername();
    getPlacesofInterest();
    //getCombinedList();

  }

  getUsername() async {
    dynamic resultant = await DatabaseManager().getUsername();

    if (resultant == null){
      print("Unable to retrieve username");
    } else {
      setState(() {
        username = resultant;
      });
    }
  }

  getFood() async {
    dynamic resultant = await DatabaseManager().getFood('Ang Mo Kio');
    if (resultant == null){
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
    dynamic resultant = await DatabaseManager().getEvents('Ang Mo Kio');
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
    dynamic resultant = await DatabaseManager().getPlacesOfInterest('Ang Mo Kio');
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "Details",
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${combineAll[widget.index]["${widget.index + 1}"][widget.listIndex]['img']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {
                      setState(() => isfav = !isfav);
                      DatabaseManager().addFavourites(widget.name, widget.location);
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isfav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              "${combineAll[widget.index]["${widget.index + 1}"][widget.listIndex]['name']}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            //   child: Row(
            //     children: <Widget>[
            //       SmoothStarRating(
            //         starCount: 5,
            //         color: Constants.ratingBG,
            //         allowHalfRating: true,
            //         rating: 5.0,
            //         size: 10.0,
            //       ),
            //       SizedBox(width: 10.0),
            //       Text(
            //         "5.0 (59 Reviews)",
            //         style: TextStyle(
            //           fontSize: 11.0,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "Location",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10.0),
            // ToDo change to database location
            Text(
              "${combineAll[widget.index]["${widget.index + 1}"][widget.listIndex]['location']}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Product Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            // ToDo change to database description
            Text(
              "${combineAll[widget.index]["${widget.index + 1}"][widget.listIndex]['description']}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.0),
            // Text(
            //   "Reviews",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w800,
            //   ),
            //   maxLines: 2,
            // ),
            // SizedBox(height: 20.0),
            // ListView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: comments == null ? 0 : comments.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map comment = comments[index];
            //     return ListTile(
            //       leading: CircleAvatar(
            //         radius: 25.0,
            //         backgroundImage: AssetImage(
            //           "${comment['img']}",
            //         ),
            //       ),
            //       title: Text("${comment['name']}"),
            //       subtitle: Column(
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               SmoothStarRating(
            //                 starCount: 5,
            //                 color: Constants.ratingBG,
            //                 allowHalfRating: true,
            //                 rating: 5.0,
            //                 size: 12.0,
            //               ),
            //               SizedBox(width: 6.0),
            //               Text(
            //                 "February 14, 2020",
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w300,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 7.0),
            //           Text(
            //             "${comment["comment"]}",
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            SizedBox(height: 10.0),
          ],
        ),
      ),


    );
  }
}
