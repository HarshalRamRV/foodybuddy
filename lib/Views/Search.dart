import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  late bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.clear, color: Colors.white),
        onPressed: () {},
      ),
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.orange),
          decoration: InputDecoration(
              hintText: 'Search Courses',
              hintStyle: TextStyle(color: Colors.orange)),
          controller: searchController,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
