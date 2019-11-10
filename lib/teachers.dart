import 'package:asignment_record_system/add_teacher.dart';
import 'package:asignment_record_system/admin_home.dart';
//import 'package:asignment_record_system/teacher_detail.dart';

//import 'package:asignment_record_system/teacher_detail1.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asignment_record_system/check_assignment.dart';

class Teachers extends StatefulWidget {
  static final id = 'Teachers';

  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //Navigator.pushNamed(context, AddNewteacher.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewTeacher()));
          },
        ),
        body: Container(
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
                    'Subject',
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
                  stream: Firestore.instance.collection('teachers').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot teacher =
                              snapshot.data.documents[index];
                          String roll = teacher['roll'];
                          String name = teacher['name'];
                          String address = teacher['address'];
                          String email = teacher['email'];
                          String gender = teacher['gender'];
                          String subject = teacher['subject'];
                          Timestamp dateOfBirth = teacher['dateOfBirth'];
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
                                                '$subject',
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
                                            // teacher_roll = roll;
                                            // teacher_name = name;
                                            // teacher_address = address;
                                            // teacher_dateOfBirth = dateOfBirth;
                                            // teacher_gender = gender;
                                            // teacher_nextOfKin = nextOfKin;


                                            
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
