import 'package:json_parsing_demo/model/userDetails.dart';
class userInfo {
  List<userDetails> userlist;
  userInfo.jsonConvert(List<dynamic> list){
   if(list!=null){
    userlist = new List<userDetails>();
    list.forEach((v){
    userlist.add(userDetails.fromJson(v));
    });
   }
  }

  // userInfo.setData(userDetails userdetail){
  // userlist.set(userdetail);
  // }
}



// class userDetails{
//   String id;
//   String name;
//   String email;
//   String role;

//   userDetails.fromJson(Map<String, dynamic> json){
//     this.id = json['id'];
//     this.name = json['name'];
//     this.email = json['email'];
//     this.role = json['role'];
//   }
//   }
