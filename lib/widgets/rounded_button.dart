import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final title;
  final VoidCallback onPressed;
  RoundedButton({@required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(400, 50)),
            maximumSize: MaterialStateProperty.all(Size(1000, 50)),
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

// RaisedButton(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         onPressed: onPressed,
//         child: Text(
//           title,
//           style: Theme.of(context)
//               .textTheme
//               .headline6
//               ?.copyWith(color: Colors.white, fontSize: 14),
//         ),
//         color: Theme.of(context).primaryColor,
//         splashColor: Colors.green,
//       ),