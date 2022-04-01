import 'package:my_digital_map/models/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository{
  Future<void> saveCompanies(List<Company> companies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("companies", companies.map((company)=>company.toJson()).toList());
    // toMap
  }

  Future<List<Company>> loadCompanies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> companiesPrefs =  prefs.getStringList("companies") ?? [];

    return companiesPrefs.map((company) => Company.fromJson(company)).toList();
    // fromJson
  }
}