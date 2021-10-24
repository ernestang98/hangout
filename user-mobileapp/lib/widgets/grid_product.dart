import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/details.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

// called in home.dart. Under All stalls
// index refer to Food, Events or Places of Interest
// listIndex refer to the list index of the actual stall
// for statelesswidget, you can change the
class GridProduct extends StatefulWidget {

  final String location;
  final String name;
  final String img;
  final bool isFav;

  // final double rating;
  // final int raters;
  final int index;
  final int listIndex;


  GridProduct({
    Key key,
    @required this.name,
    @required this.img,
    @required this.isFav,
    @required this.location,
    // @required this.rating,
    // @required this.raters,
    @required this.index,
    @required this.listIndex})
      :super(key: key);

  @override
  _GridProductState createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  bool isfav;

  @override
  void initState(){
    super.initState();
    print(isfav);
    print("grid product widget is fav is ${widget.isFav}");
    isfav = widget.isFav;

  }

  @override
  Widget build(BuildContext context) {
    // returns inkwell that will be returned to gridview builder
    return InkWell(
      // each of this listview represents one container with image, name and ratings. Default is column wise.
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "${widget.img}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                right: -10.0,
                bottom: 3.0,
                child: RawMaterialButton(
                  onPressed: (){
                    print("hello did anything change");
                    setState(() => isfav = !isfav);
                    DatabaseManager().addFavourites(widget.name, widget.location);
                  },
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],


          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "${widget.name}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          //   child: Row(
          //     children: <Widget>[
          //       SmoothStarRating(
          //         starCount: 5,
          //         color: Constants.ratingBG,
          //         allowHalfRating: true,
          //         rating: rating,
          //         size: 10.0,
          //       ),
          //
          //       Text(
          //         " $rating ($raters Reviews)",
          //         style: TextStyle(
          //           fontSize: 11.0,
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // ),


        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProductDetails(widget.index, widget.listIndex, widget.name, widget.location, widget.isFav) // I changed from events()
        )
        );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context){
        //       return ProductDetails(index);
        //     },
        //   ),
        // );
      },
    );
  }
}
