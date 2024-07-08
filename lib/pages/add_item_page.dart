import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class add_item_page extends StatefulWidget {
  const add_item_page({super.key});

  @override
  State<add_item_page> createState() => _add_item_pageState();
}

class _add_item_pageState extends State<add_item_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add_item"),
      ),
    );
  }
}
