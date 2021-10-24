import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/trending.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

class FavoriteScreen extends StatefulWidget {
  final String city;
  FavoriteScreen({
    Key key,
    @required this.city,
  }) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
  List<Map> trending = [];
  String city;

  void initState() {
    super.initState();
    city = widget.city;
    getFavourites();

  }

  getFavourites() async {
    dynamic resultant = await DatabaseManager().getFavouritedFood(city);

    if (resultant == null){
      print("Unable to retrieve upcoming meetups");
    } else {
      setState(() {
        this.trending = resultant;
        print("hello");
        print(resultant);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   // super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Food",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
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
              itemCount: trending == null ? 0 :trending.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Map food = trending[index];
//                print(foods);
//                print(foods.length);
                return GridProduct(
                  img: food['img'],
                  isFav: true,
                  name: food['name'],
                  // rating: 5.0,
                  // raters: 23,
                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
