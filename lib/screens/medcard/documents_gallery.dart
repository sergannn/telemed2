import 'dart:io';

import 'package:doctorq/screens/medcard/card_gallery.dart';
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
    setState(() {
      _imagePaths = prefs.getStringList('imagePaths') ?? [];
    });
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
    setState(() {
      _imagePaths.add(imagePath);
      prefs.setStringList('imagePaths', _imagePaths);
    });
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
                      //radius: 150,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(Icons.add),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_imagePaths[imageIndex]),
                        fit: BoxFit.cover,
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
