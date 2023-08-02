class CustomerModel{
  int id;
  String name;
  String email;
  String phone;

  CustomerModel({required this.id,required this.name, required this.email, required this.phone});

  factory CustomerModel.fromJson(Map<String, dynamic>json){
    return CustomerModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"]);
  }
}