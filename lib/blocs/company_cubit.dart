import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_digital_map/models/company.dart';
import 'package:my_digital_map/repository/repository.dart';

class CompanyCubit extends Cubit<List<Company>> {

  final Repository _repository;

  CompanyCubit(this._repository) : super([]);

  void addCompany(Company company){
    emit([...state, company]);
    _repository.saveCompanies(state);
  }

  Future<void> loadCompanies() async{
    final List<Company> companies = await _repository.loadCompanies();
    emit(companies);
  }
}