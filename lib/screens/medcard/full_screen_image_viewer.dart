import 'dart:io';

import 'package:flutter/material.dart';

/// Полноэкранный просмотр изображения с зумом (pinch-to-zoom).
void openFullScreenImageViewer(BuildContext context, String imagePath) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (ctx) => FullScreenImageViewer(imagePath: imagePath),
    ),
  );
}

class FullScreenImageViewer extends StatelessWidget {
  final String imagePath;

  const FullScreenImageViewer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
