import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/main.dart';
import 'package:camera_app/screens/camera_screen.dart';
import 'package:camera_app/screens/view_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({super.key, required this.cameras});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [];

  addImageToList(String imagePath) async {
    setState(() {
      imageList.add(imagePath);
    });
    capturedImageBox!.put(imagePath.split('/').last, imagePath);
  }

  void fetchCapturedImages() {
    imageList.clear();
    setState(() {
      imageList.addAll(capturedImageBox!.values.map((e) => e.toString()));
    });
  }

  @override
  void initState() {
    fetchCapturedImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: imageList.isEmpty
          ? const Center(
              child: Text(
                "Click on '+' button to click images",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                int itemCount = imageList.length;
                int reversedIndex = itemCount - 1 - index;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewImageScreen(
                          imagePath: imageList.elementAt(reversedIndex),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Gap(16),
                        Text(
                          imageList.elementAt(reversedIndex).split('/').last,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(
                                imageList.elementAt(reversedIndex),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (imageList.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraScreen(
                  cameras: widget.cameras,
                  onPress: (imagePath) {
                    addImageToList(imagePath);
                  },
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Camera not available!'),
            ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
