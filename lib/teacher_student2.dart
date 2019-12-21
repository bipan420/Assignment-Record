import 'package:asignment_record_system/add_student.dart';
import 'package:asignment_record_system/admin_home.dart';
import 'package:asignment_record_system/student_detail.dart';

//import 'package:asignment_record_system/student_detail1.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asignment_record_system/check_assignment.dart';

class TeacherStudent2 extends StatefulWidget {
  static final id = 'TeacherStudent2';

  @override
  _TeacherStudent2State createState() => _TeacherStudent2State();
}

class _TeacherStudent2State extends State<TeacherStudent2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     //Navigator.pushNamed(context, AddNewStudent.id);
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => AddNewStudent()));
        //   },
        // ),
        body: SafeArea(
                  child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Roll No',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('student2').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot student =
                                snapshot.data.documents[index];
                            String roll = student['roll'];
                            String name = student['name'];
                            String address = student['address'];
                            String nextOfKin = student['nextOfKin'];
                            String gender = student['gender'];
                            String grade = student['grade'];
                            Timestamp dateOfBirth = student['dateOfBirth'];
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    elevation: 10,
                                    child: ListTile(
                                      leading: Text('$roll'),
                                      title: Text('$name'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  'View Details',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              student_roll = roll;
                                              student_name = name;
                                              student_grade = grade;
                                              student_address = address;
                                              student_dateOfBirth = dateOfBirth;
                                              student_gender = gender;
                                              student_nextOfKin = nextOfKin;


                                              
                                              Navigator.pushNamed(
                                                  context, CheckAssignment.id);
                                                  
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )

        //  Container(
        //   child: ListView(
        //     children: <Widget>[
        //       ListTile(

        //         leading: Text('1'),
        //         title: Text('Bishal Kapali'),
        //         trailing: Icon(Icons.arrow_forward_ios),
        //       ),
        //       Divider(height: 2.0,color: Colors.grey,),
        //       ListTile(
        //         leading: Image.asset('lib/images/user.png'),
        //         title: Text('Alina Karki'),
        //         trailing: Icon(Icons.arrow_forward_ios),
        //       )

        //     ],
        //   ),
        // ),
        );
  }
}
