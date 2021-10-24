import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: black,
          ),
        ),
      ),
    );
  }
}
