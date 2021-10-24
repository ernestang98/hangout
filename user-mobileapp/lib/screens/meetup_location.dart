import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/widgets/button_widget.dart';
import 'package:restaurant_ui_kit/widgets/top_container.dart';
import 'package:restaurant_ui_kit/widgets/back_button.dart';
import 'package:restaurant_ui_kit/widgets/my_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

class CreateNewMeetupLocationsPage extends StatefulWidget {
  @override
  CreateNewMeetupLocationsPageState createState() =>
      CreateNewMeetupLocationsPageState();
}

class CreateNewMeetupLocationsPageState
    extends State<CreateNewMeetupLocationsPage> {
  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/skyline.jpg"),
                      fit: BoxFit.cover),
                  /* color: Colors.amber,
                  border: Border.all(
                    color: Colors.amber,
                  ), */
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 5) / 100,
              child: Center(
                child: Text(
                  "Select Location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: _buildList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Aljunied-Hougang'),
          subtitle: Text("Northeast"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/aljunied_hougang.jpg")),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.amber,
          ),
          onTap: () {
            Navigator.pop(context, 'Aljunied-Hougang');
          },
        ),
        ListTile(
          title: Text('Ang Mo Kio'),
          subtitle: Text("Central"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/angmokio.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Ang Mo Kio');
          },
        ),
        ListTile(
          title: Text('Bishan-Toa Payoh'),
          subtitle: Text("Central"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/bishan_toapayoh.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Bishan-Toa Payoh');
          },
        ),
        ListTile(
          title: Text('Chua Chu Kang'),
          subtitle: Text("North"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/chuachukang.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Chua Chu Kang');
          },
        ),
        ListTile(
          title: Text('East Coast'),
          subtitle: Text("East"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/eastcoast.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'East Coast');
          },
        ),
        ListTile(
          title: Text('Holland–Bukit Panjang'),
          subtitle: Text("West"),
          leading: CircleAvatar(
              backgroundImage:
                  ExactAssetImage("assets/holland-bukitpanjang.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Holland–Bukit Panjang');
          },
        ),
        ListTile(
          title: Text('Jalan Besar'),
          subtitle: Text("Central"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/jalanbesar.png")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Jalan Besar');
          },
        ),
        ListTile(
          title: Text('Jurong–Clementi'),
          subtitle: Text("West"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/jurong-clementi.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Jurong–Clementi');
          },
        ),
        ListTile(
          title: Text('Marine Parade'),
          subtitle: Text("East"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/marineparade.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Marine Parade');
          },
        ),
        ListTile(
          title: Text('Marsiling–Yew Tee'),
          subtitle: Text("North"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/yewtee.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Marsiling–Yew Tee');
          },
        ),
        ListTile(
          title: Text('Nee Soon'),
          subtitle: Text("North"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/neesoon.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Nee Soon');
          },
        ),
        ListTile(
          title: Text('Pasir Ris–Punggol'),
          subtitle: Text("East"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/pasirris-punggol.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Pasir Ris–Punggol');
          },
        ),
        ListTile(
          title: Text('Sembawang'),
          subtitle: Text("North"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/sembawang.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Sembawang');
          },
        ),
        ListTile(
          title: Text('Sengkang'),
          subtitle: Text("Northeast"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/sengkang.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Sengkang');
          },
        ),
        ListTile(
          title: Text('Tampines'),
          subtitle: Text("East"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/tampines.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Tampines');
          },
        ),
        ListTile(
          title: Text('Tanjong Pagar'),
          subtitle: Text("Central"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/tanjongpagar.jpg")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'Tanjong Pagar');
          },
        ),
        ListTile(
          title: Text('West Coast'),
          subtitle: Text("West"),
          leading: CircleAvatar(
              backgroundImage: ExactAssetImage("assets/westcoast.png")),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
          onTap: () {
            Navigator.pop(context, 'West Coast');
          },
        ),
      ],
    );
  }
}
