import 'package:asignment_record_system/add_student.dart';
import 'package:asignment_record_system/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String student_roll;
String student_name;
String student_address;
String student_nextOfKin;
String student_gender;
String student_grade;
Timestamp student_dateOfBirth;

class CheckAssignment extends StatefulWidget {
  static final id = 'CheckAssignment';
  @override
  _CheckAssignmentState createState() => _CheckAssignmentState();
}

class _CheckAssignmentState extends State<CheckAssignment> {
  int _assignmentCheckValue = 0;
  String checkString;
  DateTime twoDaysAgo = DateTime(now.year, now.month, now.day - 2);

  void _handleAssignmentCheck(int value) {
    setState(() {
      _assignmentCheckValue = value;
      switch (_assignmentCheckValue) {
        case 1:
          checkString = 'Checked';
          break;
        case 2:
          checkString = 'Not Checked';
          break;
      }
    });
  }

  saveData() {
    DocumentReference dr = collection.document();
    Map<String, dynamic> asnment = {
      //'name': _assignmentName,
      'status': checkString,
      'checkedDate': now,
    };
    dr.setData(asnment).whenComplete(() {
      print('assignment added');
      //reset the value of textfiled

      //pickedDate('hello');

      final snackBar = SnackBar(
        content: Row(
          children: <Widget>[
            Text('Assignment has been checked'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$student_name Details'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Container(
                //height: MediaQuery.of(context).size.height*0.5,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      //backgroundColor: Color(0xff476cfb),
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: Image.asset('lib/images/user.png'),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Name:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$student_name',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                     Row(
                      children: <Widget>[
                        Text(
                          'Grade:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$student_grade',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Roll No:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$student_roll',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Address:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$student_address',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Parents Name:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$student_nextOfKin',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: collection
                      .orderBy('date')
                      .where('date', isGreaterThan: twoDaysAgo)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot recentAssignment =
                            snapshot.data.documents[index];
                        String assignmentName = recentAssignment['name'];
                        String assignmentSubject = recentAssignment['subject'];
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Check Assignment',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Last Assignment',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text('$assignmentName'),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Assignment Status',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 150),
                                    child: Radio(
                                      value: 1,
                                      groupValue: _assignmentCheckValue,
                                      onChanged: _handleAssignmentCheck,
                                      activeColor: Color(0xff4158ba),
                                    ),
                                  ),
                                  Text('Checked'),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 150),
                                    child: Radio(
                                      value: 2,
                                      groupValue: _assignmentCheckValue,
                                      onChanged: _handleAssignmentCheck,
                                      activeColor: Color(0xff4158ba),
                                    ),
                                  ),
                                  Text('Not Checked')
                                ],
                              ),
                              FlatButton(
                                color: Colors.blue,
                                child: Text('Save'),
                                onPressed: () {
                                  String rollName = studentId;
                                  DocumentReference dr = Firestore.instance.collection('student').document(rollName).collection(student_roll).document();
                                  
                                  Map<String, dynamic> asnment = {
                                    'subject':assignmentSubject,
                                    'name': assignmentName,
                                    
                                    'status': checkString,
                                    'checkedDate': now,
                                  };
                                  dr.setData(asnment).whenComplete(() {
                                    print('assignment status added');
                                    //reset the value of textfiled

                                    //pickedDate('hello');

                                    final snackBar = SnackBar(
                                      content: Row(
                                        children: <Widget>[
                                          Text('Assignment status has been checked'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(Icons.done)
                                        ],
                                      ),
                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
