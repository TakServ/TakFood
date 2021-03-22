import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/normal_dialog.dart';
import 'package:takfood/utility/signout_process.dart';
import 'package:takfood/widget/infomation_shop.dart';
import 'package:takfood/widget/list_food_menu_shop.dart';
import 'package:takfood/widget/order_list_shop.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  // Field
  Widget currentWidget = OrderListShop();

  @override
  void initState() {
    super.initState();
    aboutNotification();
  }

  Future<Null> aboutNotification() async {
    if (Platform.isAndroid) {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      await firebaseMessaging.configure(
        onLaunch: (message) async {},
        onResume: (message) async {
          // เปิดหน้าจอ Home หรือ ปิดหน้าจอ
          //print('Noti onResume ${message.toString()}');
          String title = message['data']['title'];
          String body = message['data']['body'];
          normalDialog2(context, title, body);
        },
        onMessage: (message) async {
          // เปิดหน้าจอ app อยู่
          //print('Noti onMessage ${message.toString()}');
          String title = message['notification']['title'];
          String notiMessage = message['notification']['body'];
          normalDialog2(context, title, notiMessage);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => singOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            infomationMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการที่ ลูกค้าสั่ง'),
        subtitle: Text('รายการอาหาร ที่ยังไม่ได้ส่งลูกค้า'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการ อาหาร'),
        subtitle: Text('รายการอาหาร ของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
      leading: Icon(Icons.info),
      title: Text('รายละเอียด ของร้าน'),
      subtitle: Text('รายละเอียด ของร้าน/แก้ไข'),
      onTap: () {
        setState(() {
          currentWidget = InfomationShop();
        });
        Navigator.pop(context);
      });

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('ออกจาก ระบบ'),
        onTap: () => singOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('Shop.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name Shop'),
      accountEmail: Text('Email Shop'),
    );
  }
}
