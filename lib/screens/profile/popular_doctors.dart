// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

class PopularDoctorsScreen extends StatefulWidget {
  const PopularDoctorsScreen({Key? key}) : super(key: key);
  
  @override
  State<PopularDoctorsScreen> createState() => _PopularDoctorsScreenState();
}

class _PopularDoctorsScreenState extends State<PopularDoctorsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _doctors = [];
  List<Map<String, dynamic>> _filteredDoctors = [];
  TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }
  
  Future<void> _loadDoctors() async {
    print("DEBUG: Loading doctors in PopularDoctorsScreen");
    
    try {
      // Очищаем локальные данные
      setState(() {
        _doctors = [];
        _filteredDoctors = [];
        _isLoading = true;
      });
      
      bool success = await getDoctors();
      print("DEBUG: getDoctors() result: $success");
      
      if (success) {
        // Get doctors from store
        DoctorsStore storeDoctorsStore = GetIt.instance.get<DoctorsStore>();
        print("DEBUG: Doctors store has ${storeDoctorsStore.doctorsDataList.length} items");
        
        setState(() {
          _doctors = List<Map<String, dynamic>>.from(storeDoctorsStore.doctorsDataList);
          _filteredDoctors = List<Map<String, dynamic>>.from(_doctors);
          _isLoading = false;
        });
        print("DEBUG: Loaded ${_doctors.length} doctors");
        print("DEBUG: First doctor: ${_doctors.isNotEmpty ? _doctors[0]['username'] : 'No doctors'}");
      } else {
        print("DEBUG: Failed to load doctors");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("DEBUG: Error loading doctors: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredDoctors = List<Map<String, dynamic>>.from(_doctors);
      } else {
        _filteredDoctors = _doctors.where((doctor) {
          String lastName = doctor['last_name']?.toString().toLowerCase() ?? '';
          String firstName = doctor['first_name']?.toString().toLowerCase() ?? '';
          String username = doctor['username']?.toString().toLowerCase() ?? '';
          String searchQuery = query.toLowerCase();
          
          return lastName.contains(searchQuery) || 
                 firstName.contains(searchQuery) || 
                 username.contains(searchQuery);
        }).toList();
      }
    });
    print("DEBUG: Filtered doctors count: ${_filteredDoctors.length}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 15),
          ...topBack(text: "Популярные", context: context),
          Expanded( 
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration( 
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: RefreshIndicator(
                onRefresh: _loadDoctors,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search,
                                color: Color.fromARGB(255, 131, 131, 131),
                                size: 24),
                            onPressed: () {}, // Поиск уже работает через TextField
                          ),
                          Expanded(
                            child: TextField(
                              onTapOutside: (_) { print("tap outside");
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              controller: _searchController,
                              onChanged: _filterDoctors,
                              decoration: const InputDecoration(
                                hintText: 'Найти врача',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 131, 131, 131),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic,
                                color: Color.fromARGB(255, 131, 131, 131),
                                size: 22),
                            onPressed: () {}, //обработчик нажатия
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      Text(
                                        'Популярные врачи',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DoctorsSilder20(doctors: _filteredDoctors),
                        /*
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Акушер-гинеколог',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Анколог',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Бактериолог',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    */
                      ],
                    ),
                  ),
                ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsSilder20 extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;

  const DoctorsSilder20({
    Key? key,
    required this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("DEBUG: DoctorsSilder20 - doctors count: ${doctors.length}");
    print("DEBUG: DoctorsSilder20 - doctors data: $doctors");
    
    if (doctors.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Загрузка врачей...",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    
    // Показываем информацию о каждом враче
    for (int i = 0; i < doctors.length; i++) {
      print("DEBUG: Doctor $i: ${doctors[i]['username'] ?? 'No name'}");
    }
    
    return Column(
        children: List.generate(doctors.length, (index) {
      return DoctorItem(
        item: doctors[index],
        index: index,
      );
    }));
  }
}
