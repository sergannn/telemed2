// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PopularPatientsScreen extends StatefulWidget {
  const PopularPatientsScreen({Key? key}) : super(key: key);

  @override
  _PopularPatientsScreenState createState() => _PopularPatientsScreenState();
}

class _PopularPatientsScreenState extends State<PopularPatientsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _patients = [];
  List<Map<String, dynamic>> _filteredPatients = [];
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _filterPatients(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPatients = _patients;
      } else {
        _filteredPatients = _patients.where((patient) {
          final fullName = (patient['full_name'] ?? '').toLowerCase();
          final firstName = (patient['first_name'] ?? '').toLowerCase();
          final searchLower = query.toLowerCase();
          return fullName.contains(searchLower) || firstName.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    print('Loading patients...');
    // Get current doctor ID from user data
    final currentUser = await Session.getCurrentUser();
    print('Current user: $currentUser');
    print('Doctor ID: ${currentUser?.doctorId}');
    
    if (currentUser != null && currentUser.doctorId != null) {
      bool success = await getPatientsForDoctor(doctorId: currentUser.doctorId!);
      print('getPatientsForDoctor success: $success');
      
      if (success) {
        // Get patients from doctors store (temporarily stored there)
        DoctorsStore storeDoctorsStore = GetIt.instance.get<DoctorsStore>();
        print('Doctors store has ${storeDoctorsStore.doctorsDataList.length} items');
        setState(() {
          _patients = List<Map<String, dynamic>>.from(storeDoctorsStore.doctorsDataList);
          _filteredPatients = _patients;
          _isLoading = false;
        });
        print('Loaded ${_patients.length} patients');
      } else {
        print('Failed to load patients');
        setState(() {
          _filteredPatients = [];
          _isLoading = false;
        });
      }
    } else {
      print('No current user or doctor ID');
      setState(() {
        _filteredPatients = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text:"Доступ к пациентам",context: context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
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
                          const Icon(Icons.search,
                              color: Color.fromARGB(255, 131, 131, 131),
                              size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onTapOutside: (_) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              controller: _searchController,
                              onChanged: _filterPatients,
                              decoration: const InputDecoration(
                                hintText: 'Найти пациента',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 131, 131, 131),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
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
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      Text(
                                        'Мои пациенты',
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
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : _patients.isEmpty
                                ? Center(
                                    child: Text(
                                      'У вас пока нет пациентов',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                : PatientsSilder(patients: _filteredPatients),
                      ],
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

class PatientsSilder extends StatelessWidget {
  final List<Map<String, dynamic>> patients;

  const PatientsSilder({
    Key? key,
    required this.patients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: patients.map((patient) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 247, 247).withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: patient['profile_image'] != null && patient['profile_image'].isNotEmpty
                    ? NetworkImage(patient['profile_image'])
                    : AssetImage('assets/images/default_patient.png') as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient['full_name'] ?? 'Неизвестный пациент',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient['first_name'] != null && patient['first_name'].isNotEmpty
                          ? 'Имя: ${patient['first_name']}'
                          : 'Информация о пациенте',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Colors.blue),
                onPressed: () {
                  // TODO: Implement chat functionality
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
