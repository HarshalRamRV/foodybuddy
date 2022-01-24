import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:foodybuddy/Services/ManageDataSearch.dart';
import 'package:foodybuddy/Views/Detailedpage.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: DetailedScreen(
                          queryDocumentSnapshot: snapshotData.docs[index]),
                      type: PageTransitionType.fade));
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshotData.docs[index]['image']),
              ),
              title: Text(
                snapshotData.docs[index]['name'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
          },
        ),
        backgroundColor: Color(0xfcfcfcfc),
        appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExcecuted = true;
                        });
                      });
                    });
              },
            )
          ],
          title: TextField(
            style: TextStyle(color: Colors.orange),
            decoration: InputDecoration(
                hintText: 'Search Courses',
                hintStyle: TextStyle(color: Colors.orange)),
            controller: searchController,
          ),
          backgroundColor: Colors.black,
        ),
        body: isExcecuted
            ? searchedData()
            : Container(
                child: Center(
                  child: Text(
                    'Search any food',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ));
  }
}
