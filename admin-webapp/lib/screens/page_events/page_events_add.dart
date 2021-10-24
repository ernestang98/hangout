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

class PageEventsAdd extends StatefulWidget {
  const PageEventsAdd({Key? key}) : super(key: key);
  @override
  _PageEventsAdd createState() => _PageEventsAdd();
}

class _PageEventsAdd extends State<PageEventsAdd> {
  Widget base = Container();
  Uint8List? fileBytes;
  String? filename;
  List<Uint8List> gallerypics = [];
  bool isSwitched = false;
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
          title: Text("Add Events"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/events');
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
                                    : Container(height: 0, width: 0),
                              ],
                            ),
                            // Column(
                            //   children: [
                            //     Row(children: [
                            //       TextButton(
                            //         child: Container(
                            //             margin: EdgeInsets.only(
                            //                 left: 6,
                            //                 right: 1,
                            //                 top: 15,
                            //                 bottom: 15),
                            //             color: Colors.blue,
                            //             width: 270,
                            //             height: 50,
                            //             child: Padding(
                            //                 padding: EdgeInsets.fromLTRB(
                            //                     15, 15, 15, 15),
                            //                 child: Text(
                            //                     'Select gallery pictures',
                            //                     style: TextStyle(
                            //                         fontSize: 15,
                            //                         color: Colors.white)))),
                            //         onPressed: () async {
                            //           FilePickerResult? result =
                            //               await FilePicker.platform.pickFiles(
                            //             allowMultiple: true,
                            //             type: FileType.custom,
                            //             allowedExtensions: [
                            //               'jpg',
                            //               'jpeg',
                            //               'png'
                            //             ],
                            //           );
                            //           if (result != null) {
                            //             this.gallerypics = [new Uint8List(0)];
                            //             List<Uint8List> files = [];
                            //             for (var i = 0; i < result.count; i++) {
                            //               PlatformFile file = result.files[i];
                            //               files.add(file.bytes!);
                            //             }
                            //             setState(() {
                            //               this.gallerypics = files;
                            //             });
                            //           }
                            //           forceRebuild();
                            //         },
                            //       ),
                            //       TextButton(
                            //         child: Container(
                            //             margin: EdgeInsets.only(
                            //                 left: 1,
                            //                 right: 6,
                            //                 top: 15,
                            //                 bottom: 15),
                            //             color: Colors.grey,
                            //             width: 80,
                            //             height: 50,
                            //             child: Padding(
                            //                 padding: EdgeInsets.fromLTRB(
                            //                     15, 15, 15, 15),
                            //                 child: Text('Clear',
                            //                     style: TextStyle(
                            //                         fontSize: 15,
                            //                         color: Colors.white)))),
                            //         onPressed: () {},
                            //       )
                            //     ]),
                            //     this.gallerypics != []
                            //         ? new Row(
                            //             children: this
                            //                 .gallerypics
                            //                 .map((item) => Image.memory(
                            //                       item,
                            //                       width: 50,
                            //                       height: 100,
                            //                       fit: BoxFit.cover,
                            //                     ))
                            //                 .toList())
                            //         : Container(height: 0, width: 0),
                            //   ],
                            // ),
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
                                    String url = "";
                                    try {
                                      Uri URL = await create(context);
                                      url = URL.toString();
                                    } catch (exception) {
                                      url =
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvZki1EoCKV8aavs6hmPzqmnWUg-USH2qEiZSIhr3f6pa92z1DujPF10BHO8fXBI25zFY&usqp=CAU";
                                    }
                                    SharedPreferences sharedpref =
                                        await SharedPreferences.getInstance();
                                    String? region =
                                        sharedpref.getString("region");
                                    fb.DatabaseReference databaseRef =
                                        fb.database().ref(region!);
                                    Map userDataMap = {
                                      "name": nameController.text
                                          .trim()
                                          .replaceAll(" ", "_"),
                                      "location": locController.text.trim(),
                                      "description": desController.text.trim(),
                                      "imageurl": url,
                                      "category": catController.text.trim(),
                                      "trending": isSwitched.toString()
                                    };
                                    databaseRef
                                        .child('events')
                                        .child(nameController.text
                                            .trim()
                                            .replaceAll(" ", "_"))
                                        .set(userDataMap);

                                    Navigator.of(context)
                                        .pushReplacementNamed('/events');
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

  Future<Uri> create(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Uploading image please wait...");
        });

    fb.StorageReference storageRef =
        fb.storage().ref('images/${this.filename!}');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(this.fileBytes!).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    print(imageUri.toString());
    displayToastMessage("Success!", context);
    Navigator.pop(context);
    return imageUri;
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}


// https://pub.dev/packages/file_picker
// https://medium.com/swlh/forms-and-validation-in-flutter-login-ui-f2e7db4e00c9
