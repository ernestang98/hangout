import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/Services/AuthenticationService.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String emailAddr;
  final String location;
  final String bio;
  final String phone;
  final String password;

  EditProfilePage({
    Key key,
    @required this.username,
    @required this.emailAddr,
    @required this.location,
    @required this.bio,
    @required this.phone,
    @required this.password,
  })
      : super(key: key);
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  String username;
  String emailAddr;
  String location;
  String bio;
  String phone;
  String password;
  bool showPassword = false;

  @override
  void initState() {
    username = widget.username;
    emailAddr = widget.emailAddr;
    location = widget.location;
    bio = widget.bio;
    phone = widget.phone;
    password = widget.password;
  }

  final _username = TextEditingController();
  final _emailAddr = TextEditingController();
  final _location = TextEditingController();
  final _bio = TextEditingController();
  final _phone = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),

        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),

        ),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage(
                                // ToDo change to actual profile picture
                                "assets/user.JPG",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "${username}", true, false, false, false, false, false),
              buildTextField("E-mail", "${emailAddr}",  false, true, false, false, false, false),
              buildTextField("Bio", "${bio}", false, false, true, false, false, false),
              buildTextField("Location", "${location}", false, false, false, true, false, false),
              buildTextField("Phone", "${phone}", false, false, false, false, true, false),
              buildTextField("Password", "${password}",  false, false, false, false, false, true),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {Navigator.pop(context);},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      updateUserProfile();
                      Fluttertoast.showToast(
                          msg: "Saved Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    },
                    color: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isUser, bool isEmail, bool isBio, bool isLocation, bool isPhone, bool isPasswordTextField ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: isUser ? _username : isEmail ? _emailAddr: isBio ?  _bio : isLocation ? _location : isPhone ? _phone : null,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText ,
            floatingLabelBehavior: placeholder == "" ? FloatingLabelBehavior.auto : FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  void updateUserProfile() {
    String uid = AuthenticationService().getCurrentUser();
    checkIfEmpty();
    DatabaseManager().updateUserProfile(uid, username, emailAddr, bio , location, phone);
  }

  void checkIfEmpty() {
    if (_username.text != ""){
      username = _username.text;
    }

    if (_emailAddr.text != ""){
      emailAddr = _emailAddr.text;
    }

    if (_bio.text != ""){
      bio = _bio.text;
    }

    if (_location.text != ""){
      location = _location.text;
    }

    if (_phone.text != ""){
      phone = _phone.text;
    }
  }
}