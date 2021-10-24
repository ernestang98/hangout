import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/foods.dart';
import 'package:restaurant_ui_kit/util/location.dart';



class SearchLocationScreen extends StatefulWidget {
  @override
  _SearchLocationScreenState createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> with AutomaticKeepAliveClientMixin<SearchLocationScreen>{
  final TextEditingController _searchControl = new TextEditingController();
  String city = "Singapore";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
        leading:
        IconButton(
          icon: Icon(
          Icons.keyboard_backspace,
          color: Colors.black,
        ),
        onPressed: ()=>_sendDataBack(context, city),
    ),

        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Select Location",
          style: TextStyle(
            color: Colors.black,
          ),

        ),


    ),
    body: Padding(
      padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),

          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),

          SizedBox(height: 5.0),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Current Region: ${city}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),


        // Listview here helps to put all the container in one row.
      ListView.builder(
            shrinkWrap: true,
            primary: false,

            physics: NeverScrollableScrollPhysics(),
            itemCount: location == null ? 0 :location.length,
            itemBuilder: (BuildContext context, int index) {

              Map loc = location[index];
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "${loc['name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                  ),
                    subtitle: loc['name'] ==  "Use My Current Location" ? null : Text("${loc['region']}",),
                    leading: loc['name'] ==  "Use My Current Location" ? null : CircleAvatar(
                        backgroundImage: ExactAssetImage("${loc['img']}")),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber),
                    onTap: (){
                      setState(() {
                        if (loc['name'] == "Use My Current Location") {
                          city = "West Coast";
                        }
                        else {
                          city = "${loc['name']}";
                        }
                      });
                      _sendDataBack(context, city);
                      },
                  ),
                  Divider(), //                           <-- Divider
                ],
              );

            },
          ),


          SizedBox(height: 30),
        ],
      ),
    ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _sendDataBack(BuildContext context, String city) {
    String textToSendBack = city;
    Navigator.pop(context, textToSendBack);
  }
}
