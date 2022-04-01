import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_digital_map/blocs/address_cubit.dart';
import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/repository/repository.dart';
import 'package:provider/provider.dart';

class SearchAddress extends StatelessWidget {
  const SearchAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer? searchTimer;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechercher adresse'),
      ),
      body: Column(children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on),
              labelText: 'Adesse de l\'entreprise',
          ), onChanged: (String value) async{
            if(value.length < 4) {
              Provider.of<AddressCubit>(context, listen: false).clear();
              // setState(() {
              //   _addresses = [];
              // });
            }else{
              if(searchTimer != null){
                searchTimer?.cancel();
              }

              searchTimer = Timer(Duration(milliseconds: 500), () {
                Provider.of<AddressCubit>(context, listen: false).searchAddress(value);
                // Repository().searchAddresses(value).then((addresses){
                //   setState(() {
                //     _addresses = addresses;
                //   });
                // });
              });
            }
          },
        ),
        Expanded(
          child: BlocBuilder<AddressCubit, List<Address>>(
            builder: (context, state) {
              return ListView.separated(
                itemCount: state.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text('${state[index].toString()}'),
                    leading: Icon(Icons.location_on),
                    subtitle: Text('[${state[index].position.latitude};${state[index].position.longitude}]'),
                    onTap: (){
                      Navigator.of(context).pop(state[index]);
                      Provider.of<AddressCubit>(context, listen: false).clear();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider(height: 0);
                },
              );
            }),
          )
      ],),
    );
  }
}
