import 'package:flutter/material.dart';
import 'package:persistenciaflutter/database/dao/contact_dao.dart';
import 'package:persistenciaflutter/model/contact.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
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
                      _contactDao.save(newContact).then((id) {
                        Navigator.pop(context);
                      });
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
}
