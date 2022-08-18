import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:json_parsing_demo/model/userInfo.dart';

class MyHomePageProvider extends ChangeNotifier {
  userInfo  userinfo;

  Future getData(context) async {

  final response =
      await http.get('https://geektrust.s3-ap-southeast-1.amazonaws.com/adminui-problem/members.json');
      print("Response code is ${response.statusCode}");
  if (response.statusCode == 200) {
    var mJson = json.decode(response.body);
     List<dynamic> list = json.decode(response.body);
     userinfo = userInfo.jsonConvert(list);
     this.notifyListeners(); 
  } else {
    throw Exception('Unexpected error occured!');
   }
  }

  deleteItem(id){
    userinfo.userlist.removeWhere( (item) => item.id == id );
   // this.userinfo = userinfo;
    this.notifyListeners();
  }
}
