import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test1/contact.dart';

class FormScreen extends StatefulWidget {
  final Contact? contact;
  const FormScreen({Key? key, this.contact}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact?.name ?? "");
    phoneController = TextEditingController(text: widget.contact?.phone ?? "");
    emailController = TextEditingController(text: widget.contact?.email ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? "add contact" : "edit contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
              validator: (value) => value!.isEmpty ? "Yêu cầu" : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                  labelText: "Phone", border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) return "Vui lòng nhập phone";
                if (!RegExp(r'^[0-9]+$').hasMatch(value))
                  return "Vui lòng nhập đúng địn dạng phone";
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newContact = Contact(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text.isEmpty
                            ? null
                            : emailController.text);
                    Navigator.pop(context, newContact);
                  }
                },
                child: const Text("Save"))
          ]),
        ),
      ),
    );
  }
}
