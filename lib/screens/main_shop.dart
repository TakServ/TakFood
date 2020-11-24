import 'package:flutter/material.dart';
import 'package:takfood/utility/my_style.dart';
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
