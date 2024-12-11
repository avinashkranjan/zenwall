import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zenwall/models/photos_model.dart';
import 'package:zenwall/view/image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((PhotosModel photoModel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgPath: photoModel.src!.portrait!,
                          )));
            },
            child: Hero(
              tag: photoModel.src!.portrait!,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: kIsWeb
                      ? Image.network(
                          photoModel.src!.portrait!,
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: photoModel.src!.portrait!,
                          placeholder: (context, url) => Container(
                                color: const Color(0xfff5f8fd),
                              ),
                          fit: BoxFit.cover)),
            ),
          ));
        }).toList()),
  );
}

Widget brandName() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Zen",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Wall",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}
