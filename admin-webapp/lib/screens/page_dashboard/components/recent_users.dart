import 'package:smart_admin_dashboard/widgets/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:smart_admin_dashboard/models/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/widgets/side_menu.dart';
import 'package:smart_admin_dashboard/widgets/card.dart';
import 'package:smart_admin_dashboard/widgets/Poi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pagination/pagination.dart';
import 'package:smart_admin_dashboard/widgets/loginmanager.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/page_authentication/progress_dialog.dart';

class RecentUsers extends StatelessWidget {
  const RecentUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "List of registered administrators:",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("Name Surname"),
                  ),
                  // DataColumn(
                  //   label: Text("Applied Position"),
                  // ),
                  DataColumn(
                    label: Text("E-mail"),
                  ),
                  // DataColumn(
                  //   label: Text("Registration Date"),
                  // ),
                  // DataColumn(
                  //   label: Text("Status"),
                  // ),
                  // DataColumn(
                  //   label: Text("Operation"),
                  // ),
                ],
                rows: List.generate(
                  recentUsers.length,
                  (index) => recentUserDataRow(recentUsers[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<RecentUser>> getusers() async {
  fb.DatabaseReference databaseRef;
  List<RecentUser> data = [];
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  String? region = sharedpref.getString("region");
  databaseRef = fb.database().ref(region! + "-admins");
  await databaseRef.once('value').then((query) async {
    fb.DataSnapshot snapshot = query.snapshot;
    var values = snapshot.val();
    await values.forEach((key, value) => {data.add(values[key])});
  });
  return data;
}

// List<RecentUser> getusers() {
//   fb.DatabaseReference databaseRef;
//   List<RecentUser> data = [];
//   String? region;
//   SharedPreferences.getInstance().then((sharedpref) => {
//         region = sharedpref.getString("region"),
//         databaseRef = fb.database().ref(region! + "-admins"),
//         databaseRef.once('value').then((query) async {
//           fb.DataSnapshot snapshot = query.snapshot;
//           var values = snapshot.val();
//           await values.forEach((key, value) => {data.add(values[key])});
//           return data;
//         })
//       });
// }

List<RecentUser>? asd() {
  getusers().then((data) => {data});
}

DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            TextAvatar(
              size: 35,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 14,
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: userInfo.name!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      // DataCell(Container(
      //     padding: EdgeInsets.all(5),
      //     decoration: BoxDecoration(
      //       color: getRoleColor(userInfo.role).withOpacity(.2),
      //       border: Border.all(color: getRoleColor(userInfo.role)),
      //       borderRadius: BorderRadius.all(Radius.circular(5.0) //
      //           ),
      //     ),
      //     child: Text(userInfo.role!))),
      DataCell(Text(userInfo.email!)),
      // DataCell(Text(userInfo.date!)),
      // DataCell(Text(userInfo.posts!)),
      // DataCell(
      //   Row(
      //     children: [
      //       TextButton(
      //         child: Text('View', style: TextStyle(color: greenColor)),
      //         onPressed: () {},
      //       ),
      //       SizedBox(
      //         width: 6,
      //       ),
      //       TextButton(
      //         child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
      //         onPressed: () {
      //           showDialog(
      //               context: context,
      //               builder: (_) {
      //                 return AlertDialog(
      //                     title: Center(
      //                       child: Column(
      //                         children: [
      //                           Icon(Icons.warning_outlined,
      //                               size: 36, color: Colors.red),
      //                           SizedBox(height: 20),
      //                           Text("Confirm Deletion"),
      //                         ],
      //                       ),
      //                     ),
      //                     content: Container(
      //                       color: secondaryColor,
      //                       height: 70,
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                               "Are you sure want to delete '${userInfo.name}'?"),
      //                           SizedBox(
      //                             height: 16,
      //                           ),
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               ElevatedButton.icon(
      //                                   icon: Icon(
      //                                     Icons.close,
      //                                     size: 14,
      //                                   ),
      //                                   style: ElevatedButton.styleFrom(
      //                                       primary: Colors.grey),
      //                                   onPressed: () {
      //                                     Navigator.of(context).pop();
      //                                   },
      //                                   label: Text("Cancel")),
      //                               SizedBox(
      //                                 width: 20,
      //                               ),
      //                               ElevatedButton.icon(
      //                                   icon: Icon(
      //                                     Icons.delete,
      //                                     size: 14,
      //                                   ),
      //                                   style: ElevatedButton.styleFrom(
      //                                       primary: Colors.red),
      //                                   onPressed: () {},
      //                                   label: Text("Delete"))
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ));
      //               });
      //         },
      //         // Delete
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
