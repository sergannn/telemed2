import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  final SearchController _searchController = SearchController();
  List<dynamic> _allDoctors = [
    'Доктор Иванов (Терапевт)',
    'Доктор Петрова (Кардиолог)',
    'Доктор Сидоров (Невролог)',
    'Доктор Смирнова (Педиатр)',
    'Доктор Кузнецов (Хирург)',
    'Доктор Васильева (Офтальмолог)',
    'Доктор Николаев (Ортопед)',
    'Доктор Павлова (Гинеколог)',
    'Доктор Фёдоров (Уролог)',
    'Доктор Козлова (Дерматолог)',
  ];
  List<dynamic> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _allDoctors = context.doctorsData;
    _filteredDoctors = [];
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    print(_searchController.text);
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDoctors = _allDoctors;
      } else {
        _filteredDoctors = _allDoctors.where((doctor) {
          print(doctor);
          // Check specializations
          final specializations = doctor['specializations'] as List?;
          final nameMatch =
              doctor['username']?.toString().toLowerCase().contains(query) ??
                  false;
          final specMatch = specializations?.any((spec) =>
                  spec['name']?.toString().toLowerCase().contains(query) ??
                  false) ??
              false;

          return nameMatch || specMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text: "Поиск врача", context: context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  // Поисковая строка
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SearchAnchor(
                      searchController: _searchController,
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              _onSearchChanged();
                            },
                            leading: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                            trailing: [
                              IconButton(
                                icon: const Icon(Icons.mic,
                                    color: Color.fromARGB(255, 131, 131, 131)),
                                onPressed: () {},
                              ),
                            ],
                            hintText: 'Найти врача...',
                            hintStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 131, 131, 131),
                              ),
                            ));
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        //    return _filteredDoctors.map((doctor) {
                        return List.generate(_filteredDoctors.length, (index) {
                          final doctor = _filteredDoctors[index];
                          return DoctorItem(
                            item: doctor,
                            index: index,
                          );
                          return ListTile(
                            title: Text(doctor['username']),
                            onTap: () {
                              print("tap");
                              controller.closeView(doctor['username']);
                              setState(() {
                                _searchController.text = doctor['username'];
                              });
                            },
                          );
                        }).toList();
                      },
                    ),
                  ),

                  // Результаты поиска
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredDoctors.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(_filteredDoctors[index]['username']),
                            onTap: () {
                              // Действие при выборе врача
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
