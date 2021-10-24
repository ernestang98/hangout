import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/constant/text_style.dart';
import 'package:restaurant_ui_kit/models/event_model.dart';
import 'package:restaurant_ui_kit/util/datetime_utils.dart';
import 'package:restaurant_ui_kit/widgets/ui_helper.dart';

class MyEventsCard extends StatelessWidget {
  final Event event;
  final Function onTap;
  MyEventsCard(this.event, {this.onTap});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: <Widget>[
          //Expanded(child: buildImage()),
          //UIHelper.verticalSpace(24),
          buildEventInfo(context),
        ],
      ),
    );
  }

  // Widget buildImage() {
  //   return InkWell(
  //     onTap: onTap,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(16),
  //       child: Container(
  //         color: imgBG,
  //         width: double.infinity,
  //         child: Hero(
  //           tag: event.image,
  //           child: Image.network(
  //             event.image,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildEventInfo(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: kLightGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //ToDo change when i am able to get day and month
                Text("Nov"),
                // Text("${DateTimeUtils.getMonth(event.eventDate)}",
                //     style: monthStyle),
                Text("11"),
                // Text("${DateTimeUtils.getDayOfMonth(event.eventDate)}",
                //     style: titleStyle),
              ],
            ),
          ),
          UIHelper.horizontalSpace(16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.name, style: titleStyle),
              UIHelper.verticalSpace(4),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, size: 16, color: kGreen),
                  UIHelper.horizontalSpace(4),
                  Text(event.location.toUpperCase(), style: subtitleStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
