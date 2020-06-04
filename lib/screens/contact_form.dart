import 'package:flutter/material.dart';
import 'package:webapiflutter/database/dao/contact_dao.dart';
import 'package:webapiflutter/model/contact.dart';
import 'package:webapiflutter/widgets/app_dependencies.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                  ),
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: 'Account number',
                  ),
                  style: TextStyle(fontSize: 24.0),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      final String name = _nameController.text;
                      final int accountNumber = int.tryParse(_accountNumberController.text);
                      final newContact = Contact(0, name, accountNumber);
                      save(dependencies.contactDao, newContact, context);
                    },
                    child: Text('Create'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void save(ContactDao contactDao, Contact newContact, BuildContext context) async {
    await contactDao.save(newContact);
    Navigator.pop(context);
  }
}
