import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'teachers.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class AddNewTeacher extends StatefulWidget {
  static final id = 'newStudent';
  @override
  _AddNewTeacherState createState() => _AddNewTeacherState();
}

class _AddNewTeacherState extends State<AddNewTeacher> {
  String _name, _address, _email, _password;
  String _rollNo;
  String _grade;
  static DateTime _dateOfBirth;
  Timestamp _birthDate;
  final formKey = GlobalKey<FormState>();

  int _genderValue = 0;
  String _gender;

  int _subjectValue = 0;
  String _subject;
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

  void _handleSubjectType(int value) {
    setState(() {
      _subjectValue = value;
      switch (_subjectValue) {
        case 1:
          _subject = 'English';
          break;
        case 2:
          _subject = 'Mathematics';
          break;
        case 3:
          _subject = 'Nepali';
          break;
        case 4:
          _subject = 'Science';
          break;
        case 5:
          _subject = 'Social Study';
          break;
        case 6:
          _subject = 'Physical Education';
          break;
        case 7:
          _subject = 'Accounting';
          break;
        case 8:
          _subject = 'Computer';
          break;
      }
    });
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      signUpUser(context, _rollNo, _name, _email, _password, _birthDate,
          _gender, _address, _subject);
          formKey.currentState.reset();

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
    }
  }

  signUpUser(
      BuildContext context,
      String roll,
      String name,
      String email,
      String password,
      Timestamp dateOfBirth,
      String gender,
      String address,
      String subject) async {
    final _firestore = Firestore.instance;
    setState(() {
      showSpinner = true;
    });
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser signedInUser = user;
      if (signedInUser != null) {
        _firestore.collection('teachers').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'roll': roll,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'address': address,
          'subject': subject
        }).whenComplete(() {
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Teachers()));
        });

        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print(e);
      showSpinner = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String roll) {
                        _rollNo = roll;
                      },
                      validator: (value) => value.isEmpty
                          ? 'Roll Number field should not be empty'
                          : null,
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
                      validator: (value) => value.isEmpty
                          ? 'Name field should not be empty'
                          : null,
                      decoration: InputDecoration(labelText: "Name: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String email) {
                        _email = email;
                      },
                      validator: (value) => value.isEmpty
                          ? 'Email field should not be empty'
                          : null,
                      decoration: InputDecoration(labelText: "Email: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      onChanged: (String password) {
                        _password = password;
                      },
                      obscureText: true,
                      validator: (value) => value.isEmpty
                          ? 'Password field should not be empty'
                          : null,
                      decoration: InputDecoration(labelText: "Password: "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Date of Birth',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          'Select Subject',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('English'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Mathematics'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Nepali'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 4,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Science'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 5,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Social Study'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 6,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Physical Education'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 7,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Accounting'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 7,
                            groupValue: _subjectValue,
                            onChanged: _handleSubjectType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Computer'),
                        ],
                      ),
                    ],
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
                      validator: (value) => value.isEmpty
                          ? 'Address field should not be empty'
                          : null,
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
