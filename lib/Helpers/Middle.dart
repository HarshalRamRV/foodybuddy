import 'package:flutter/material.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:foodybuddy/Views/Catogories.dart';
import 'package:foodybuddy/widgets/ItemWidget.dart';
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
                                  onTap: (){
                              Navigator.push(
                context,
                PageTransition(
                  child: Catogories(category: snapshot.data[index].data()['category'],),
                  type: PageTransitionType.fade,
                ));
                },
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

  Widget getdata(BuildContext context, String collection) {
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
                  return ItemWidget(
                        itemName: snapshot.data[index].data()['name'].toString(),
                        img: snapshot.data[index].data()['image'].toString(),
                        category: snapshot.data[index].data()['category'].toString(),
                        price: snapshot.data[index].data()['price'].toString(),
                      );
                },
              );
            }
          },
        ),
      ),
    );
  }

Widget getcatpage(BuildContext context, String collection, String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
          future: Provider.of<ManageData>(context, listen: false)
              .fetchCatData(collection,category),
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
                  return ItemWidget(
                        itemName: snapshot.data[index].data()['name'],
                        img: snapshot.data[index].data()['image'],
                        category: snapshot.data[index].data()['category'],
                        price: snapshot.data[index].data()['price'].toString(),
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
