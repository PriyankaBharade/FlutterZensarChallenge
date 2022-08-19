class userDetails{
   String id;
   String name;
   String email;
   String role;

  userDetails({
    this.id,
    this.name,
    this.email,
    this.role,
});

  userDetails.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.role = json['role'];
   }

userDetails copy({
    String id,
    String name,
    String email,
    String role,
  }) =>
      userDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
         role: role ?? this.role,
 );
}