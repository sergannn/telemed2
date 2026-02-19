import 'dart:io';

import 'package:doctorq/screens/medcard/full_screen_image_viewer.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentsGallery extends StatefulWidget {
  @override
  _DocumentsGalleryState createState() => _DocumentsGalleryState();
}

class _DocumentsGalleryState extends State<DocumentsGallery> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    var paths = prefs.getStringList('imagePaths') ?? [];
    var validPaths = paths
        .where((p) => p.toString().trim().isNotEmpty && File(p).existsSync())
        .toList();
    if (validPaths.length != paths.length) {
      await prefs.setStringList('imagePaths', validPaths);
    }
    _imagePaths = validPaths;
    if (mounted) setState(() {});
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      _saveImage(imagePath);
    }
  }

  Future<void> _saveImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    _imagePaths.add(imagePath);
    await prefs.setStringList('imagePaths', _imagePaths);
    if (mounted) setState(() {});
  }

  Future<void> _deleteImage(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить документ?'),
        content: Text('Удалить «Документ ${index + 1}»?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    final prefs = await SharedPreferences.getInstance();
    _imagePaths.removeAt(index);
    await prefs.setStringList('imagePaths', _imagePaths);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      padding: EdgeInsets.all(16),
      itemCount: _imagePaths.length + 1,
      itemBuilder: (context, index) {
        final imageIndex = index - 1;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              index == 0
                  ? CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(Icons.add),
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_imagePaths[imageIndex]),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey[600]),
                                      SizedBox(height: 4),
                                      Text('Файл недоступен', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => openFullScreenImageViewer(context, _imagePaths[imageIndex]),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.search, color: Colors.white, size: 28),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _deleteImage(imageIndex),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.delete, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 8),
              Text(
                index == 0 ? 'Добавить' : 'Документ ${index + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getFontSize(14),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
