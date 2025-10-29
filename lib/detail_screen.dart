import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test1/contact.dart';

class DetailScreen extends StatelessWidget {
  final Contact contact;
  const DetailScreen({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name:${contact.name}",style: TextStyle(fontSize: 18),),
            const SizedBox(height: 8,),
            Text("Phone: ${contact.phone}",style: TextStyle(fontSize: 18),),
            const SizedBox(height: 8,),
            Text("Email: ${contact.email ?? "-"}",style: TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
