import 'dart:io';

import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final String imagePath;
  const ViewImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.file(
            File(imagePath),
          ),
        ),
      ),
    );
  }
}
