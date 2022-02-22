import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:foodybuddy/Views/Detailedpage.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {
  Widget textCat() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(
        text: 'Catogories',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
      )),
    );
  }

  Widget textPopular() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(
        text: 'Popular Items',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
      )),
    );
  }

  Widget dataCat(BuildContext context, String collection) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Container(
        height: 222.0,
        child: FutureBuilder(
          future: Provider.of<ManageData>(context, listen: false)
              .fetchData(collection),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/foodanimation.json'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 5,
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 5.0),
                              child: Text(
                                snapshot.data[index].data()['category'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Stack(children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                margin: new EdgeInsets.all(0),
                                child: SizedBox(
                                  height: 180.0,
                                  child: Image.network(
                                    snapshot.data[index].data()['image'],
                                    width: 300.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ])
                          ]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget dataCartTest(BuildContext context, String collection) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 270.0, minHeight: 100.0),
        child: FutureBuilder(
          future: Provider.of<ManageData>(context, listen: false)
              .fetchData(collection),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/foodanimation.json'),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: SizedBox(
                                  child: Image.network(
                                    snapshot.data[index].data()['image'],
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].data()['name'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].data()['category'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.rupeeSign,
                                            size: 14.0,
                                          ),
                                          Text(
                                            snapshot.data[index]
                                                .data()['price']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 65.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffF06623),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 2.0,
                                          blurRadius: 5.0),
                                    ]),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: DetailedScreen(
                                                queryDocumentSnapshot:
                                                    snapshot.data[index]),
                                            type: PageTransitionType.fade));
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget dataPopular(BuildContext context, String collection) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 1000.0, minHeight: 660.0),
        child: FutureBuilder(
          future: Provider.of<ManageData>(context, listen: false)
              .fetchData(collection),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/foodanimation.json'),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: DetailedScreen(
                                  queryDocumentSnapshot: snapshot.data[index]),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: SizedBox(
                                  child: Image.network(
                                    snapshot.data[index].data()['image'],
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].data()['name'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].data()['category'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.rupeeSign,
                                            size: 14.0,
                                          ),
                                          Text(
                                            snapshot.data[index]
                                                .data()['price']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
