import 'package:flutter/material.dart';

Widget brandName() {
  return const Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Zen",
            style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
          ),
          Text(
            "Wall",
            style: TextStyle(color: Colors.teal, fontFamily: 'Overpass'),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Powered by ",
            style: TextStyle(
                color: Colors.black54, fontSize: 10, fontFamily: 'Overpass'),
          ),
          Text(
            "Pexels",
            style: TextStyle(
                color: Colors.teal, fontSize: 10, fontFamily: 'Overpass'),
          ),
        ],
      ),
    ],
  );
}
