import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final title;
  final VoidCallback onPressed;
  final maxwidth;
  final minwidth;
  RoundedButton({@required this.title, required this.onPressed, required this.maxwidth,required this.minwidth});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(double.parse("$minwidth") , 50)),
            maximumSize: MaterialStateProperty.all(Size(double.parse("$maxwidth"), 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF06623)),
            // padding: MaterialStateProperty.all(
            //     EdgeInsets.symmetric(horizontal: 150.0, vertical: 15.0)),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}