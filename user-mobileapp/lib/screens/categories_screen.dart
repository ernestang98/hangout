import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/details.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/util/categories.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';
import 'package:restaurant_ui_kit/util/hawker.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';


// Screen when we press the category filter
class CategoriesScreen extends StatefulWidget {
  final String catie;
  final int index;

  CategoriesScreen({
    Key key,
    @required this.catie,
    @required this.index})
      : super(key: key);
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String local_catie;
  bool foodDone = false;
  bool eventDone = false;
  bool placeDone = false;
  bool firstTime = true;
  List<Map> newList = [];
  List<Map<dynamic, List<Map>>> combineAll = [];
  List<Map> food = [];
  List<Map> event = [];
  List<Map> places_of_interest = [];
  String username;



  @override
  void initState() {
    local_catie = widget.catie;
    super.initState();
    // getFood();
    // getEvent();
    // getPlacesofInterest();

   getNewList(local_catie);

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
        foodDone = true;
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
        eventDone = true;
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
        placeDone = true;
      });
    }
  }

  void getNewList(String category) async  {
    await getFood();
    await getEvent();
    await getPlacesofInterest();

    print(combineAll[1]);

    if (combineAll[widget.index]["${widget.index+1}"] == null) {
      // sleep(const Duration(seconds: 5));
    }
    for (var i = 0; i < combineAll[widget.index]["${widget.index+1}"].length; i++) {
      if (combineAll[widget.index]["${widget.index+1}"][i]["category"] == category) {
        print("Hello");
        newList.add(combineAll[widget.index]["${widget.index+1}"][i]);
      }
    }
    print(newList);

  }

  List<Map> getNewList2(String category, List<Map> list) {
    List <Map> result = [];
    if (list == null) {
      // sleep(const Duration(seconds: 5));
    }
    print(category);
    for (var i = 0; i < list.length; i++) {
      if (list[i]["category"] == category) {
        print("Hello");
        result.add(list[i]);
      }
    }
    return result;
    print(newList);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Categories",
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
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
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
                    isHome: false,
                    tap: (){
                      setState((){
                        local_catie = "${cat['name']}";
                        newList = getNewList2(local_catie, combineAll[widget.index]["${widget.index+1}"]);

                      });
                    },
                    index: widget.index,
                    listIndex: index,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "$local_catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
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

              //itemCount: combineAll[widget.index]["${widget.index+1}"] == null ? 0 :combineAll[widget.index]["${widget.index+1}"].length,
              itemCount: newList == null ? 0 : newList.length,
              itemBuilder: (BuildContext context, int index) {
                //if (combineAll[widget.index]["${widget.index+1}"][index]['category'] == local_catie) {
                  Map food = newList[index];
                    return GridProduct(
                      img: food['img'],
                      isFav: false,
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
}

