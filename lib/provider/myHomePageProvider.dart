import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:json_parsing_demo/model/userInfo.dart';
import 'package:json_parsing_demo/model/userDetails.dart';
import 'package:json_parsing_demo/pages/EditDialogWidget.dart';

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
    this.notifyListeners();
  }

  Future editName(userDetails editUser,BuildContext context) async {
    final name = await showTextDialog(
      context,
      title: 'Change First Name',
      value: editUser.name,
    );
    userinfo.userlist.map((user){
      final isEditedUser = user == editUser;
      if(isEditedUser){
      int index = userinfo.userlist.indexWhere((element) => element == user);
      user = user.copy(name: name);
      userinfo.userlist[index] = user;
      this.notifyListeners();
      }
    }).toList();
  }

  Future editEmail(userDetails editUser,BuildContext context) async {
    final email = await showTextDialog(
      context,
      title: 'Change Email Id',
      value: editUser.email,
    );
    userinfo.userlist.map((user){
      final isEditedUser = user == editUser;
      if(isEditedUser){
      int index = userinfo.userlist.indexWhere((element) => element == user);
      user = user.copy(email: email);
      userinfo.userlist[index] = user;
      this.notifyListeners();
      }
    }).toList();
  }
}
