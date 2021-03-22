import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takfood/model/cart_model.dart';
import 'package:takfood/model/user_model.dart';
import 'package:takfood/utility/my_constant.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/normal_dialog.dart';
import 'package:takfood/utility/sqlite_helper.dart';
import 'package:toast/toast.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  int total;
  bool status = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    total = 0;
    var object = await SQLiteHelper().readAllDataFromSQLite();
    if (object.length != 0) {
      for (var model in object) {
        //String sumString = model.sum;
        //int sumInt = int.parse(sumString);
        int sumInt = int.parse(model.sum);
        setState(() {
          status = false;
          cartModels = object;
          total = total + sumInt;
        });
      }
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: status
          ? Center(
              child: Text('ตะกร้า ว่างเปล่าว'),
            )
          : buildContent(),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildNameShop(),
            buildHeadTitle(),
            buildListFood(),
            Divider(),
            buildTotal(),
            buildClearCart(),
            buildOrderCart(),
          ],
        ),
      ),
    );
  }

  Widget buildClearCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150,
          child: RaisedButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: MyStyle().primaryColor,
            onPressed: () {
              confirmDeleteAll();
            },
            icon: Icon(
              Icons.delete_outlined,
              color: Colors.white,
            ),
            label: Text(
              'Clear All',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOrderCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150,
          child: RaisedButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: MyStyle().darkColor,
            onPressed: () {
              orderThread();
            },
            icon: Icon(
              Icons.fastfood,
              color: Colors.white,
            ),
            label: Text(
              'Order',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTotal() => Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyStyle().showTitleH2('Total : '),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH3Red(total.toString()),
          ),
        ],
      );

  Widget buildNameShop() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              MyStyle().showTitleH2('ร้าน ${cartModels[0].nameShop}'),
            ],
          ),
          Row(
            children: [
              MyStyle()
                  .showTitleH3('ระยะทาง = ${cartModels[0].distance} กิโลเมตร'),
            ],
          ),
          Row(
            children: [
              MyStyle()
                  .showTitleH3('ค่าขนส่ง = ${cartModels[0].transport} บาท'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeadTitle() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: MyStyle().showTitleH3('รายการอาหาร'),
          ),
          Expanded(flex: 1, child: MyStyle().showTitleH3('ราคา')),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH3('จำนวน'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH3('ผลรวม'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH3('ยกเลิก'),
          ),
        ],
      ),
    );
  }

  Widget buildListFood() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cartModels.length,
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(cartModels[index].nameFood),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(cartModels[index].price),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].amount),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].sum),
            ),
            Expanded(
                child: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                int id = cartModels[index].id;
                await SQLiteHelper().deleteDataWhereID(id).then((value) {
                  // print('You Delete id =$id');
                  readSQLite();
                });
              },
            )),
          ],
        ),
      );

  Future<Null> confirmDeleteAll() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('ต้องการลบรายการ ทั้งหมด ?'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: MyStyle().primaryColor,
                onPressed: () async {
                  Navigator.pop(context);
                  await SQLiteHelper()
                      .deleteAllData()
                      .then((value) => readSQLite());
                },
                icon: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                label: Text(
                  'ยีนยัน',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: MyStyle().primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                label: Text(
                  'ยกเลิก',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> orderThread() async {
    DateTime dateTime = DateTime.now();
    String orderDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    String idShop = cartModels[0].idShop;
    String nameShop = cartModels[0].nameShop;
    String distance = cartModels[0].distance;
    String transport = cartModels[0].transport;

    List<String> idFoods = List();
    List<String> nameFoods = List();
    List<String> prices = List();
    List<String> amounts = List();
    List<String> sums = List();

    for (var model in cartModels) {
      idFoods.add(model.idFood);
      nameFoods.add(model.nameFood);
      prices.add(model.price);
      amounts.add(model.amount);
      sums.add(model.sum);
    }

    String idFood = idFoods.toString();
    String nameFood = nameFoods.toString();
    String price = prices.toString();
    String amount = amounts.toString();
    String sum = sums.toString();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');
    String nameUser = preferences.getString('name');

    //print('$idUser  : $nameUser');
    String url =
        '${MyConstant().domain}/takfood/addOrder.php?isAdd=true&OrderDateTime=$orderDateTime&idUser=$idUser&nameUser=$nameUser&idShop=$idShop&NameShop=$nameShop&Distance=$distance&Transport=$transport&idFood=$idFood&NameFood=$nameFood&Price=$price&Amount=$amount&Sum=$sum&idRider=none&Status=UserOrder';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        clearAllSQLite();
        notificationToShop(idShop);
      } else {
        normalDialog(context, 'ไม่สามารถ Order ได้  กรุณาลองใหม่');
      }
    });
  }

  Future<Null> clearAllSQLite() async {
    Toast.show('Order เรียบร้อยแล้วครับ', context, duration: Toast.LENGTH_LONG);
    await SQLiteHelper().deleteAllData().then((value) {
      readSQLite();
    });
  }

  Future<Null> notificationToShop(String idShop) async {
    String urlFindToken =
        '${MyConstant().domain}/TakFood/getUserWhereId.php?isAdd=true&id=$idShop';
    await Dio().get(urlFindToken).then((value) {
      var result = json.decode(value.data);
      for (var json in result) {
        UserModel model = UserModel.fromJson(json);
        String tokenShop = model.token;

        String title = 'มี Order จากลูกค้า';
        String body = 'มีการสั่งอาหาร จากลูกค้าครับ!..';
        String urlSendToken =
            '${MyConstant().domain}/TakFood/apiNotification.php?isAdd=true&token=$tokenShop&title=$title&body=$body';

        sendNotificationToShop(urlSendToken);
      }
    });
  }

  Future<Null> sendNotificationToShop(String urlSendToken) async {
    await Dio().get(urlSendToken).then(
          (value) => Toast.show('ส่ง Order ไปที่ร้านค้าแล้วครับ...', context,
              duration: Toast.LENGTH_LONG),
        );
  }
}