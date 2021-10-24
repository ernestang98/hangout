import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/constant/color.dart';
import 'package:restaurant_ui_kit/constant/text_style.dart';
import 'package:restaurant_ui_kit/widgets/button_widget.dart';
import 'package:restaurant_ui_kit/widgets/top_container.dart';
import 'package:restaurant_ui_kit/widgets/back_button.dart';
import 'package:restaurant_ui_kit/widgets/my_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';
import 'package:restaurant_ui_kit/util/datetime_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'meetup_location.dart';

class CreateNewMeetupPage extends StatefulWidget {
  @override
  CreateNewMeetupPageState createState() => CreateNewMeetupPageState();
}

class CreateNewMeetupPageState extends State<CreateNewMeetupPage> {
  static DateTime date;
  /* TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController(); */
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  String textDate, textStartTime, textEndTime, day, month, week;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String locationText = "Pioneer";
  String trialTitle;
  int _choiceIndex;
  String catchoice;
  List<String> _choices = [
    "SPORT",
    "CULINARY",
    "INTEREST GROUP",
    "HEALTH",
    "LEARNING"
  ];
  /* TimeOfDay pickTime = TimeOfDay(hour: 00, minute: 00); */

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String getDateText() {
      if (date == null) {
        return 'Select Date';
      } else {
        textDate = DateFormat('dd/MM/yyyy').format(date).toString();
        month = DateTimeUtils.getMonth(date).toString();
        day = DateTimeUtils.getDayOfMonth(date).toString();
        week = DateTimeUtils.getDayOfWeek(date).toString();
        /* print("Date is " + textDate); */
        return DateFormat('dd/MM/yyyy').format(date);
        // return '${date.month}/${date.day}/${date.year}';
      }
    }

    ;

    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create a Meetup',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            labelText: "Title",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            )),
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: ButtonHeaderWidget(
                              title: 'Date',
                              text: getDateText(),
                              onClicked: () => pickDate(context),
                            ),
                          )
                          //HomePage.calendarIcon(),
                        ],
                      )
                    ],
                  )),
                  SizedBox(height: 30),
                  Container(
                      child: Row(
                    children: [
                      SizedBox(
                          width: 80,
                          child: Text(
                            "Location:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          child: Text(
                            locationText,
                          ),
                          onTap: () {
                            _navigateAndDisplaySelection(context);
                          },
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimePick("Start Time:", true, startTime, (x) {
                        setState(() {
                          startTime = x;
                          textStartTime = x.toString().substring(10, 15);
                          print("The picked time is: " + textStartTime);
                        });
                      }),
                      const SizedBox(height: 10),
                      _buildTimePick("End Time:", true, endTime, (x) {
                        setState(() {
                          endTime = x;
                          textEndTime = x.toString().substring(10, 15);
                          print("The picked time is: " + textEndTime);
                        });
                      }),
                    ],

                    /* <Widget>[
                      Expanded(
                        child: TimePickerWidget(),
                        /* ButtonHeaderWidget(
                        title: 'Start Time',
                        text: getDateText(),
                        onClicked: () => pickTime(context),
                        //icon: downwardIcon,
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'End Time',
                          //icon: downwardIcon,
                        ),*/
                      ),
                    ], */
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: desController,
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        )),
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            _buildChoiceChips(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                        child: Text(
                          'Create Meetup',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          print(catchoice);
                          createMeetup();
                          Fluttertoast.showToast(
                              msg: "Meetup Created",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade300,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() => date = newDate);
  }

  Widget _buildChoiceChips() {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _choices.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(_choices[index]),
            selected: _choiceIndex == index,
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _choiceIndex = selected ? index : 0;
                catchoice = _choices[_choiceIndex].toLowerCase();
              });
            },
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
      Function(TimeOfDay) onTimePicked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: Text(
              currentTime.format(context),
            ),
            onTap: () {
              pickTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Future pickTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (_pickedTime != null) {
      onTimePicked(_pickedTime);
    }
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => CreateNewMeetupLocationsPage()),
    );
    setState(() {
      locationText = result;
    });
  }

  void createMeetup() {
    DatabaseManager().createMeetup(
        textDate,
        textStartTime,
        textEndTime,
        titleController.text,
        desController.text,
        locationText,
        catchoice,
        day,
        month,
        week);
  }
}
