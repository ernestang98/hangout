import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinMeetupBtn extends StatefulWidget {
  JoinMeetupBtn({Key key}) : super(key: key);

  @override
  JoinMeetupBtnState createState() => JoinMeetupBtnState();
}

class JoinMeetupBtnState extends State<JoinMeetupBtn> {
  bool isJoin = false;
  static String buttonText = "Join";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                isJoin = !isJoin;
                if (isJoin == true) {
                  print("true 1: " + buttonText);
                  buttonText = "Joined";
                  print("true 2: " + buttonText);
                } else {
                  print("false 1: " + buttonText);
                  buttonText = "Join";
                  print("false 2: " + buttonText);
                }
              });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.amber[100]))),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber[100])),

            /* style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber)), */
            child: Text(buttonText, style: TextStyle(color: Colors.black))));
  }

/*   static String getButtonText() {
    if (buttonText == null) {
      setState() {
                buttonText = "Join";
              };

      return buttonText;
    }
    return "Joined";
  } */
}
