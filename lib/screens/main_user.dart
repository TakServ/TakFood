import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/signout_process.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main User' : '$nameUser Login'),
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
      decoration: MyStyle().myBoxDecoration('User.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name User',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Email User',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
