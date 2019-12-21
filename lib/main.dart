import 'package:asignment_record_system/admin_setting.dart';
import 'package:asignment_record_system/check_assignment.dart';
import 'package:asignment_record_system/drawer_page.dart';
import 'package:asignment_record_system/main_admin.dart';
import 'package:asignment_record_system/sample.dart';
import 'package:asignment_record_system/student_detail.dart';
import 'package:flutter/material.dart';
import 'admin_home.dart';
import 'students.dart';
import 'about_us.dart';
import 'admin_login.dart';
import 'add_student.dart';
import 'assignmnet_list.dart';
import 'check_assignment.dart';

void main() => runApp(AsignmentSystem());

class AsignmentSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: LoginScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        
        DrawerHome.id:(context) => DrawerHome(),
        AdminHome.id: (context) => AdminHome(),
        Students.id: (context) => Students(),
        LoginScreen.id: (context)=>LoginScreen(),
        AddNewStudent.id: (context) => AddNewStudent(),
        AssignmentListPage.id: (context)=> AssignmentListPage(),
        CheckAssignment.id : (context) => CheckAssignment(),
        //StudentDetail.id: (context) => StudentDetail()
        Sample.id: (context)=>Sample(),
        MainAdminPage.id : (context) => MainAdminPage()
      },
    );
  }
}

