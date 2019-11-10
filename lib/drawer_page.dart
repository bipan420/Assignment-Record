import 'package:flutter/material.dart';
import 'about_us.dart';
import 'students.dart';
import 'admin_setting.dart';
import 'admin_home.dart';
import 'add_student.dart';
import 'admin_login.dart';
String teacherEmail;
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DrawerHome extends StatefulWidget {
  static final id = 'drawerHome';
  final drawerItems = [
    DrawerItem("Home", Icons.home),
    DrawerItem("Students", Icons.people),
    DrawerItem("About", Icons.info),
    DrawerItem("Setting", Icons.settings)
  ];
  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}



class _DrawerHomeState extends State<DrawerHome> {

 

  int _selectedDrawerIndex = 0;

  _getItemWidget(int pos) {
    switch (pos) {
      case 0:
        return AdminHome();
      case 1:
        return Students();
      case 2: 
        return AboutUs();
      case 3:
         return AdminSetting();
      default:
        return Text('Drawer error');
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          onTap: () => _onSelectItem(i),
          selected: i == _selectedDrawerIndex,
          
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: Drawer(child: Column(children: <Widget>[
        Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Teacher'),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(color: Colors.lightBlue),
              ),
              Column(children: drawerOptions,)
          ],
        ),
          
      ],),),
      body: _getItemWidget(_selectedDrawerIndex),
    );
  }
}
