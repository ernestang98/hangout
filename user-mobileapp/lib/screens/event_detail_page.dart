import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/constant/text_style.dart';
import 'package:restaurant_ui_kit/models/event_model.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';
import 'package:restaurant_ui_kit/screens/join_meetup.dart';
import 'package:restaurant_ui_kit/widgets/ui_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  EventDetailPage(this.event);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage>
    with TickerProviderStateMixin {
  String username;
  String organiser;
  Event event;
  AnimationController controller;
  AnimationController bodyScrollAnimationController;
  ScrollController scrollController;
  Animation<double> scale;
  Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;
  @override
  void initState() {
    event = widget.event;
    getUsername();
    getOrganiser();
    event.splitJoin();
    // print("participants names");
    // print(event.participants);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    bodyScrollAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.forward();
        } else {
          if (bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.reverse();
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildEventTitle(),
                          UIHelper.verticalSpace(16),
                          buildEventDate(),
                          UIHelper.verticalSpace(24),
                          buildAboutEvent(),
                          UIHelper.verticalSpace(24),
                          buildOrganizeInfo(),
                          UIHelper.verticalSpace(24),
                          buildParticipateInfo(),
                          /*buildEventLocation(),*/
                          UIHelper.verticalSpace(124),
                          //...List.generate(10, (index) => ListTile(title: Text("Dummy content"))).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*Align(
                child: buildPriceInfo(),
                alignment: Alignment.bottomCenter,
              ),*/
              /*AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      child: buildHeaderButton(hasTitle: true),
                    ),
                  );
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage() {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: 'https://source.unsplash.com/600x800/?${event.category}',
              //event.image,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.network(
                  'https://source.unsplash.com/600x800/?${event.category}',
                  //event.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildHeaderButton(),
        ],
      ),
    );
  }

  Widget buildHeaderButton({bool hasTitle = false}) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  if (bodyScrollAnimationController.isCompleted)
                    bodyScrollAnimationController.reverse();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: hasTitle ? Colors.white : Colors.black,
                  ),
                ),
              ),
              color: hasTitle ? Theme.of(context).primaryColor : Colors.white,
            ),
            if (hasTitle)
              Text(event.name, style: titleStyle.copyWith(color: Colors.white)),
            Card(
              shape: CircleBorder(),
              elevation: 0,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventTitle() {
    return Container(
      child: Text(
        event.name,
        style: headerStyle.copyWith(fontSize: 32),
      ),
    );
  }

  Widget buildEventDate() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${event.month}", style: monthStyle),
                Text("${event.day}", style: titleStyle),
                // Text("${DateTimeUtils.getMonth(event.eventDate)}",
                //     style: monthStyle),
                // Text("${DateTimeUtils.getDayOfMonth(event.eventDate)}",
                //     style: titleStyle),
              ],
            ),
          ),
          UIHelper.horizontalSpace(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.week, style: titleStyle),
              // Text(DateTimeUtils.getDayOfWeek(event.eventDate),
              //     style: titleStyle),
              UIHelper.verticalSpace(4),
              Text("10:00 - 12:00 PM", style: subtitleStyle),
            ],
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            decoration:
                ShapeDecoration(shape: StadiumBorder(), color: primaryLight),
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text("Join",
                      /*style: TextStyle(color: Theme.of(context).primaryColor)*/
                      style: orangeStyle),
                  onPressed: () {
                    if (organiser != username) {
                      joinMeetup();
                      Fluttertoast.showToast(
                          msg: "You have joined the meetup successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Unable to join your own created meetup!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  shape: StadiumBorder(),
                  color: primaryLight,
                )
                /*UIHelper.horizontalSpace(8),
                Text("Join", style: subtitleStyle),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("About", style: headerStyle),
        UIHelper.verticalSpace(),
        Text(event.description, style: subtitleStyle),
        UIHelper.verticalSpace(8),
        InkWell(
          child: Text(
            "Read more...",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  /*Widget buildOrganizeInfo() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          child: Text(event.organizer[0]),
        ),
        UIHelper.horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.organizer, style: titleStyle),
            UIHelper.verticalSpace(4),
            Text("Organizer", style: subtitleStyle),
          ],
        ),
        Spacer(),
        /*FlatButton(
          child: Text("Follow",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {},
          shape: StadiumBorder(),
          color: primaryLight,
        )*/
      ],
    );
  }*/

  Widget buildOrganizeInfo() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          child: Text(event.organizer[0]),
        ),
        UIHelper.horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.organizer, style: titleStyle),
            UIHelper.verticalSpace(4),
            Text("Organizer", style: subtitleStyle),
          ],
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.all(2),
          /* decoration:
                ShapeDecoration(shape: StadiumBorder(), color: primaryLight), */
          child: Row(
            children: <Widget>[
              // JoinMeetupBtn(),

              /* FlatButton(
                  child: Text("Join",
                      /*style: TextStyle(color: Theme.of(context).primaryColor)*/
                      style: orangeStyle),
                  onPressed: () {},
                  shape: StadiumBorder(),
                  color: primaryLight,
                ) */
              /*UIHelper.horizontalSpace(8),
                Text("Join", style: subtitleStyle),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),*/
            ],
          ),

          /*FlatButton(
          child: Text("Follow",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {},
          shape: StadiumBorder(),
          color: primaryLight,
        )*/
        )
      ],
    );
  }

  Widget buildParticipateInfo() {
    return Container(
      padding: EdgeInsets.all(0),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: event.participants.length,
        itemBuilder: (context, int index) {
          return ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(event.participants[index]),
              subtitle: Text("Participant"),
              leading: CircleAvatar(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child:
                      Text(event.participants[index][0], style: avatarStyle)));
        },
      ),
    );
  }

  /*Widget buildEventLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/map.jpg',
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
      ),
    );
  }*/

  /*Widget buildPriceInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Price", style: subtitleStyle),
              UIHelper.verticalSpace(8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "\$${event.price}",
                        style: titleStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    TextSpan(
                        text: "/per person",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          RaisedButton(
            onPressed: () {},
            shape: StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Theme.of(context).primaryColor,
            child: Text(
              "Get a Ticket",
              style: titleStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }*/
  void joinMeetup() async {
    DatabaseManager().joinMeetup(event.keyID, event.location);
    print(event.joined);
  }

  getOrganiser() async {
    dynamic resultant =
        await DatabaseManager().getOrganiser(event.keyID, event.location);

    if (resultant == null) {
      print("Unable to retrieve organiser");
    } else {
      setState(() {
        organiser = resultant;
      });
    }
  }

  getUsername() async {
    dynamic resultant = await DatabaseManager().getUsername();

    if (resultant == null) {
      print("Unable to retrieve username");
    } else {
      setState(() {
        username = resultant;
      });
    }
  }
}
