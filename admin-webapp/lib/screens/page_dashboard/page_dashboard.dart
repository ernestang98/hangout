import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/widgets/side_menu.dart';
import 'package:smart_admin_dashboard/widgets/color_constants.dart';
import 'package:smart_admin_dashboard/screens/page_dashboard/components/mini_information_card.dart';
import 'package:smart_admin_dashboard/screens/page_dashboard/components/recent_users.dart';
import 'package:smart_admin_dashboard/screens/page_dashboard/components/header.dart';
import 'package:smart_admin_dashboard/widgets/loginmanager.dart';
import 'package:smart_admin_dashboard/screens/page_dashboard/components/calendart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageDashboard extends StatefulWidget {
  @override
  _PageDashboard createState() => _PageDashboard();
}

class _PageDashboard extends State<PageDashboard> {
  Widget base = Container();
  String data2 = "";
  @override
  void initState() {
    super.initState();
    getname().then((data) => {
          setState(() {
            data2 = data!;
          }),
          redirect(context, '/home').then((data) => {
                if (data == "auth")
                  {
                    setState(() {
                      base = Scaffold(
                          appBar: AppBar(
                            title: Text("Main Dashboard"),
                            centerTitle: true,
                          ),
                          drawer: Drawer(child: SideMenu()),
                          body: SafeArea(
                            child: SingleChildScrollView(
                              //padding: EdgeInsets.all(defaultPadding),
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Column(
                                  children: [
                                    Header(param: data2),
                                    SizedBox(height: defaultPadding),
                                    MiniInformation(),
                                    SizedBox(height: defaultPadding),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              RecentUsers(),
                                              SizedBox(height: defaultPadding),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: defaultPadding,
                                            height: defaultPadding),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CalendarWidget(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    })
                  }
                else
                  {
                    setState(() {
                      base = Container();
                    })
                  },
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: base);
  }
}

Future<String?> getname() async {
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  return sharedpref.getString("username") == null
      ? "Hello World"
      : sharedpref.getString("username");
}
