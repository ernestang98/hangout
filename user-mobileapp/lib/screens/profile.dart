// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_ui_kit/providers/app_provider.dart';
import 'package:restaurant_ui_kit/screens/edit_profile.dart';
import 'package:restaurant_ui_kit/screens/splash.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username = "";
  String email = "";
  String location = "";
  String bio = "";
  String phone = "";
  String password = "";

  void initState(){
    super.initState();
    print("reached profile initstate");
    getUsername();
    getEmail();
    getBio();
    getLocation();
    getPhone();
  }

  getUsername() async {
    dynamic resultant = await DatabaseManager().getUsername();

    if (resultant == null){
      print("Unable to retrieve username");
    } else {
      setState(() {
        print("my username");
        username = resultant;
      });
    }
  }

  getEmail() async {
    dynamic resultant = await DatabaseManager().getEmail();

    if (resultant == null){
      print("Unable to retrieve email");
    } else {
      setState(() {
        email = resultant;
      });
    }
  }

  getBio() async {
    dynamic resultant = await DatabaseManager().getBio();

    if (resultant == null){
      print("Unable to retrieve bio");
    } else {
      setState(() {
        bio = resultant;
      });
    }
  }

  getLocation() async {
    dynamic resultant = await DatabaseManager().getLocation();

    if (resultant == null){
      print("Unable to retrieve location");
    } else {
      setState(() {
        location = resultant;
      });
    }
  }

  getPhone() async {
    dynamic resultant = await DatabaseManager().getPhone();

    if (resultant == null){
      print("Unable to retrieve phone");
    } else {
      setState(() {
        phone = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Image.asset(
                    "assets/user.JPG",
                    fit: BoxFit.cover,
                    width: 90.0,
                    height: 90.0,
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return SplashScreen();
                                  },
                                ),
                              );
                            },
                            child: Text("Logout",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  flex: 3,
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20.0,
                  ),
                  onPressed: (){Navigator.push(context, MaterialPageRoute(
                      builder: (_) => EditProfilePage(username: username, emailAddr: email, phone: phone, bio: bio, location: location, password : password,)
                  )
                  );
                  },
                  tooltip: "Edit",
                ),
              ],
            ),

            Divider(),
            Container(height: 15.0),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Account Information".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                username,
              ),
            ),

            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                email,
              ),
            ),

            ListTile(
              title: Text(
                "Phone",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                phone,
              ),
            ),

            ListTile(
              title: Text(
                "Address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                location,
              ),
            ),

            ListTile(
              title: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                bio,
              ),
            ),

            // ListTile(
            //   title: Text(
            //     "Date of Birth",
            //     style: TextStyle(
            //       fontSize: 17,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            //
            //   subtitle: Text(
            //     "April 9, 1995",
            //   ),
            // ),
             MediaQuery.of(context).platformBrightness == Brightness.dark
                 ? SizedBox()
                 : ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing: Switch(
                value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async{
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
                activeColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

