import 'dart:convert';

import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

class Address{
  String street;
  String city;
  String postcode;
  LatLng position;

  Address(this.street, this.city, this.postcode, this.position);

  @override
  String toString() {
    // TODO: implement toString
    return '${this.street}, ${this.postcode} ${this.city}';
  }
  factory Address.fromGeoJson(Map<String, dynamic> json){

    Map<String, dynamic> properties = json['properties'] ?? {};
    Map<String, dynamic> geometry = json['geometry'] ?? {};

    String street = properties['name']?? "" ;
    String city = properties['city']?? "";
    String postcode = properties['postcode']?? "";

    LatLng position = LatLng(geometry['coordinates'][1] ?? 0,geometry['coordinates'][0] ?? 0);

    return Address(street, city, postcode, position);
  }

  String toJson(){
    return jsonEncode({
      'street': street,
      'city' : city,
      'postcode': postcode,
      'latitude': position.latitude,
      'longitude':position.longitude
    });
  }

  factory Address.fromJson(String json){
    Map<String, dynamic> map = jsonDecode(json);
    return Address(
        map['street'],
        map['city'],
        map['postcode'],
        LatLng(map['latitude'], map['longitude'])
    );
  }

}