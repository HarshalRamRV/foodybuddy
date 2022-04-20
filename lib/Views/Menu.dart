// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fb_business/Services/AdminDetailsHelpers.dart';
import 'package:fb_business/widgets/ItemWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Menu",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.0,
            ),
            getcatpage(context, 'MainMenu')
          ],
        ),
      ),
    );
  }
}

Widget getcatpage(BuildContext context, String collection) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: FutureBuilder(
        future: Provider.of<AdminDetailsHelpers>(context, listen: false)
            .fetchMenuData(collection),
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
