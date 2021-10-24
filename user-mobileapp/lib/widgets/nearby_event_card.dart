import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/constant/text_style.dart';
import 'package:restaurant_ui_kit/models/event_model.dart';
import 'package:restaurant_ui_kit/util/datetime_utils.dart';
import 'package:restaurant_ui_kit/widgets/ui_helper.dart';

class NearbyEventCard extends StatelessWidget {
  final Event event;
  final Function onTap;
  NearbyEventCard(this.event, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            buildImage(),
            buildEventInfo(context),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: imgBG,
        width: 80,
        height: 100,
        child: Hero(
          tag: 'https://source.unsplash.com/600x800/?${event.category}',
          //event.image,
          child: Image.network(
            'https://source.unsplash.com/600x800/?${event.category}',
            //event.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildEventInfo(context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(event.date),
          //Text(DateTimeUtils.getFullDate(event.eventDate), style: monthStyle),
          UIHelper.verticalSpace(8),
          Text(event.name, style: titleStyle),
          UIHelper.verticalSpace(8),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, size: 16, color: orange),
              UIHelper.horizontalSpace(4),
              Text(event.location.toUpperCase(), style: subtitleStyle),
            ],
          ),
        ],
      ),
    );
  }
}
