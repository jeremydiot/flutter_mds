import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/models/company.dart';
import 'package:my_digital_map/repository/preferences_repository.dart';

import 'address_repository.dart';

class Repository{

  final PreferencesRepository _preferencesRepository;
  final AddressRepository _addressRepository;

  Repository(this._addressRepository, this._preferencesRepository);

  Future<void> saveCompanies(List<Company> companies) async {
    _preferencesRepository.saveCompanies(companies);
  }

  Future<List<Company>> loadCompanies() async => _preferencesRepository.loadCompanies();

  Future<List<Address>> searchAddresses(String query) async{
    List<Address> addresses = [];
    List<dynamic> apiResponse =  await AddressRepository().fetchAddresses(query);

    apiResponse.forEach((element) {
      addresses.add(Address.fromGeoJson(element));
    });

    return addresses;
  }
}