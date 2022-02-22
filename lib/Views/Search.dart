import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2.0,
                            blurRadius: 5.0),
                      ]),
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: SizedBox(
                                child: Image.network(
                                  (snapshotData.docs[index]['image']),
                                  width: 125.0,
                                  height: 125.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 215.0,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8.0, 8.0, 8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              (snapshotData.docs[index]
                                                  ['name']),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ])))
                            ])
                      ])));
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
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.dark),
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
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
          backgroundColor: Colors.white,
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
