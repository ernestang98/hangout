import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/constant/text_style.dart';
import 'package:restaurant_ui_kit/models/event_model.dart';
import 'package:restaurant_ui_kit/screens/create_new_meetup_page.dart';
import 'package:restaurant_ui_kit/screens/event_detail_page.dart';
import 'package:restaurant_ui_kit/util/app_utils.dart';
import 'package:restaurant_ui_kit/widgets/my_events_card.dart';
//import 'package:restaurant_ui_kit/widgets/bottom_navigation_bar.dart';
//import 'package:restaurant_ui_kit/widgets/home_bg_color.dart';
import 'package:restaurant_ui_kit/widgets/nearby_event_card.dart';
import 'package:restaurant_ui_kit/widgets/ui_helper.dart';
import 'package:restaurant_ui_kit/widgets/upcoming_event_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

class MyHomePage extends StatefulWidget {
  final bool fromMain;
  final String city;
  MyHomePage({
    Key key,
    @required this.fromMain,
    @required this.city,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _fromMain;
  String _city;

  List<Event> nearbyEvents = [];
  List<Event> upcomingEvents = [];
  List<Event> myEvents = [];

  getMyEvents() async {
    dynamic resultant = await DatabaseManager().getMyMeetups(_city);

    if (resultant == null){
      print("Unable to retrieve nearby my meetups");
    } else {
      setState(() {
        myEvents = resultant;
      });
    }
  }

  getUpcomingEvents() async {
    dynamic resultant = await DatabaseManager().getUpcomingMeetups(_city);

    if (resultant == null){
      print("Unable to retrieve upcoming meetups");
    } else {
      setState(() {
        upcomingEvents = resultant;
      });
    }
  }

  getNearbyEvents() async {
    dynamic resultant = await DatabaseManager().getNearbyMeetups(_city);

    if (resultant == null){
      print("Unable to retrieve nearby events");
    } else {
      setState(() {
        nearbyEvents = resultant;
      });
    }
  }

  ScrollController scrollController;
  AnimationController controller;
  AnimationController opacityController;
  Animation<double> opacity;

  void viewEventDetail(Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: EventDetailPage(event),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _city = widget.city;
    print(_city);
    getMyEvents();
    getNearbyEvents();
    getUpcomingEvents();
    _fromMain = widget.fromMain;
    scrollController = ScrollController();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    opacityController =
        AnimationController(vsync: this, duration: Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fromMain == true
          ? AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.amber,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                "Meet Up",
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
                  tooltip: "Notifications",
                ),
              ],
            )
          : null,
      body: Stack(
        children: <Widget>[
          //HomeBackgroundColor(opacity),
          SingleChildScrollView(
            controller: scrollController,
            //padding: EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildSearchAppBar(),
                UIHelper.verticalSpace(1),
                myEvents.length == 0 ? UIHelper.verticalSpace(1) : buildMyMeetupList(),
                UIHelper.verticalSpace(16),
                upcomingEvents.length == 0 ? UIHelper.verticalSpace(1) : buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyEvent(),
              ],
            ),
          ),
        ],
      ),
      /*bottomNavigationBar: HomePageButtonNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewMeetupPage(),
            ),
          );
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }

  Widget buildSearchAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
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
    );
  }

  Widget buildMyMeetupList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("My Meetups", style: headerStyle.copyWith(color: Colors.black)),
          UIHelper.verticalSpace(16),
          Container(
            height: 60,
            child: ListView.builder(
              itemCount: myEvents.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = myEvents[index];
                return MyEventsCard(event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Meetups",
              style: headerStyle.copyWith(color: Colors.black)),
          UIHelper.verticalSpace(16),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: upcomingEvents.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return UpComingEventCard(event,
                    onTap: () => viewEventDetail(event));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyEvent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Nearby Meetups", style: headerStyle),
              //UIHelper.horizontalSpace(16),
            ],
          ),
          UIHelper.verticalSpace(16),
          ListView.builder(
            itemCount: nearbyEvents.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final event = nearbyEvents[index];
              var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval((1 / nearbyEvents.length) * index, 1.0,
                      curve: Curves.decelerate),
                ),
              );
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(animation.value, 0.0),
                  child: NearbyEventCard(
                    event,
                    onTap: () => viewEventDetail(event),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
