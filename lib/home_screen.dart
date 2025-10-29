import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test1/detail_screen.dart';
import 'package:test1/form_screen.dart';
import 'package:test1/contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];

  void addContact(Contact contact) {
    setState(() {
      contacts.add(contact);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Thêm contact thành công"),
      backgroundColor: Colors.green,
    ));
  }

  void editContact(int index, Contact updatedContact) {
    setState(() {
      contacts[index] = updatedContact;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Sửa contact thành công"),
      backgroundColor: Colors.green,
    ));
  }

  void deleteContact(int index) async {
    final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirm Diaglog Delete"),
              content: Text("Bạn chắc chắn muốn xóa chứ!"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("cancel")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ));
    if (confirm == true) {
      setState(() {
        contacts.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Xóa contact thành công"),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacs"),
      ),
      body: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.contacts,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Chưa có contact, nhấn + để thêm contact"),
                ],
              ),
            )
          : ListView.separated(
              itemCount: contacts.length,
              itemBuilder: (context, idx) {
                final c = contacts[idx];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(c.name),
                      const SizedBox(
                        width: 10,
                      ),
                      c.email != null
                          ? Text(c.email.toString())
                          : const Text("Điền để thấy email hiện lên")
                    ],
                  ),
                  subtitle: Text(c.phone),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailScreen(contact: c))),
                  onLongPress: () async {
                    final result = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 200, 0, 0),
                        items: [
                          const PopupMenuItem(
                            value: "edit",
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: "delete",
                            child: Text("Delete"),
                          )
                        ]);
                    if (result == "edit") {
                      final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FormScreen(contact: c)));
                      if (updated != null) editContact(idx, updated);
                    } else if (result == "delete") {
                      deleteContact(idx);
                    }
                  },
                );
              },
              separatorBuilder: (_, idx) => Divider(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newContact = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const FormScreen()));
          if (newContact != null) addContact(newContact);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
