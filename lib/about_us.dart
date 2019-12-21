import 'package:flutter/material.dart';
import 'main.dart';
import 'admin_home.dart';

class AboutUs extends StatefulWidget {
  static final id = 'aboutUs';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20),
                //color: Colors.deepOrange,
                height: 200,
                width: MediaQuery.of(context).size.width / 2 + 100,
                child: Image.asset('lib/images/logo.png'),
              ),
              Card(
                elevation: 10,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Ursa Major Childrens' Academy",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
             
              Container(
                padding: const EdgeInsets.only(top: 20),
                //color: Colors.white,
                height: 200,
                width: 400,
                child: Column(children: <Widget>[
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Established: ",style: TextStyle(fontSize: 18,color: Colors.black)),
                Text("2062 BS",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold))
              ],),
              SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Address: ",style: TextStyle(fontSize: 18,color: Colors.black)),
                Text("Khusibu, Link Road, Kathmandu",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold))
              ],),
              SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Email: ",style: TextStyle(fontSize: 18,color: Colors.black)),
                Text("ursamajorschool@gmail.com",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold))
              ],),
              SizedBox(height: 10,),
              Divider(height: 3,color: Colors.black12,)
                ],),
                
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
