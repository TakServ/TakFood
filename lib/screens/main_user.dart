import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/signout_process.dart';
import 'package:takfood/widget/show_list_shop_all.dart';
import 'package:takfood/widget/show_status_food_order.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;
  Widget currentWidget;

  @override
  void initState() {
    super.initState();
    currentWidget = ShowListShopAll();
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
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showHead(),
                menuListShop(),
                menuStatusFoodOrder(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                menuSignOut(),
              ],
            ),
          ],
        ),
      );

  ListTile menuListShop() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowListShopAll();
        });
      },
      leading: Icon(Icons.home),
      title: Text('แสดงร้านค้า'),
      subtitle: Text('แสดงร้านค้า ที่สามารถสั่งอาหารได้'),
    );
  }

  ListTile menuStatusFoodOrder() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowStatusFoodOrder();
        });
      },
      leading: Icon(Icons.restaurant_menu),
      title: Text('แสดงรายการอาหารที่สั่ง'),
      subtitle: Text('รายการอาหาร และสถานะของอาหาร ที่สั่ง'),
    );
  }

  Widget menuSignOut() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade700,
      ),
      child: ListTile(
        onTap: () => singOutProcess(context),
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        title: Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'ออกจากระบบ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('User.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        nameUser == null ? 'Name Login' : nameUser,
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
