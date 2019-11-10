import 'package:flutter/material.dart';
import 'admin_home.dart';
import 'admin_login.dart';
class AdminSetting extends StatefulWidget {
  @override
  _AdminSettingState createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Container(
        
        child: Column(children: <Widget>[
        
        Center(
          child: CircleAvatar(
                    radius: 100,
                    //backgroundColor: Color(0xff476cfb),
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: Image.asset('lib/images/admin.png'),
                    ),
                  ),
        ),

        Container(
          padding: EdgeInsets.fromLTRB(30, 10, 20, 20),
          child: Column(children: <Widget>[

           Row(children: <Widget>[
          Text('Name: ', style: TextStyle(color: Colors.black, fontSize: 20),),
          Text('Bishal Kapali',style: TextStyle(color: Colors.black,fontSize: 18),),
        ],),

         Row(children: <Widget>[
          Text('Email: ',style: TextStyle(color: Colors.black, fontSize: 20)),
          Text('bishal@admin.com',style: TextStyle(color: Colors.black,fontSize: 18)),
        ],),
        ],),),

       
        RaisedButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
          },
          child: Text('Log Out'),)

      ],),),
    );
    
  }
}