// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/favorite_screen.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/screens/profile.dart';
import 'package:restaurant_ui_kit/screens/search.dart';
import 'package:restaurant_ui_kit/screens/search_location.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/screens/location.dart';
import 'package:restaurant_ui_kit/screens/home_page.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  String titleOfAppBar = "Hang Out";
  String curLocation = "Singapore";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
      appBar: AppBar(
      leadingWidth: 500,
        leading:
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.my_location, color: Colors.red,),
                onPressed: () {
                  _awaitReturnValueFromSecondScreen(context);
                  // ToDo how to create current location

                },
            ),
          Expanded(
            child: Container(
                  child: Text(curLocation,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
              )
            ),
          ],
        ),

        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          // ToDo change Title of hangout to different header names. Favourites, meetup profile etc.
          titleOfAppBar,
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

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            // Home(),
            LocationScreen(city: curLocation,),
            FavoriteScreen(city: curLocation,),
            SearchScreen(),
            MyHomePage(fromMain: false, city: curLocation,),
            Profile(),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width:7),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: (){
                  _pageController.jumpToPage(0);
                  setState(() {
                    titleOfAppBar = "Hangout";
                  });
                },
              ),

              IconButton(
                icon:Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: (){
                  _pageController.jumpToPage(1);

                    titleOfAppBar = "Favourites";

                }
              ),

              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: (){
                  _pageController.jumpToPage(2);
                  setState(() {
                    titleOfAppBar = "Search";
                    //TODO search not appearing 
                  });
                },
                //Search
              ),

              IconButton(
                icon: IconBadge(
                  icon: Icons.accessibility_new,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: (){
                  _pageController.jumpToPage(3);
                  setState(() {
                    titleOfAppBar = "Meet Up";
                  });
                }
                // meet up
              ),

              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: (){
                  _pageController.jumpToPage(4);
                  titleOfAppBar = "Profile";
                }
                //profile
              ),

              SizedBox(width:7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.search,
          ),
          onPressed: ()=>_pageController.jumpToPage(2),
        ),

      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchLocationScreen(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      curLocation = result;
    });
  }
}
