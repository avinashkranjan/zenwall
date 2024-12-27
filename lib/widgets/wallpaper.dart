import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zenwall/models/photos_model.dart';
import 'package:zenwall/screens/image_view.dart';

class Wallpaper extends StatelessWidget {
  final List<PhotosModel> listPhotos;
  const Wallpaper({super.key, required this.listPhotos});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kIsWeb ? 4 : 2,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
          childAspectRatio: kIsWeb ? 1.5 : 0.6,
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: listPhotos.length,
        itemBuilder: (context, index) {
          final photoModel = listPhotos[index];

          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageView(
                      imgPath: photoModel.src!.portrait!,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: photoModel.src!.portrait!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return kIsWeb
                          ? Image.network(
                              photoModel.src!.portrait!,
                              width: constraints.maxWidth,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: photoModel.src!.portrait!,
                              placeholder: (context, url) => Container(
                                color: const Color(0xfff5f8fd),
                              ),
                              fit: BoxFit.cover,
                            );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
