import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String section;
  const AppBarTitle({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/note_icon.jpg", height: 25,),
        SizedBox(width: 10,),
        Text(
          'AnyNote',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 25,
          ),
        ),
        SizedBox(width: 15,),
        Text(
          '$section',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
