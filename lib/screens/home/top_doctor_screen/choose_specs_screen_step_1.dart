import 'package:doctorq/screens/home/top_doctor_screen/top_doctor_screen_step_2.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:get_it/get_it.dart';

class ChooseSpecsScreen extends StatefulWidget {
  const ChooseSpecsScreen({Key? key,}) : super(key: key);

  @override
  State<ChooseSpecsScreen> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<ChooseSpecsScreen> {
  List<Map<String, dynamic>> _patientsOnTreatment = [];
  List<Map<String, dynamic>> _filteredPatients = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatientsFromUpcomingAppointments();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadPatientsFromUpcomingAppointments() {
    try {
      final AppointmentsStore store = GetIt.instance.get<AppointmentsStore>();
      final List<Map<dynamic, dynamic>> appointments = store.appointmentsDataList;
      
      final DateTime today = DateTime.now();
      final DateTime todayStart = DateTime(today.year, today.month, today.day);
      
      // Собираем уникальных пациентов из upcoming appointments
      final Map<String, Map<String, dynamic>> uniquePatients = {};
      
      for (var appointment in appointments) {
        // Проверяем дату - берем только upcoming (сегодня или позже)
        final String dateStr = appointment['date']?.toString() ?? '';
        if (dateStr.isEmpty) continue;
        
        try {
         // final DateTime appointmentDate = DateTime.parse(dateStr);
         // if (appointmentDate.isBefore(todayStart)) continue; // Пропускаем прошедшие
          
          // Извлекаем данные пациента
          final patient = appointment['patient'];
          if (patient == null) continue;
          
          String? patientId;
          String? fullName;
          String? firstName;
          String? photo;
          
          if (patient is Map) {
            // Пробуем разные варианты структуры данных
            patientId = patient['user_id']?.toString() ?? 
                        patient['id']?.toString() ??
                        patient['patientUser']?['id']?.toString();
            fullName = patient['full_name']?.toString() ?? 
                       patient['username']?.toString() ??
                       patient['patientUser']?['full_name']?.toString();
            firstName = patient['first_name']?.toString() ??
                        patient['patientUser']?['first_name']?.toString();
            photo = patient['profile_image']?.toString() ?? 
                    patient['photo']?.toString() ??
                    patient['patientUser']?['profile_image']?.toString();
          }
          
          if (patientId != null && patientId.isNotEmpty && patientId != 'null') {
            // Добавляем или обновляем пациента
            if (!uniquePatients.containsKey(patientId)) {
              uniquePatients[patientId] = {
                'id': patientId,
                'full_name': fullName ?? firstName ?? 'Пациент',
                'first_name': firstName ?? '',
                'photo': photo ?? '',
                'next_appointment': dateStr,
              };
            }
          }
        } catch (e) {
          print('Error parsing appointment date: $e');
        }
      }
      
      setState(() {
        _patientsOnTreatment = uniquePatients.values.toList();
        _filteredPatients = _patientsOnTreatment;
        _isLoading = false;
      });
      
      print('Loaded ${_patientsOnTreatment.length} patients from upcoming appointments');
    } catch (e) {
      print('Error loading patients: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterPatients(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPatients = _patientsOnTreatment;
      } else {
        _filteredPatients = _patientsOnTreatment.where((patient) {
          final fullName = (patient['full_name'] ?? '').toLowerCase();
          final firstName = (patient['first_name'] ?? '').toLowerCase();
          return fullName.contains(query.toLowerCase()) || 
                 firstName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...topBack(text: "Записи", context: context),

            VerticalSpace(height: 24),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: _filterPatients,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  hintText: 'Поиск пациента...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            VerticalSpace(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Пациенты на лечении (${_filteredPatients.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPatientsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientsList() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_filteredPatients.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Нет пациентов с предстоящими записями',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    
    return SizedBox(
      child: ListView.builder(
        padding: getPadding(
          left: 20,
          top: 10,
          right: 20,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _filteredPatients.length,
        itemBuilder: (context, index) {
          final patient = _filteredPatients[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseSpecScreen2()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar section
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.width / 8,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: patient['photo'] != null && patient['photo'].isNotEmpty
                          ? Image.network(
                              patient['photo'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.blue[100],
                                  child: Icon(Icons.person, color: Colors.blue),
                                );
                              },
                            )
                          : Container(
                              color: Colors.blue[100],
                              child: Icon(Icons.person, color: Colors.blue),
                            ),
                    ),
                  ),

                  // Content section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient['full_name'] ?? 'Пациент',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(16),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (patient['next_appointment'] != null)
                          Text(
                            'прием: ${_formatDate(patient['next_appointment'])}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Arrow section
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: ColorConstant.blueA400,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
