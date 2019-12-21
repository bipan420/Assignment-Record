import 'package:asignment_record_system/admin_login.dart';
import 'package:asignment_record_system/drawerhome1.dart';
import 'package:asignment_record_system/drawerhome2.dart';
import 'package:asignment_record_system/student1.dart';
import 'package:asignment_record_system/student2.dart';
import 'package:asignment_record_system/teachers.dart';
import 'package:flutter/material.dart';

class ChooseClassPage extends StatefulWidget {
  static final id = "mainAdmin";
  @override
  _ChooseClassPageState createState() => _ChooseClassPageState();
}

class _ChooseClassPageState extends State<ChooseClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Admin Page'),
        actions: <Widget>[
          FlatButton(
            child: Text("Log Out"),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              
              SizedBox(
                height: 50,
              ),
              Card(
                  elevation: 10,
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        hoverColor: Colors.blue,
                        onTap: () {
                          print('Card tapped.');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Teachers()));
                        },
                        child: Container(
                          width: 300,
                          height: 100,
                          child: Center(
                              child: Text(
                            'Students',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Class 1',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerHome1()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 2',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DrawerHome2()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 3',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 4',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 5',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 6',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 7',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Class 8',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
