import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zenwall/data/data.dart';
import 'package:zenwall/models/photos_model.dart';
import 'package:zenwall/widget/widget.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;

  const CategorieScreen({super.key, required this.categorie});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotosModel> photos = [];

  getCategorieWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=30&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: wallPaper(photos, context),
      ),
    );
  }
}
