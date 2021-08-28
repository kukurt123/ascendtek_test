import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget circleAvatarAssetImage() {
  return Container(
    margin: EdgeInsets.all(2.0),
    width: 65,
    height: 65,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 2),
          blurRadius: 6.0,
        ),
      ],
      border: Border.all(width: 2, color: Colors.white),
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(''),
      ),
    ),
  );
}
