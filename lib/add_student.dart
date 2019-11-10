import 'package:asignment_record_system/check_assignment.dart';
import 'package:asignment_record_system/student_model.dart';
import 'package:asignment_record_system/students.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//import 'package:firebase_auth/firebase_auth.dart';
var studentId;
class AddNewStudent extends StatefulWidget {
  static final id = 'newStudent';
  
  @override
  _AddNewStudentState createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  static String _name, _nextOfKin, _address;
  static String _rollNo;
  String _grade;
  static DateTime _dateOfBirth;
  Timestamp _birthDate;
  final formKey = GlobalKey<FormState>();
  String rollName;

  int _genderValue = 0;
  String _gender;
  bool showSpinner = false;

  void _handleGenderType(int value) {
    setState(() {
      _genderValue = value;
      switch (_genderValue) {
        case 1:
          _gender = 'Male';
          break;
        case 2:
          _gender = 'Female';
          break;
        case 3:
          _gender = 'Others';
          break;
      }
    });
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      signUpUser(context, _rollNo, _name, _birthDate,_gender, _nextOfKin,_address,_grade);
      formKey.currentState.reset();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Students()));
    }
  }

  signUpUser(BuildContext context, String roll, String name, 
      Timestamp dateOfBirth, String gender, String nextOfKin,String address,String grade) {
        final _firestore = Firestore.instance;
        setState(() {
          showSpinner = true;
        });
        try{
          String rollName = "$roll+$name";
           _firestore.collection('student').document(rollName).setData({
          'name':name,
          'roll':roll,
          'dateOfBirth':dateOfBirth,
          'gender':gender,
          'nextOfKin':nextOfKin,
          'address':address,
          'grade':grade

        }).whenComplete((){
          studentId = rollName;
            final snackBar = SnackBar(
        content: Row(
          children: <Widget>[
            Text('Account created'),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.done)
          ],
        ),
      );

      Scaffold.of(context).showSnackBar(snackBar);
        });

      

      setState(() {
        showSpinner = false;
      });

        }
        catch(e){
          print(e);
          showSpinner = false;
          }
       
      

      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
              child: SingleChildScrollView(
                              child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String grade) {
                        _grade = grade;
                      },
                      validator: (value) => value.isEmpty ? 'Grade field should not be empty': null,
                      decoration: InputDecoration(labelText: "Grade: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String roll) {
                        _rollNo = roll;
                      },
                      validator: (value) => value.isEmpty ? 'Roll Number field should not be empty': null,
                      decoration: InputDecoration(labelText: "Roll No: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String name) {
                        _name = name;
                      },
                      validator: (value) => value.isEmpty ? 'Name field should not be empty':null,
                      decoration: InputDecoration(labelText: "Name: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(_dateOfBirth == null
                            ? ''
                            : DateFormat()
                                .add_yMMMMEEEEd()
                                .format(_dateOfBirth)
                                .toString()),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Pick a date'),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _dateOfBirth == null
                                  ? DateTime.now()
                                  : _dateOfBirth,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2021))
                          .then((date) {
                        setState(() {
                          //dateOfBirth = date;
                          _dateOfBirth = date;
                          _birthDate = Timestamp.fromDate(_dateOfBirth);
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          'Select Gender Type',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _genderValue,
                            onChanged: _handleGenderType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Male'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _genderValue,
                            onChanged: _handleGenderType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Female'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: _genderValue,
                            onChanged: _handleGenderType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Others'),
                        ],
                      ),
                     
                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String nextOfKin) {
                        _nextOfKin = nextOfKin;
                      },
                      validator: (value) => value.isEmpty ? 'Next of kin should not be empty': null,
                      decoration: InputDecoration(labelText: "Next of Kin: "),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String address) {
                        _address = address;
                      },
                      validator: (value) => value.isEmpty? 'Address field should not be empty':null,
                      decoration: InputDecoration(labelText: "Address: "),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Color(0xFFFA7397),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFFFDDE42),
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: validate,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                ],
            ),
          ),
        ),
              ),
      ),
    );
  }
}
