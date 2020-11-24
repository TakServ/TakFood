import 'package:flutter/material.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/signout_process.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Rider'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => singOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[showHead()],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('Rider.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name Rider',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Email Rider',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
