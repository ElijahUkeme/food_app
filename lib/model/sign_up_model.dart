class SignUpModel{
  String name;
  String email;
  String password;
  String phone;

  SignUpModel({required this.name, required this.email,
    required this.password,required this.phone});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data =  Map<String,dynamic>();
    data["name"] = this.name;
    data["email"] = this.email;
    data["password"] = this.password;
    data["phone"] = this.phone;

    return data;
  }
}