import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/widgets/Poi.dart';
import 'package:smart_admin_dashboard/widgets/Theme.dart' as Theme;
import 'package:smart_admin_dashboard/widgets/edit_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase/firebase.dart' as fb;
import 'dart:html' as html;

class DisplayCard extends StatelessWidget {
  final Poi poi;
  final Poi? poi2;
  DisplayCard(this.poi, this.poi2);
  @override
  Widget build(BuildContext context) {
    return new Row(children: [
      new Container(
        height: 150.0,
        width: 500,
        margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20),
        child: new Stack(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 100.0, right: 24.0),
                decoration: new BoxDecoration(
                  color: Theme.Colors.planetCard,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0))
                  ],
                ),
                child: new Container(
                  margin: const EdgeInsets.only(top: 16.0, left: 72.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(poi.name.replaceAll("_", " ")),
                        Text(poi.category,
                            style: Theme.TextStyles.planetLocation),
                        Container(
                            color: const Color(0xFF00C6FF),
                            width: 24.0,
                            height: 1.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0)),
                        new Row(
                          children: <Widget>[
                            new Icon(Icons.location_on,
                                size: 14.0, color: Theme.Colors.planetDistance),
                            new Text(poi.location,
                                style: Theme.TextStyles.planetDistance),
                            new Container(width: 24.0),
                          ],
                        )
                      ]),
                )),
            Container(
                alignment: new FractionalOffset(0.0, 0.5),
                margin: const EdgeInsets.only(left: 20.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(poi.displayImage,
                            height: 120.0, width: 120.0, fit: BoxFit.cover)
                        // Image.asset(
                        //   poi.displayImage,
                        //   height: 120.0,
                        //   width: 120.0,
                        //   fit: BoxFit.cover,
                        // ),
                        ))),
            Positioned(
              top: 10,
              right: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new FormMaterial(
                            type: poi.type,
                            id: poi.id,
                            name: poi.name.replaceAll("_", " "),
                            des: poi.description,
                            loc: poi.location,
                            cat: poi.category,
                            trending: poi.trending,
                            image: poi.displayImage);
                      },
                      fullscreenDialog: true));
                },
                icon: Icon(Icons.edit_outlined),
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: IconButton(
                onPressed: () {
                  showAlertDialog(
                      context, poi.id, poi.name.replaceAll("_", " "), poi.type);
                },
                icon: Icon(Icons.delete_outline),
              ),
            )
          ],
        ),
      ),
      poi2 == null
          ? new Container()
          : new Container(
              height: 150.0,
              width: 500,
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20),
              child: new Stack(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 100.0, right: 24.0),
                      decoration: new BoxDecoration(
                        color: Theme.Colors.planetCard,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0,
                              offset: new Offset(0.0, 10.0))
                        ],
                      ),
                      child: new Container(
                        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(poi2!.name.replaceAll("_", " ")),
                              Text(poi2!.category,
                                  style: Theme.TextStyles.planetLocation),
                              Container(
                                  color: const Color(0xFF00C6FF),
                                  width: 24.0,
                                  height: 1.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0)),
                              new Row(
                                children: <Widget>[
                                  new Icon(Icons.location_on,
                                      size: 14.0,
                                      color: Theme.Colors.planetDistance),
                                  new Text(poi2!.location,
                                      style: Theme.TextStyles.planetDistance),
                                  new Container(width: 24.0),
                                ],
                              )
                            ]),
                      )),
                  Container(
                      alignment: new FractionalOffset(0.0, 0.5),
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: Image.network(poi2!.displayImage,
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover)
                              // child: Image.asset(
                              //   poi2!.displayImage,
                              //   height: 120.0,
                              //   width: 120.0,
                              //   fit: BoxFit.cover,
                              // ),
                              ))),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new FormMaterial(
                                  type: poi2!.type,
                                  id: poi2!.id,
                                  name: poi2!.name.replaceAll("_", " "),
                                  des: poi2!.description,
                                  loc: poi2!.location,
                                  cat: poi2!.category,
                                  trending: poi2!.trending,
                                  image: poi2!.displayImage);
                            },
                            fullscreenDialog: true));
                      },
                      icon: Icon(Icons.edit_outlined),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 30,
                    child: IconButton(
                      onPressed: () {
                        showAlertDialog(context, poi2!.id,
                            poi2!.name.replaceAll("_", " "), poi2!.type);
                      },
                      icon: Icon(Icons.delete_outline),
                    ),
                  )
                ],
              ),
            )
    ]);
  }
}

showAlertDialog(BuildContext context, String key, String name, String type) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () async {
      String activity = "";
      switch (type) {
        case "poi":
          activity = "places_of_interests";
          break;
        case "food":
          activity = "food_options";
          break;
        case "events":
        default:
          activity = "events";
          break;
      }
      SharedPreferences sharedpref = await SharedPreferences.getInstance();
      String? region = sharedpref.getString("region");
      fb.DatabaseReference databaseRef =
          fb.database().ref(region!).child(activity);
      await databaseRef.child(name.replaceAll(" ", "_")).remove();
      Navigator.of(context).pop();
      html.window.location.reload();
    },
  );
  Widget notOkButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm Delete"),
    content: Text("Do you want to delete: $name?"),
    actions: [notOkButton, okButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
