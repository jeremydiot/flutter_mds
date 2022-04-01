import 'package:flutter/material.dart';
import 'package:my_digital_map/blocs/address_cubit.dart';
import 'package:my_digital_map/blocs/company_cubit.dart';
import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/repository/address_repository.dart';
import 'package:my_digital_map/repository/preferences_repository.dart';
import 'package:my_digital_map/repository/repository.dart';
import 'package:my_digital_map/ui/screens/add_company.dart';
import 'package:my_digital_map/ui/screens/home.dart';
import 'package:my_digital_map/ui/screens/search_address.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AddressRepository addressRepository = AddressRepository();
  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final Repository repository = Repository(addressRepository, preferencesRepository);

  final CompanyCubit companyCubit = CompanyCubit(repository);
  final AddressCubit addressCubit = AddressCubit(repository);
  await companyCubit.loadCompanies();

  runApp(
      MultiProvider(
        providers: [
          Provider<CompanyCubit>(create: (_) => companyCubit),
          Provider<AddressCubit>(create: (_) => addressCubit)
        ],
        child : MyApp(),
      )
  );
  
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/add' : (context) => AddCompany(),
        '/search_address' : (context) => SearchAddress(),
        '/home' : (context) => Home(),
      },
      home: const Home(),
    );
  }
}