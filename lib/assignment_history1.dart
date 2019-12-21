import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
//import 'assignment_details_page.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class AssignmentListPage1 extends StatefulWidget {
  static final id = 'assignmentList';

  @override
  _AssignmentListPage1State createState() => _AssignmentListPage1State();
}

class _AssignmentListPage1State extends State<AssignmentListPage1> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'assignment List',
        ),
        
      ),
      body: AssignmentList(),
    );
  }
}

class AssignmentList extends StatelessWidget {
  static String assignmentName;
  static String assignmentImage;
  Timestamp assignmentDate;
  String assignment_Date;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Text(
          'assignments List',
          style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
        )),
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance.collection('assignment').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('The assignments field is empty '),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var itemCount = snapshot.data.documents.length;
                      DocumentSnapshot assignmentInfo =
                          snapshot.data.documents[itemCount-index-1];
                          assignmentDate = assignmentInfo['date'];
                          assignment_Date =
                          // DateFormat().add_yMMMMEEEEd().format(assignmentDate.toDate());
                          DateFormat().add_yMd().format(assignmentDate.toDate());

                          
                          

                      return Column(
                        children: <Widget>[
                          Container(
                            child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10.0),
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Text('${index+1}'),
                                        title: Text(
                                          '${assignmentInfo['name']}',
                                          style: TextStyle(
                                              fontFamily: 'Sourse Sans Pro',
                                              fontSize: 20.0,
                                              color: Colors.teal[900]),
                                        ),
                                        subtitle: Text('I am a assignment'),
                                        trailing:Text('$assignment_Date'),
                                            //Text('${assignmentInfo['date']}'),
                                        // onTap: () {
                                        //   assignmentName =
                                        //       '${assignmentInfo['name']}';
                                        //   assignmentImage =
                                        //       '${assignmentInfo['image']}';
                                        //   print(assignmentName);
                                        //   Navigator.pushNamed(context, assignmentDetailsPage.id);
                                        // },
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              }),
        ),
      ],
    );
  }
}
