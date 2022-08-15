class userDetails{
  String id;
  String name;
  String email;
  String role;

  userDetails.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.role = json['role'];
   }
  }