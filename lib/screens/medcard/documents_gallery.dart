import 'dart:io';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/medcard/full_screen_image_viewer.dart';
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
    _folderImages[_selectedFolder]!.removeAt(index);
    await prefs.setStringList(_selectedFolder, _folderImages[_selectedFolder]!);
    if (mounted) {
      setState(() {
        _selectedImageIndex = null;
      });
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _folders = prefs.getStringList('folders') ??
        ['Рецепты', 'Обследования', 'Выписки'];

    _folderImages = {};
    for (var folder in _folders) {
      var paths = prefs.getStringList(folder) ?? [];
      // Убираем пустые и несуществующие пути (битые/временные файлы) — из-за них были «белые» документы
      var validPaths = paths
          .where((p) => p.toString().trim().isNotEmpty && File(p).existsSync())
          .toList();
      if (validPaths.length != paths.length) {
        await prefs.setStringList(folder, validPaths);
      }
      _folderImages[folder] = validPaths;
    }
    _selectedFolder = _folders.isNotEmpty ? _folders[0] : '';
    if (mounted) setState(() {});
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
            onTapOutside: (_) { print("tap outside");
              FocusManager.instance.primaryFocus?.unfocus();
            },
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
                final imagePath = _folderImages[_selectedFolder]![imageIndex];
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
                          File(imagePath),
                          fit: BoxFit.cover,
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
                          onTap: () => openFullScreenImageViewer(context, imagePath),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.search, color: Colors.white, size: 28),
                          ),
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
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
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
