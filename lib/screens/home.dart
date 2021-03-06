import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takfood/screens/main_rider.dart';
import 'package:takfood/screens/main_shop.dart';
import 'package:takfood/screens/main_user.dart';
import 'package:takfood/screens/signIn.dart';
import 'package:takfood/screens/signUp.dart';
import 'package:takfood/utility/my_constant.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/normal_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      String token = await firebaseMessaging.getToken();
      print('Toke ==>> $token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('chooseType');
      String idLogin = preferences.getString('id');
      //print('idLogin : $idLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        String url =
            '${MyConstant().domain}/TakFood/editTokenWhereId.php?isAdd=true&id=$idLogin&Token=$token';
        await Dio().get(url).then((value) => null);
      }
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          normalDialog(context, 'yes User');
          routeToService(MainUser());
        } else if (chooseType == 'Shop') {
          routeToService(MainShop());
        } else if (chooseType == 'Rider') {
          routeToService(MainRider());
        } else {
          normalDialog(context, 'Login Error');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoration('Guest.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Guest'),
        accountEmail: Text('Please Login'));
  }
}
