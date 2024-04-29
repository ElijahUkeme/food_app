class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPerson;
  late String? _contactPersonNumber;
  late String _address;

  AddressModel(
      {id,
      required addressType,
      contactPerson,
      contactPersonNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPerson = contactPerson;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
  }
  String get address => _address;
  String get addressType => _addressType;
  String? get contactPerson => _contactPerson;
  String? get contactPersonNumber => _contactPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _addressType = json["addressType"] ?? "";
    _contactPerson = json["contactPerson"] ?? "";
    _contactPersonNumber = json["contactPersonNumber"] ?? "";
    _address = json["address"];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['addressType'] = addressType;
    data['contactPerson'] = contactPerson;
    data['contactPersonNumber'] = contactPersonNumber;
    data['address'] = address;

    return data;
  }
}
