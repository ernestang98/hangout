import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_ui_kit/models/event_model.dart' as Meetup;
import 'package:restaurant_ui_kit/Services/AuthenticationService.dart';

class DatabaseManager{

  final DatabaseReference rootRef = FirebaseDatabase.instance.reference();

  Future getUsername() async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).once().then((DataSnapshot snapshot) {
      final String username = snapshot.value['Name'].toString();
      print(username);
      return username;
    });
  }

  Future getEmail() async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).once().then((DataSnapshot snapshot) {
      final String email = snapshot.value['Email'].toString();
      print(email);
      return email;
    });
  }

  Future getBio() async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).once().then((DataSnapshot snapshot) {
      final String bio = snapshot.value['Bio'].toString();
      print(bio);
      return bio;
    });
  }

  Future getLocation() async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).once().then((DataSnapshot snapshot) {
      final String location = snapshot.value['Location'].toString();
      print(location);
      return location;
    });
  }

  Future getPhone() async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).once().then((DataSnapshot snapshot) {
      final String phone = snapshot.value['Phone'].toString();
      print(phone);
      return phone;
    });
  }

  Future getOrganiser(String key, String location) async {
    return rootRef.child(location).child("Meetup").child(key).once().then((DataSnapshot snapshot) {
      final String organiser = snapshot.value['Created'].toString();
      print(organiser);
      return organiser;
    });
  }

  Future getJoined(String key, String location) async {
    return rootRef.child(location).child("Meetup").child(key).once().then((DataSnapshot snapshot) {
      final String joined = snapshot.value['Joined'].toString();
      print(joined);
      return joined;
    });
  }

  Future getCreatedMeetups(String location) async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).child('Created Meetups').child(location).once().then((DataSnapshot snapshot) {
      final List createdMeetups = [];
      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          createdMeetups.add(key);
        });
      }
      return createdMeetups;
    });
  }

  Future getJoinedMeetups(String location) async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).child('Joined Meetups').child(location).once().then((DataSnapshot snapshot) {
      final List joinedMeetups = [];
      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          joinedMeetups.add(key);
        });
      }
      return joinedMeetups;
    });
  }

  Future getFood(String location) async {

    List<Map> foods = [];
    return rootRef.child(location).child('food_options').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        foods.add({
          "name": key,
          "location": location,
          "category": values["category"],
          "img": values["imageurl"],
          "trending": values["trending"],
          "isFav": false,
          "description": values["description"]
        });
      });
      //print(foods);
      return foods;

    });
  }



  Future getPlacesOfInterest(String location) async {

    List<Map> placesofinterest_list = [];
    return rootRef.child(location).child('places_of_interests').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        placesofinterest_list.add({
          "img": values["imageurl"],
          "location": location,
          "category": values["category"],
          "trending": values["trending"],
          "description": values["description"],
          "isFav": false,
          "name": key
        });
      });
      //print(placesofinterest_list);
      return placesofinterest_list;

    });
  }

  Future getEvents(String location) async {

    List<Map> events_list = [];
    return rootRef.child(location).child('events').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        events_list.add({
          "img": values["imageurl"],
          "category": values["category"],
          "location": location,
          "trending": values["trending"],
          "description": values["description"],
          "isFav": false,
          "name": key
        });
      });
      //print(events_list);
      return events_list;

    });
  }


  // Update User data with username and email
  Future updateUserData(String uid, String username, String email) {

    DatabaseReference uidRef = rootRef.child("Users").child(uid);

    uidRef.set({
      "Name": username,
      "Email": email,
      "Bio": "",
      "Location": "",
      "Phone": "",
      "Favourited": "",
      "Created Meetups": "",
      "Joined Meetups": "",
    });
  }

  // update user Profile
  Future updateUserProfile(String uid, String username, String email, String bio, String location, String phone) {

    DatabaseReference uidRef = rootRef.child("Users").child(uid);

    uidRef.update({
      "Name": username,
      "Email": email,
      "Bio": bio,
      "Location": location,
      "Phone": phone
    });
  }

  Future getMyMeetups(String location) async {
    List createdMeetups;
    dynamic resultant = await getCreatedMeetups(location);
    if (resultant == null){
      print("Unable to retrieve createdList");
    } else {
      createdMeetups = resultant;
    }

    List<Meetup.Event> meetups = [];
    return rootRef.child(location).child('Meetup').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        for(int i=0; i < createdMeetups.length; i++){
          if(createdMeetups[i] == key){
            meetups.add(Meetup.Event(//eventDate: values["Date"],
                keyID : key,
                joined: values["Joined"],
                location: values["Location"],
                name: values["Title"],
                organizer: values["Created"],
                price: 30,
                category: values["Category"],
                date: values["Date"],
                month: values["Month"],
                day: values["Day"],
                week: values["Week"],
                description: values["Description"]));
          }
        }
      });
      return meetups;
    });
  }

  Future getUpcomingMeetups(String location) async {
    List createdMeetups;
    dynamic resultant = await getCreatedMeetups(location);
    if (resultant == null){
      print("Unable to retrieve created meetups");
    } else {
      createdMeetups = resultant;
    }
    print(createdMeetups);

    List joinedMeetups;
    dynamic resultant2 = await getJoinedMeetups(location);
    if (resultant2 == null){
      print("Unable to retrieve joined meetups");
    } else {
      joinedMeetups = resultant2;
    }
    print(joinedMeetups);

    List upcomingMeetups = createdMeetups + joinedMeetups;
    List<Meetup.Event> meetups = [];
    return rootRef.child(location).child('Meetup').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        for(int i=0; i < upcomingMeetups.length; i++) {
          if (upcomingMeetups[i] == key) {
            meetups.add(Meetup.Event(//eventDate: values["Date"],
                keyID : key,
                joined: values["Joined"],
                location: values["Location"],
                name: values["Title"],
                organizer: values["Created"],
                price: 30,
                category: values["Category"],
                date: values["Date"],
                month: values["Month"],
                day: values["Day"],
                week: values["Week"],
                description: values["Description"]));
          }
        }
      });
      return meetups;
    });
  }

  Future getNearbyMeetups(String location) async {

    List<Meetup.Event> meetups = [];
    return rootRef.child(location).child('Meetup').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        meetups.add(Meetup.Event(//eventDate: values["Date"],
            keyID : key,
            joined: values["Joined"],
            location: values["Location"],
            name: values["Title"],
            organizer: values["Created"],
            price: 30,
            category: values["Category"],
            date: values["Date"],
            month: values["Month"],
            day: values["Day"],
            week: values["Week"],
            description: values["Description"]));
      });
      return meetups;
    });
  }

  // create meetup
  Future createMeetup(String date, String startTime, String endTime, String title, String description, String location, String category, String day, String month, String week) async {

    String username;
    dynamic resultant = await getUsername();
    if (resultant == null){
      print("Unable to retrieve username");
    } else {
        username = resultant;
    }

    String uniqueKey = rootRef.child(location)
        .child("Meetup")
        .push()
        .key;
    DatabaseReference uniqueKeyRef = rootRef.child(location).child("Meetup").child(uniqueKey);

    uniqueKeyRef.set({
      "Title": title,
      "Date": date,
      "Day": day,
      "Month": month,
      "Week": week,
      "Start Time": startTime,
      "End Time": endTime,
      "Description": description,
      "Location": location,
      "Created": username,
      "Joined": "",
      "Category": category
    });

    String uid = AuthenticationService().getCurrentUser();
    DatabaseReference uidRef = rootRef.child("Users").child(uid).child("Created Meetups").child(location);

    uidRef.update({
      uniqueKey: "value"
    });

  }

  Future joinMeetup(String key, String location) async {

    String uid = AuthenticationService().getCurrentUser();
    String username;
    String joinedString;
    dynamic resultant = await getUsername();
    if (resultant == null){
      print("Unable to retrieve username");
    } else {
      username = resultant;
    }

    dynamic resultant2 = await getJoined(key, location);
    if (resultant2 == null){
      print("Unable to retrieve joined");
    } else {
      joinedString = resultant2;
    }
    if (joinedString == "null"){
      joinedString = username;
    }
    else{
      joinedString += username;
      joinedString += ",";
    }

    DatabaseReference uniqueKeyRef = rootRef.child(location).child("Meetup").child(key);

    uniqueKeyRef.update({
      "Joined": joinedString
    });

    DatabaseReference uidRef = rootRef.child("Users").child(uid).child("Joined Meetups").child(location);

    uidRef.update({
      key: "value"
    });

  }

  Future addFavourites (String name, String location){

    String uid = AuthenticationService().getCurrentUser();

    DatabaseReference uidRef = rootRef.child("Users").child(uid).child("Favourited").child(location);

    uidRef.update({
      name: "value"
    });
  }

  Future getFavouritedList(String location) async {
    String uid = AuthenticationService().getCurrentUser();

    return rootRef.child('Users').child(uid).child('Favourited').child(location).once().then((DataSnapshot snapshot) {
      final List favourited = [];
      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          favourited.add(key);
        });
      }

      return favourited;
    });
  }

  Future getFavouritedFood(String location) async {
    List favouritedList;
    dynamic resultant = await getFavouritedList(location);
    if (resultant == null){
      print("Unable to retrieve Favourited List");
    } else {
      favouritedList = resultant;
    }

    List<Map> favFoods = [];
    return rootRef.child(location).child('food_options').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        for(int i=0; i < favouritedList.length; i++) {
          if (favouritedList[i] == key) {
            favFoods.add({
              "name": key,
              "location": location,
              "category": values["category"],
              "img": values["imageurl"],
              "trending": values["trending"],
              "description": values["description"]
            });
          }
        }
      });
      // print(favFoods);
      return favFoods;

    });
  }

}