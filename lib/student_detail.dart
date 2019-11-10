//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//String student_roll;
//String student_name;
//String student_address;
//String student_nextOfKin;
//String student_gender;
//Timestamp student_dateOfBirth;
//class StudentDetail extends StatefulWidget {
//  static final id = 'studentDetail';
//  @override
//  _StudentDetailState createState() => _StudentDetailState();
//}
//
//class _StudentDetailState extends State<StudentDetail> {
//  //final _firestore = Firestore.instance;
//  @override
//  Widget build(BuildContext context) {
//    int _checkValue = 0;
//   int _assignmentCheckValue = 0;
//  String checkString;
//
//  void _handleAssignmentCheck(int value){
//    setState(() {
//      _assignmentCheckValue = value;
//      switch(_assignmentCheckValue){
//        case 1:
//          checkString = 'Checked';
//          break;
//        case 2:
//          checkString = 'Not Checked';
//          break;
//      }
//    });
//  }
//
//
//    print('Student Roll No: $student_roll And Name is: $student_name');
//    return Scaffold(
//      appBar: AppBar(title: Text('$student_name Details'),),
//          body: Column(children: <Widget>[
//             Radio(
//                      value: 1,
//                      groupValue: _assignmentCheckValue,
//                      onChanged: _handleAssignmentCheck,
//                      activeColor: Color(0xff4158ba),
//
//                      ),
//                      Text('Checked'),
//
//                      Radio(
//                      value: 2,
//                      groupValue: _assignmentCheckValue,
//                      onChanged: _handleAssignmentCheck,
//                      activeColor: Color(0xff4158ba),
//
//                      ),
//                      Text('Not Checked'),
//          CircleAvatar(
//                  radius: 100,
//                  //backgroundColor: Color(0xff476cfb),
//                  child: SizedBox(
//                    width: 180.0,
//                    height: 180.0,
//                    child: Image.asset('lib/images/user.png'),
//                  ),
//                ),
//                Row(children: <Widget>[
//                  Text('Name:'),
//                  SizedBox(width: 20,),
//                  Text('$student_name'),
//                ],),
//
//                Row(children: <Widget>[
//                  Text('Roll No:'),
//                  SizedBox(width: 20,),
//                  Text('$student_roll'),
//                ],),
//
//                Row(children: <Widget>[
//                  Text('Address:'),
//                  SizedBox(width: 20,),
//                  Text('$student_address'),
//                ],),
//
//                Row(children: <Widget>[
//                  Text('Parents Name:'),
//                  SizedBox(width: 20,),
//                  Text('$student_nextOfKin'),
//                ],),
//                Column(children: <Widget>[
//                  Text('Check Assignment'),
//                  Row(children: <Widget>[
//                    Text('Assignment name: '),
//                    Text('name here'),
//                  ],),
//
//
//                  ],),
//
//
//
//
//
//
//
//
//      //   // StreamBuilder(stream: _firestore.collection('student').where('roll', isEqualTo:student_roll).snapshots(),
//      //   // builder: (BuildContext context, AsyncSnapshot snapshot){
//      //   //   if(!snapshot.hasData){
//      //   //     Center(child: CircularProgressIndicator(),);
//      //   //   }
//      //   //   final students = snapshot.data.documents;
//      //   //   for(var student in students){
//      //   //     name = student.data['name'];
//      //   //     roll = student.data['roll']
//      //   //   }
//
//      //   //   return Container(
//      //   //     color: Colors.blue,
//      //   //     child: Column(children: <Widget>[
//      //   //       Text('')
//      //   //     ],),
//      //   //   );
//      //   // },
//      //   // )
//
//
//
//      ],),
//    );
//  }
//}