import 'package:smart_admin_dashboard/widgets/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/widgets/input_widget.dart';
import 'package:smart_admin_dashboard/screens/page_authentication/progress_dialog.dart';
import 'package:smart_admin_dashboard/widgets/loginmanager.dart';
import 'package:smart_admin_dashboard/widgets/regions.dart' as regions;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:shared_preferences/shared_preferences.dart';

List<String> region = regions.regionList;

class PageAuthentication extends StatefulWidget {
  @override
  _PageAuthentication createState() => _PageAuthentication();
}

class _PageAuthentication extends State<PageAuthentication>
    with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;

  Widget base = Container();

  bool isChecked = false;

  var dropdownValue;

  void forceRebuild() {
    setState(() {
      base = Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: bgColor,
                  child: Center(
                    child: Card(
                      color: bgColor,
                      child: Container(
                        padding: EdgeInsets.all(42),
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 0,
                            ),
                            Image.asset("assets/images/admin.png", scale: 3),
                            SizedBox(height: 10.0),
                            Flexible(
                              child: Stack(
                                children: [
                                  SlideTransition(
                                    position:
                                        _animationController!.drive(tweenRight),
                                    child: Stack(
                                        fit: StackFit.loose,
                                        clipBehavior: Clip.none,
                                        children: [
                                          _loginScreen(context),
                                        ]),
                                  ),
                                  SlideTransition(
                                    position:
                                        _animationController!.drive(tweenLeft),
                                    child: Stack(
                                        fit: StackFit.loose,
                                        clipBehavior: Clip.none,
                                        children: [
                                          _registerScreen(context),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    dropdownValue = region[0];
    Future(() {
      redirect(context, '/login').then((value) => {
            if (value != "auth")
              {forceRebuild()}
            else
              {
                Navigator.of(context).pushReplacementNamed('/home')
                // setState(() {
                //   base = Container();
                // })
              }
          });
    });

    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: base);
  }

  Container _registerScreen(BuildContext context) {
    GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: Form(
          autovalidate: true, //check for validation while typing
          key: formkey2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Region"),
                    SizedBox(height: 4.0),
                    Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        height: 50,
                        width: 800,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Container(
                              padding: EdgeInsets.only(left: 525),
                              child: Icon(Icons.arrow_downward)),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              forceRebuild();
                            });
                          },
                          items: region
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ))
                  ],
                ),
                SizedBox(height: 8.0),
                InputWidget(
                  kController: regNameController,
                  onSaved: (String? value) {},
                  onChanged: (String? value) {},
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  topLabel: "Full Name",
                  hintText: "e.g. John Lim",
                ),
                SizedBox(height: 8.0),
                InputWidget(
                  kController: regEmailController,
                  onSaved: (String? value) {},
                  onChanged: (String? value) {},
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ]),
                  topLabel: "Email",
                  hintText: "Enter E-mail",
                ),
                SizedBox(height: 8.0),
                InputWidget(
                  obscureText: true,
                  kController: regPasswordController,
                  onSaved: (String? value) {},
                  onChanged: (String? value) {},
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  topLabel: "Password",
                  hintText: "Enter Password",
                ),
                SizedBox(height: 24.0),
                AppButton(
                  type: ButtonType.PRIMARY,
                  text: "Sign Up",
                  onPressed: () {
                    if (formkey2.currentState!.validate()) {
                      registerUser(context);
                    } else {
                      print("Not Validated");
                    }
                  },
                ),
                SizedBox(height: 24.0),
                Center(
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          if (_isMoved) {
                            _animationController!.reverse();
                          } else {
                            _animationController!.forward();
                          }
                          _isMoved = !_isMoved;
                        },
                        child: Text("Alright, let's sign in!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: greenColor)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Container _loginScreen(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: Form(
        autovalidate: true, //check for validation while typing
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Region"),
                SizedBox(height: 4.0),
                Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    height: 50,
                    width: 800,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Container(
                          padding: EdgeInsets.only(left: 525),
                          child: Icon(Icons.arrow_downward)),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          forceRebuild();
                        });
                      },
                      items:
                          region.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value), key: Key(value));
                      }).toList(),
                    ))
              ],
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            InputWidget(
              kKey: Key("loginEmail"),
              kController: loginEmailController,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {},
              onChanged: (String? value) {},
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
                EmailValidator(errorText: "Enter valid email id"),
              ]),
              topLabel: "Email",
              hintText: "Enter E-mail",
            ),
            SizedBox(height: 8.0),
            InputWidget(
              kKey: Key("loginPassword"),
              kController: loginPasswordController,
              topLabel: "Password",
              obscureText: true,
              hintText: "Enter Password",
              onSaved: (String? uPassword) {},
              onChanged: (String? value) {},
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
              ]),
            ),
            SizedBox(height: 24.0),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Sign In",
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  loginAndAuthenticateUser(context);
                } else {
                  print("Not Validated");
                }
              },
            ),
            SizedBox(height: 24.0),
            Center(
              child: Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_isMoved) {
                        _animationController!.reverse();
                      } else {
                        _animationController!.forward();
                      }
                      _isMoved = !_isMoved;
                    },
                    child: Text("Alright, let's sign up!",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400, color: greenColor)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Authenticating, Please wait...");
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: loginEmailController.text,
                password: loginPasswordController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      Navigator.pop(context);
      try {
        // fb.DatabaseReference databaseRef =
        //     fb.database().ref(this.dropdownValue! + "-admins");

        fb.DatabaseReference databaseRef =
            fb.database().ref(this.dropdownValue).child("admins");

        databaseRef.once('value').then((query) {
          fb.DataSnapshot snapshot = query.snapshot;
          var values = snapshot.val();
          var emptylist = [];
          values.forEach((key, value) => {emptylist.add(values[key])});
          for (int i = 0; i < emptylist.length; i++) {
            if (emptylist[i]["email"] == loginEmailController.text) {
              SharedPreferences.getInstance().then((sharedpref) => {
                    sharedpref
                        .setString("region", this.dropdownValue!)
                        .then((data) => {
                              sharedpref
                                  .setBool("isLoggedIn", true)
                                  .then((data) => {
                                        sharedpref
                                            .setString("username",
                                                emptylist[i]["name"])
                                            .then((data) => {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          '/home'),
                                                  displayToastMessage(
                                                      "You are logged in.",
                                                      context),
                                                })
                                      })
                            })
                  });
              break;
            }
            if (i + 1 == emptylist.length) {
              displayToastMessage("Error occurred", context);
            }
          }
        });
      } catch (exception) {}
    } else {
      Navigator.pop(context);
      displayToastMessage("Error occurred", context);
    }
  }

  void registerUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Registering, Please wait...");
        });

    // fb.DatabaseReference databaseRef =
    //     fb.database().ref(dropdownValue + "-admins");

    fb.DatabaseReference databaseRef = fb.database().ref(dropdownValue);

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: regEmailController.text,
                password: regPasswordController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      Map userDataMap = {
        "name": regNameController.text.trim(),
        "id": firebaseUser.uid,
        "email": regEmailController.text.trim(),
        "grc": dropdownValue
      };
      databaseRef
          .child('admins')
          .child(regNameController.text.trim().replaceAll(" ", "_"))
          .set(userDataMap);
      Navigator.pop(context);
      displayToastMessage("Congrats, your account has been created!", context);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.pop(context);
      displayToastMessage("New user has not been created", context);
    }

    if (firebaseUser != null) {
      try {
        SharedPreferences.getInstance().then((sharedpref) => {
              sharedpref.setBool("isLoggedIn", true).then((data) => {
                    sharedpref
                        .setString("region", dropdownValue)
                        .then((data) => {
                              sharedpref
                                  .setString(
                                      "username", regNameController.text.trim())
                                  .then((data) => {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/home'),
                                        displayToastMessage(
                                            "You are logged in.", context),
                                      })
                            })
                  })
            });
      } catch (exception) {}
    } else {
      Navigator.pop(context);
      displayToastMessage("Error occurred", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
