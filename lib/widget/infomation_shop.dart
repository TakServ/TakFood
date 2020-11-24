import 'package:flutter/material.dart';
import 'package:takfood/screens/add_info_shop.dart';
import 'package:takfood/utility/my_style.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  void routToAddInfo() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => AddInfoShop(),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[addAndEditButton(),
        MyStyle()
            .titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วย คะ'),
      ],
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
              ),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  routToAddInfo();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
