import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zenwall/data/data.dart';
import 'package:zenwall/models/categories_model.dart';
import 'package:zenwall/models/photos_model.dart';
import 'package:zenwall/widgets/brand_name.dart';
import 'package:zenwall/widgets/category_tile.dart';
import 'package:zenwall/widgets/search_box.dart';
import 'package:zenwall/widgets/wallpaper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  final ScrollController _scrollController = ScrollController();
  int noOfImageToLoad = 30;
  List<PhotosModel> photos = [];
  bool isLoading = false;

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreWallpapers();
      }
    });
  }

  Future<void> getTrendingWallpaper() async {
    setState(() {
      isLoading = true;
    });
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"]?.forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> loadMoreWallpapers() async {
    noOfImageToLoad += 30;
    await getTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: false,
            title: brandName(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBoxDelegate(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl!,
                        categorie: categories[index].categoriesName!,
                      );
                    },
                  ),
                ),
                Wallpaper(listPhotos: photos),
                const SizedBox(height: 24),
                if (isLoading)
                  const Center(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )),
                  ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      child: const SearchBox(),
    );
  }

  @override
  double get maxExtent => 60; // Height of the search box
  @override
  double get minExtent => 60; // Minimum height when scrolled
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
