import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/widgets/side_menu.dart';
import 'package:smart_admin_dashboard/widgets/card.dart';
import 'package:smart_admin_dashboard/widgets/Poi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pagination/pagination.dart';
import 'package:smart_admin_dashboard/widgets/loginmanager.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/page_authentication/progress_dialog.dart';

class PagePlacesOfInterests extends StatefulWidget {
  const PagePlacesOfInterests({Key? key}) : super(key: key);
  @override
  _PagePlacesOfInterests createState() => _PagePlacesOfInterests();
}

class _PagePlacesOfInterests extends State<PagePlacesOfInterests> {
  Widget base = Container();
  List<DisplayCard> theData = [];

  @override
  void initState() {
    super.initState();
    redirect(context, '/home').then((value) => {
          if (value == "auth")
            {
              asd().then((data) => {forceRebuild()})
            }
          else
            {
              setState(() {
                base = Container();
              })
            },
        });
  }

  @override
  void dispose() {
    setState(() {
      base = Container();
    });
    super.dispose();
  }

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text(
    'Places of Interests',
    style: TextStyle(
      color: Colors.white,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: base);
  }

  void forceRebuild() {
    setState(() {
      base = Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          // automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (customIcon.icon == Icons.search) {
                        customIcon = const Icon(Icons.cancel);
                        customSearchBar = const ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                          title: TextField(
                            decoration: InputDecoration(
                              hintText: 'search...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        customIcon = const Icon(Icons.search);
                        customSearchBar = const Text(
                          'Places of Interests',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }
                      forceRebuild();
                    });
                  },
                  child: Icon(
                    customIcon.icon,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/placesofinterests/add');
                  },
                  child: Icon(
                    Icons.add,
                    size: 26.0,
                  ),
                ))
          ],
        ),
        drawer: Drawer(child: SideMenu()),
        body: PaginationList<DisplayCard>(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            left: 200,
            right: 200,
          ),
          separatorWidget: Container(
            height: 0.5,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, DisplayCard card) {
            return card;
          },
          pageFetch: pageFetch,
          onError: (dynamic error) => Center(
            child: Text('Something Went Wrong'),
          ),
          initialData: this.theData,
          onEmpty: Center(
            child: Text('Empty List'),
          ),
        ),
      );
    });
  }

  void filter(String text) {}

  Future<List<DisplayCard>> asd() async {
    String? region = "";
    List<DisplayCard> data = [];
    fb.DatabaseReference databaseRef;
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    region = sharedpref.getString("region");
    databaseRef = fb.database().ref(region!).child("places_of_interests");
    await databaseRef.once('value').then((query) {
      fb.DataSnapshot snapshot = query.snapshot;
      var values = snapshot.val();
      var emptylist = [];
      var keylist = [];
      if (values != null) {
        values.forEach(
            (key, value) => {emptylist.add(values[key]), keylist.add(key)});
      }
      if (emptylist.length == 1) {
        data.add(DisplayCard(
            Poi(
              type: "poi",
              id: keylist[0],
              name: emptylist[0]["name"],
              category: emptylist[0]["category"],
              location: emptylist[0]["location"],
              displayImage: emptylist[0]["imageurl"],
              description: emptylist[0]["description"],
              trending: emptylist[0]["trending"] == "true",
            ),
            null));
      } else {
        print(emptylist);
        for (int i = 0; i < (emptylist.length / 2).ceil(); i++) {
          data.add(
            DisplayCard(
                Poi(
                  type: "poi",
                  id: keylist[i * 2],
                  name: emptylist[i * 2]["name"],
                  category: emptylist[i * 2]["category"],
                  location: emptylist[i * 2]["location"],
                  displayImage: emptylist[i * 2]["imageurl"],
                  description: emptylist[i * 2]["description"],
                  trending: emptylist[i * 2]["trending"] == "true",
                ),
                emptylist.length % 2 == 1 && i * 2 >= emptylist.length - 1
                    ? null
                    : Poi(
                        type: "poi",
                        id: keylist[1 + i * 2],
                        name: emptylist[1 + i * 2]["name"],
                        category: emptylist[1 + i * 2]["category"],
                        location: emptylist[1 + i * 2]["location"],
                        displayImage: emptylist[1 + i * 2]["imageurl"],
                        description: emptylist[1 + i * 2]["description"],
                        trending: emptylist[1 + i * 2]["trending"] == "true",
                      )),
          );
        }
      }
      return data;
    });

    setState(() {
      this.theData = data;
    });

    print(data);
    return data;
  }
}

Future<List<DisplayCard>> pageFetch(int offset) async {
  final List<DisplayCard> upcomingList = List.generate(
    0,
    (int index) => DisplayCard(
        Poi(
          type: "poi",
          id: "",
          name: "City Square Mall",
          category: "Shopping Centre",
          location: "Farrer Park",
          displayImage: "images/mustafa.png",
          description: "",
          trending: false,
        ),
        null),
  );
  await Future<List<DisplayCard>>.delayed(
    Duration(milliseconds: 1500),
  );
  return upcomingList;
}

// https://rrtutors.com/tutorials/infinite-scroll-list-pagination-flutterR