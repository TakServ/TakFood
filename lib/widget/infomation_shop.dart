import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takfood/model/user_model.dart';
import 'package:takfood/screens/add_info_shop.dart';
import 'package:takfood/screens/edit_info_shop.dart';
import 'package:takfood/utility/my_constant.dart';
import 'package:takfood/utility/my_style.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url =
        '${MyConstant().domain}/TakFood/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      print('result = $result');
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
      }
    });
  }

  void routToAddInfo() {

    Widget widget = userModel.nameShop.isEmpty ? AddInfoShop() : EditInfoShop();

    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute).then((value) => readDataUser());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        userModel == null
            ? MyStyle().showProgress()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : showListInfoShop(),
        addAndEditButton(),
      ],
    );
  }

  Widget showListInfoShop() => Column(
        children: <Widget>[
          MyStyle().showTitleH2('รายละเอียดร้าน ${userModel.nameShop}'),
          showImage(),
          Row(
            children: [
              MyStyle().showTitleH2('ที่อยู่ของร้าน'),
            ],
          ),
          Row(
            children: [
              Text(userModel.address),
            ],
          ),
          MyStyle().mySizeBox(),
          showMap(),
        ],
      );

  Container showImage() {
    return Container(width: 200.0,height: 200.0,
          child: Image.network('${MyConstant().domain}${userModel.urlPicture}'),
        );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('shopID'),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
        infoWindow: InfoWindow(
            title: 'ตำแหน่งร้าน',
            snippet: 'ละติจูด =${userModel.lat}, ลองติจูด =${userModel.lng}'),
      )
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Expanded(
      //padding: EdgeInsets.all(10.0),
      //height: 300.0,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) {
    return MyStyle()
        .titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วย คะ');
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
