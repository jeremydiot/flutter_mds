import 'package:flutter/material.dart';
import 'package:my_digital_map/blocs/company_cubit.dart';
import 'package:my_digital_map/models/address.dart';
import 'package:my_digital_map/models/company.dart';
import 'package:provider/provider.dart';

class AddCompany extends StatelessWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textFieldController = TextEditingController();
    final _addressFieldController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    Address? _address;

    return Scaffold(
      appBar: AppBar( title: Text('Ajouter entreprise'),),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.business),
                  labelText: 'Nom de l\'entreprise',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: _textFieldController,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Le nom de doit pas être vide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Adresse de l\'entreprise',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: _addressFieldController,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Le nom de doit pas être vide';
                  }
                  return null;
                },
                onTap: () async {
                    Address? address = await Navigator.of(context).pushNamed('/search_address') as Address?;
                  if(address != null){
                    _address = address;
                    _addressFieldController.text = '${address.toString()}';
                  }
                },
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate() && _address != null) {
                      Company company = Company(0,_textFieldController.text,_address!);
                      // Navigator.of(context).pop(company);
                      Provider.of<CompanyCubit>(context, listen: false).addCompany(company);
                      Navigator.of(context).pop();
                    }
                },
                  child: Text('Valider')
              )
            ],
          ),
        ),
      ),
    );
  }
}
