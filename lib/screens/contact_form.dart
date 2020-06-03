import 'package:flutter/material.dart';
import 'package:webapiflutter/database/dao/contact_dao.dart';
import 'package:webapiflutter/model/contact.dart';

class ContactForm extends StatefulWidget {

  final ContactDao contactDao;

  ContactForm(this.contactDao);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

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
                      save(newContact, context);
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

  void save(Contact newContact, BuildContext context) async {
    await widget.contactDao.save(newContact);
    Navigator.pop(context);
  }
}
