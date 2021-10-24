import 'package:smart_admin_dashboard/widgets/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding * 3,
                ),
                Image.asset(
                  "assets/images/hangout.png",
                  scale: 5,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text("Hangout Administration Interface")
              ],
            ),
          ),
          Divider(color: Colors.white),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          DrawerListTile(
            title: "Places of Interests",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.of(context).pushReplacementNamed('/placesofinterests');
            },
          ),
          DrawerListTile(
            title: "Food Options",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.of(context).pushReplacementNamed('/foodoptions');
            },
          ),
          DrawerListTile(
            title: "Events",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.of(context).pushReplacementNamed('/events');
            },
          ),
          DrawerListTile(
              title: "Logout",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {
                SharedPreferences.getInstance().then((sharedpref) => {
                      sharedpref.setBool("isLoggedIn", false).then((data) =>
                          sharedpref.setString("region", "").then((data) => {
                                sharedpref.setString("username", "").then(
                                    (data) => {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/login')
                                        })
                              }))
                    });
              }),
        ]),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

// SVG Icons: https://www.flaticon.com/search?word=logout&type=icon