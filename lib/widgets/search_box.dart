import 'package:flutter/material.dart';
import 'package:zenwall/screens/search_view.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 194, 194, 194),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "Search Wallpapers",
                      border: InputBorder.none))),
          InkWell(
              onTap: () {
                if (searchController.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchView(
                                search: searchController.text,
                              )));
                }
              },
              child: const Icon(
                Icons.search,
                size: 20,
              ))
        ],
      ),
    );
  }
}
