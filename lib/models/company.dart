import 'dart:convert';

import 'package:my_digital_map/models/address.dart';

class Company {
  int id;
  String name;
  Address address;

  Company(this.id, this.name, this.address);

  String toJson(){
    return jsonEncode({
      'id': id,
      'name' : name,
      'address': address.toJson()
    });
  }

  factory Company.fromJson(String json){
    Map<String, dynamic> map = jsonDecode(json);
    return Company(
        map['id'],
        map['name'],
        Address.fromJson(map['address']),
    );
  }
}