import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'assignmnet_list.dart';

final collection = Firestore.instance.collection('assignment');
DateTime now = DateTime.now();

class TeacherHome2 extends StatefulWidget {
  static final id = 'TeacherHome2';

  @override
  _TeacherHome2State createState() => _TeacherHome2State();
}

class _TeacherHome2State extends State<TeacherHome2> {
  //for reseting the value of the textfield
  TextEditingController _controller = TextEditingController();

  //for resetting the value of the date field, which is a text

  // DateTime now = DateTime.now();
  String _assignmentName;
  DateTime _assignmentDueDate;

  String currentDate = DateFormat().add_yMMMMEEEEd().format(now);

  //String formattedAssignentDate = DateFormat().add_yMMMMEEEEd().format(_assignmentDate);

  saveData() {
    DocumentReference dr = collection.document(_assignmentName);
    Map<String, dynamic> asnment = {
      'name': _assignmentName,
      'date': now,
      'dueDate': _assignmentDueDate,
    };
    dr.setData(asnment).whenComplete(() {
      print('assignment added');
      //reset the value of textfiled
      _controller.text = '';
      //pickedDate('hello');

      final snackBar = SnackBar(
        content: Row(
          children: <Widget>[
            Text('Data has been added'),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.done)
          ],
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  List<Container> recentHomework = [];

  Container getData() {
    DateTime threeDaysAgo = DateTime(now.year, now.month, now.day - 3);
    print('Three days ago it was: $threeDaysAgo');
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: collection
            .orderBy('date')
            .where('date', isGreaterThan: threeDaysAgo)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            Center(child: Text('No recent homework'));
          }

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot recentHomework = snapshot.data.documents[index];
              Timestamp assignmentDate;
              String assignment_date;
              assignmentDate = recentHomework['date'];
              assignment_date =
                  // DateFormat().add_yMMMMEEEEd().format(assignmentDate.toDate());
                  DateFormat().add_yMd().format(assignmentDate.toDate());
              return Column(
                children: <Widget>[
                  

                  Card(elevation: 10,
                  child: ListTile(
                    leading: Text('${recentHomework['name']}'),
                    
                    trailing: Text('Added: $assignment_date'),
                  ),)
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: FlatButton(
      //     child: Text('View History'),
      //     onPressed: () {
      //       Navigator.pushNamed(context, AssignmentListPage.id);
      //     },
      //   ),
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            //Displays the date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                    child: Text(
                  '$currentDate',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Text('Subject: Science',style: TextStyle(fontSize: 20),),

            //Displays the recent assignment
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black54,
                            child: Center(
                              child: Text(
                                'Recent Assignments',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            child: getData(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Add assignment
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Add new Assignment',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      TextField(
                        controller: _controller,
                        onChanged: (value) {
                          _assignmentName = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Assignment',
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Due Date: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            _assignmentDueDate == null
                                ? ''
                                : DateFormat()
                                    .add_yMMMMEEEEd()
                                    .format(_assignmentDueDate)
                                    .toString(),
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: _assignmentDueDate == null
                                      ? DateTime.now()
                                      : _assignmentDueDate,
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2021))
                              .then((date) {
                            setState(() {
                              _assignmentDueDate = date;
                            });
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          //submit the assignment to database and retrieve it
                          saveData();
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'View Assignment History',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AssignmentListPage.id);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
