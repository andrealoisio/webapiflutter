import 'package:flutter/material.dart';
import 'package:persistenciaflutter/components/progress.dart';
import 'package:persistenciaflutter/database/dao/contact_dao.dart';
import 'package:persistenciaflutter/model/contact.dart';
import 'package:persistenciaflutter/screens/contact_form.dart';
import 'package:persistenciaflutter/screens/transaction_form.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _contactDao = ContactDao();
  @override
  Widget build(BuildContext context) {
    // contacts.add(Contact(0, 'André', 1234));
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _contactDao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TransactionForm(contact)));
                      debugPrint('Cliquei no contato');
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm()))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  const _ContactItem(this._contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(
          _contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
