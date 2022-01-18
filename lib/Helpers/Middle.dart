import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {
  Widget textfav() {
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

  Widget dataFav(BuildContext context, String collection) {
    return Container(
      height: 300.0,
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
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 180.0,
                            child: Image.network(
                                snapshot.data[index].data()['image']),
                          ),
                          Positioned(
                              left: 140.0,
                              child: IconButton(
                                icon: Icon(EvaIcons.heart),
                                onPressed: () {},
                              ))
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            snapshot.data[index].data()['name'],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            snapshot.data[index].data()['category'],
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.cyan),
                          ),
                        ),
                      ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
