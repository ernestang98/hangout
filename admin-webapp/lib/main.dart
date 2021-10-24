import 'package:smart_admin_dashboard/widgets/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin_dashboard/screens/page_authentication/page_authentication.dart';
import 'package:smart_admin_dashboard/screens/page_events/page_events.dart';
import 'package:smart_admin_dashboard/screens/page_events/page_events_add.dart';
import 'package:smart_admin_dashboard/screens/page_places_of_interests/page_places_of_interests.dart';
import 'package:smart_admin_dashboard/screens/page_places_of_interests/page_places_of_interests_add.dart';
import 'package:smart_admin_dashboard/screens/page_food_options/page_food_options.dart';
import 'package:smart_admin_dashboard/screens/page_food_options/page_food_options_add.dart';
import 'package:smart_admin_dashboard/screens/page_dashboard/page_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await _createLoginManager();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangout Admins',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
        scaffoldBackgroundColor: bgColor,
        primaryColor: greenColor,
        dialogBackgroundColor: secondaryColor,
        buttonColor: greenColor,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => PageDashboard(),
        '/login': (BuildContext context) => PageAuthentication(),
        // '/test': (BuildContext context) => HomeScreen(),
        '/home': (BuildContext context) => PageDashboard(),
        '/placesofinterests': (BuildContext context) => PagePlacesOfInterests(),
        '/placesofinterests/add': (BuildContext context) =>
            PagePlacesOfInterestsAdd(),
        '/events': (BuildContext context) => PageEvents(),
        '/events/add': (BuildContext context) => PageEventsAdd(),
        '/foodoptions': (BuildContext context) => PageFoodOptions(),
        '/foodoptions/add': (BuildContext context) => PageFoodOptionsAdd(),
      },
    );
  }
}
