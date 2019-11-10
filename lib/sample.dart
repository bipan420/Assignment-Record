import 'package:asignment_record_system/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String student_roll;
String student_name;
String student_address;
String student_nextOfKin;
String student_gender;
Timestamp student_dateOfBirth;
class Sample extends StatefulWidget {
  static final id = 'fuck';
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
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
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$student_name',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Roll No:',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$student_roll',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Address:',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$student_address',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Parents Name:',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$student_nextOfKin',
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        Expanded(
                  child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('assignment').orderBy('date').where('date', isGreaterThan: twoDaysAgo).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (!snapshot.hasData) return const Text('Connecting...');
              final int cardLength = snapshot.data.documents.length;
              return new ListView.builder(
                itemCount: cardLength,
                itemBuilder: (context,index) {
                  final DocumentSnapshot _card= snapshot.data.documents[index];
                  return new ListTile(
                    title: new Text('fuck'),
                    //subtitle: new Text(_card['name']),
                  );
                },
              );
            },
          ),
        )
      ],),
      
    );
  }
}