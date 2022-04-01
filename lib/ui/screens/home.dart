import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_digital_map/blocs/company_cubit.dart';
import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/models/company.dart';
import 'package:my_digital_map/repository/preferences_repository.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.of(context).pushNamed('/add') as Company?;
      },child: Icon(Icons.add),),
      appBar: AppBar(
          title: Text('MyDigitalMap')
      ),
      body:BlocBuilder<CompanyCubit, List<Company>>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title:Text(state[index].name),
                leading: Icon(Icons.business),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text(state[index].address.toString()),
              );
            },separatorBuilder: (BuildContext context, int index){
            return const Divider(height: 0);
          },
          );
        }),
      );
  }
}
