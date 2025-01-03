// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class ImageView extends StatefulWidget {
  final String imgPath;

  const ImageView({super.key, required this.imgPath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  late Stream<String> progressString;
  late String res;
  bool downloading = false;

  int nextImageID = 0;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: downloading
          ? imageDownloadDialog()
          : Stack(
              children: <Widget>[
                Hero(
                  tag: widget.imgPath,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: kIsWeb
                        ? Image.network(widget.imgPath, fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl: widget.imgPath,
                            placeholder: (context, url) => Container(
                              color: const Color(0xfff5f8fd),
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            if (kIsWeb) {
                              _launchUrl(widget.imgPath);
                            } else {
                              _save(context);
                            }
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight)),
                                child: const Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 30,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _save(context) async {
    try {
      await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Set Wallpaper",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Platform.isAndroid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                var width = MediaQuery.of(context).size.width;
                                var height = MediaQuery.of(context).size.height;
                                await downloadImage(context, widget.imgPath);
                                home = await Wallpaper.homeScreen(
                                    options: RequestSizeOptions.resizeFit,
                                    width: width,
                                    location:
                                        DownloadLocation.applicationDirectory,
                                    height: height);
                                setState(() {
                                  downloading = false;
                                  home = home;
                                });
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons.home),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Home"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await downloadImage(context, widget.imgPath);
                                lock = await Wallpaper.lockScreen(
                                  location:
                                      DownloadLocation.applicationDirectory,
                                );
                                setState(() {
                                  downloading = false;
                                  lock = lock;
                                });
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons.lock_open_rounded),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Lock Screen"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await downloadImage(context, widget.imgPath);
                                both = await Wallpaper.bothScreen(
                                  location:
                                      DownloadLocation.applicationDirectory,
                                );
                                setState(() {
                                  downloading = false;
                                  both = both;
                                });
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons
                                      .system_security_update_good_outlined),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Both"),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await saveImageFromUrl(context, widget.imgPath);
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons
                                      .system_security_update_good_outlined),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Download"),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              ),
            );
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Storage permission is required to save the image"),
        ),
      );
    }
  }

  Future<void> downloadImage(BuildContext context, String imgPath) async {
    progressString = Wallpaper.imageDownloadProgress(imgPath);
    progressString.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
    }, onDone: () async {
      setState(() {
        downloading = false;
      });
    }, onError: (error) {
      setState(() {
        downloading = false;
      });
    });
  }

  Future<void> saveImageFromUrl(BuildContext context, String imageUrl) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          Uint8List imageData = response.bodyBytes;

          final result = await ImageGallerySaver.saveImage(
            imageData,
            quality: 100,
            name: "downloaded_image",
          );
          Navigator.of(context).pop();
          if (result['isSuccess']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Download complete! Image saved to gallery.'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to save the image.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Failed to download image. HTTP Status: ${response.statusCode}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission denied. Unable to save image.'),
        ),
      );
    }
  }

  Widget imageDownloadDialog() {
    return SizedBox(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
