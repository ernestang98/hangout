import 'package:smart_admin_dashboard/screens/forms/components/add_new_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/widgets/side_menu.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:smart_admin_dashboard/widgets/loginmanager.dart';
import 'package:smart_admin_dashboard/widgets/color_constants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:smart_admin_dashboard/screens/page_authentication/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
  final String name;
  final String des;
  final String loc;
  final String cat;
  final bool trending;
  final String image;
  final String id;
  final String type;
  FormMaterial(
      {required String name,
      required String des,
      required String loc,
      required String cat,
      required String id,
      required String type,
      required bool trending,
      required var image})
      : this.name = name,
        this.des = des,
        this.loc = loc,
        this.cat = cat,
        this.image = image,
        this.id = id,
        this.type = type,
        this.trending = trending;
}

class _FormMaterialState extends State<FormMaterial> {
  Widget base = Container();
  Uint8List? fileBytes;
  String fileURL = "";
  String? filename;
  List<Uint8List> gallerypics = [];
  bool isSwitched = false;
  String id = "";
  String activity = "";
  String path = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final catController = TextEditingController();
  final locController = TextEditingController();
  final desController = TextEditingController();
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      switch (this.widget.type) {
        case "poi":
          activity = "places_of_interests";
          path = "/placesofinterests";
          break;
        case "food":
          activity = "food_options";
          path = "/foodoptions";
          break;
        case "events":
        default:
          activity = "events";
          path = "/events";
          break;
      }
    });
    setState(() {
      nameController.text = this.widget.name;
      catController.text = this.widget.cat;
      locController.text = this.widget.loc;
      desController.text = this.widget.des;
      isSwitched = this.widget.trending;
      id = this.widget.id;
      fileURL = this.widget.image;
    });
    redirect(context, '/home').then((value) => {
          if (value == "auth")
            {forceRebuild()}
          else
            {
              setState(() {
                base = Container();
              })
            },
        });
  }

  @override
  void dispose() {
    setState(() {
      base = Container();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: base);
  }

  void forceRebuild() {
    setState(() {
      base = Scaffold(
        appBar: AppBar(
          title: Text("Edit Activity"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(path);
                  },
                  child: Icon(
                    Icons.backspace,
                    size: 26.0,
                  ),
                ))
          ],
        ),
        drawer: Drawer(child: SideMenu()),
        body: SingleChildScrollView(
            child: Card(
                // color: Colors.blueGrey[50],
                margin: EdgeInsets.symmetric(horizontal: 500, vertical: 50),
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      padding: new EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 50.0, top: 50.0),
                      child: Form(
                        autovalidate: true, //check for validation while typing
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      hintText: 'e.g. Sentosa'),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    // EmailValidator(errorText: "Enter valid email id"),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                  controller: catController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Category',
                                      hintText: 'e.g. Community Centre'),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    // EmailValidator(errorText: "Enter valid email id"),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                  controller: locController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Location',
                                      hintText: 'e.g. Jalan Besar'),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    // EmailValidator(errorText: "Enter valid email id"),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                  controller: desController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Description',
                                      hintText:
                                          'e.g. This is a place to have lots of fun :)'),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    // EmailValidator(errorText: "Enter valid email id"),
                                  ])),
                            ),
                            Column(
                              children: [
                                Row(children: [
                                  TextButton(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 6,
                                            right: 1,
                                            top: 15,
                                            bottom: 5),
                                        color: greenColor,
                                        width: 270,
                                        height: 50,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            child: Text(
                                                'Select display picture',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)))),
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'jpg',
                                          'jpeg',
                                          'png'
                                        ],
                                      );
                                      if (result != null) {
                                        setState(() {
                                          this.fileBytes =
                                              result.files.first.bytes!;
                                          this.filename =
                                              result.files.first.name;
                                        });
                                      }
                                      forceRebuild();
                                    },
                                  ),
                                  TextButton(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 1,
                                            right: 6,
                                            top: 15,
                                            bottom: 5),
                                        color: Colors.grey,
                                        width: 80,
                                        height: 50,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            child: Text('Clear',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)))),
                                    onPressed: () {
                                      setState(() {
                                        this.fileBytes = null;
                                      });
                                      forceRebuild();
                                    },
                                  )
                                ]),
                                this.fileBytes != null
                                    ? Image.memory(
                                        this.fileBytes!,
                                        width: 250,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        this.fileURL,
                                        width: 250,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, //Center Row contents vertically,
                                children: [
                                  Text("Trending: ",
                                      style: TextStyle(fontSize: 17)),
                                  SizedBox(height: 4.0, width: 4.0),
                                  Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                          forceRebuild();
                                        });
                                      },
                                      activeTrackColor: Colors.amberAccent,
                                      activeColor: Colors.amber),
                                ]),
                            Container(height: 50, width: 1),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    print("Validated");
                                    Uri? url = await create(context);
                                    SharedPreferences sharedpref =
                                        await SharedPreferences.getInstance();
                                    String? region =
                                        sharedpref.getString("region");
                                    await fb
                                        .database()
                                        .ref(region!)
                                        .child(activity)
                                        .child(this.id)
                                        .remove();
                                    fb.DatabaseReference databaseRef = fb
                                        .database()
                                        .ref(region)
                                        .child(activity);

                                    Map userDataMap = {
                                      "name": nameController.text
                                          .trim()
                                          .replaceAll(" ", "_"),
                                      "location": locController.text.trim(),
                                      "description": desController.text.trim(),
                                      "imageurl": url == null
                                          ? this.fileURL
                                          : url.toString(),
                                      "category": catController.text.trim(),
                                      "trending": isSwitched.toString()
                                    };
                                    await databaseRef
                                        .child(nameController.text
                                            .trim()
                                            .replaceAll(" ", "_"))
                                        .update(userDataMap);
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .pushReplacementNamed(path);
                                  } else {
                                    print("Not Validated");
                                  }
                                },
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )))),
      );
    });
  }

  Future<Uri?> create(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Uploading image please wait...");
        });

    if (this.fileBytes != null) {
      fb.StorageReference storageRef =
          fb.storage().ref('images/${this.filename!}');
      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageRef.put(this.fileBytes!).future;
      Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
      displayToastMessage("Success!", context);
      Navigator.pop(context);
      return imageUri;
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}


// https://pub.dev/packages/file_picker
// https://medium.com/swlh/forms-and-validation-in-flutter-login-ui-f2e7db4e00c9
