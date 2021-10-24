import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/home.dart';
import 'package:restaurant_ui_kit/screens/events.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'package:restaurant_ui_kit/screens/places_of_interest.dart';
import 'package:restaurant_ui_kit/screens/search.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';

import 'home_page.dart';

//TODO Change the wording format (ie. white color hard to see) and change title
//TODO Take out search?
class LocationScreen extends StatefulWidget {
  final String city;

  LocationScreen({
    Key key,
    @required this.city,})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  void initState(){
    print("this is the city of " + widget.city);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(

        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
            children: [
              Divider(),

              SizedBox(height: 10.0),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      //builder: (context) => Home(index: 0, title: "Food", city: widget.city,)
                      builder: (context) => Home(0, "Food", widget.city)
                    )
                  );
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage("assets/food5.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Food",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ),

              SizedBox(height: 10.0),

              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        //builder: (context) => Home(index: 1, title: "Events", city: widget.city,) // I changed from events()
                        builder: (context) => Home(1,  "Events", widget.city)
                    )
                    );
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage("assets/food6.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Events",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ),

              SizedBox(height: 10.0),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        //builder: (context) => Home(index: 2, title: "Places of Interest", city: widget.city,) // I changed from placesofInterest()
                        builder: (context) => Home(2,"Places of Interest", widget.city)
                    )
                    );
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage("assets/food7.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Places of Interest",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ),

              SizedBox(height: 10.0),

              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => MyHomePage(fromMain: true, city: widget.city,)
                    )
                    );
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage("assets/food8.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Meet Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ),
            ]
        ),
      ),
    );
  }
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
      leading: Container(
        height: 1000,
        width: 80,
        child: CircleAvatar(
        backgroundImage: AssetImage(
        'assets/food1.jpeg'),
        ),
      ),
      title: Text('some text'),
      subtitle:
      Text('some text.'),
  );
}

// GestureDetector _stack(String title, String imgPath, BuildContext context, String test) {
//     return GestureDetector(
//       // onTap: (){
//         onTap: () {
//           print("Container clicked");
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => Home()));
//         },
//         child: Stack(
//
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(imgPath),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     title,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 40.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ]
//       )
//   );
// }
