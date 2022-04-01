import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/repository/repository.dart';

class AddressCubit extends Cubit<List<Address>>{
  final Repository _repository;
  AddressCubit(this._repository): super([]);

  void clear(){
    emit([]);
  }
  
  Future<void> searchAddress(String query) async{
    final List<Address> address = await _repository.searchAddresses(query);
    emit(address);
  }
}