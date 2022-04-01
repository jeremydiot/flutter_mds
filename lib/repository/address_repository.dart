import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_digital_map/models/address.dart';

class AddressRepository{
  Future<List<dynamic>> fetchAddresses(String query) async {

    final Response response = await get(Uri.parse('http://api-adresse.data.gouv.fr/search?q=$query'));

    if(response.statusCode == 200) {
      List<dynamic> features = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if(json.containsKey("features")) {
        features = json['features'];
      }
      return features;
    } else {
      throw Exception('Failed to load addresses');
    }
  }
}