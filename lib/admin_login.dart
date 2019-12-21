import 'package:asignment_record_system/choose_class.dart';
import 'package:asignment_record_system/main_admin.dart';
import 'package:asignment_record_system/teachers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'drawer_page.dart';
import 'add_teacher.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class LoginScreen extends StatefulWidget {
  static const id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  //final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();


   validate(){
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      if(_email == 'admin' && _password == 'admin123'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainAdminPage()));
      }
      loginUser(context,_email,_password);
    }
  }

  loginUser(BuildContext context,String email,String password) async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        teacherEmail = email;
        
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChooseClassPage()));
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print(e);
      showSpinner = false;
    }
  }

  Widget form() {
    return Form(
    key: formKey,
      child: Column(
        children: <Widget>[
          Text('Assignment Record System',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          Center(child: Container(child: Image.asset('lib/images/logo.png'),)),
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              //Do something with the user input.
              _email = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            validator: (value) =>
                value.isEmpty ? 'Email field should not be empty' : null,
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            obscureText: true,
            onChanged: (value) {
              //Do something with the user input.
              _password = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password field should not be empty';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24.0,
          ),
          new RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: (){
              validate();
            },
            child: Text('Log In as Teacher'),
          ),

          SizedBox(
            height: 24.0,
          ),
          new RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: (){
              validate();
            },
            child: Text('Log In as admin'),
          ),
        ],
      ),
    );
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[form()],
          ),
        ),
      ),
    );
  }
}
