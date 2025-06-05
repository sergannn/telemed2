import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentsGallery extends StatefulWidget {
  @override
  _DocumentsGalleryState createState() => _DocumentsGalleryState();
}

class _DocumentsGalleryState extends State<DocumentsGallery> {
  List<String> _imagePaths = [];
  Map<String, List<String>> _folderImages = {
    'Рецепты': [],
    'Обследования': [],
    'Выписки': [],
  };
  String _selectedFolder = 'Рецепты'; // Currently selected folder
  List<String> _folders = [
    'Документы',
    'Анкета',
    'Дневник'
  ]; // Стандартные папки
  final TextEditingController _folderNameController = TextEditingController();

  int? _selectedImageIndex;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _deleteImage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _folderImages[_selectedFolder]!.removeAt(index);
      prefs.setStringList(_selectedFolder, _folderImages[_selectedFolder]!);
      _selectedImageIndex = null; // Reset selection after deletion
    });
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load all folders
      _folders = prefs.getStringList('folders') ??
          ['Рецепты', 'Обследования', 'Выписки'];

      // Initialize folder images map
      _folderImages = {};
      for (var folder in _folders) {
        _folderImages[folder] = prefs.getStringList(folder) ?? [];
      }

      _selectedFolder = _folders.isNotEmpty ? _folders[0] : '';
    });
  }

  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('folders', _folders);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _saveImage(pickedFile.path);
    }
  }

  Future<void> _saveImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //  _imagePaths.add(imagePath);
//      prefs.setStringList('imagePaths', _imagePaths);
      _folderImages[_selectedFolder] ??= []; // <- Это ключевое исправление
      _folderImages[_selectedFolder]!.add(imagePath);
      prefs.setStringList(_selectedFolder, _folderImages[_selectedFolder]!);
    });
  }

  void _showAddFolderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Создать папку'),
          content: TextField(
            controller: _folderNameController,
            decoration: InputDecoration(hintText: 'Название папки'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (_folderNameController.text.isNotEmpty) {
                  setState(() {
                    _folders.add(_folderNameController.text);
                    _saveFolders();
                  });
                  _folderNameController.clear();
                  Navigator.pop(context);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Folder menu (unchanged)
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _folders.length + 1,
            itemBuilder: (context, index) {
              if (index == _folders.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: _showAddFolderDialog,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.add, color: Colors.blue),
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: InputChip(
                  label: Text(_folders[index]),
                  backgroundColor: _selectedFolder == _folders[index]
                      ? Colors.blue[100]
                      : null,
                  onDeleted: () {
                    setState(() {
                      _folders.removeAt(index);
                      _saveFolders();
                    });
                  },
                  onPressed: () {
                    setState(() {
                      _selectedFolder = _folders[index];
                    });
                  },
                ),
              );
            },
          ),
        ),
        // Gallery with refresh capability
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadData,
            child: GridView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              padding: EdgeInsets.all(16),
              itemCount: (_folderImages[_selectedFolder]?.length ?? 0) + 1,
//              itemCount: _folderImages[_selectedFolder]!.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return InkWell(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.add_a_photo, size: 40),
                    ),
                  );
                }
                final imageIndex = index - 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex =
                          _selectedImageIndex == imageIndex ? null : imageIndex;
                    });
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_folderImages[_selectedFolder]![imageIndex]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (_selectedImageIndex == imageIndex)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _deleteImage(imageIndex),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                      if (_selectedImageIndex == imageIndex)
                        Container(
                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.4),
                        )),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }
}
