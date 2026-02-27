import 'dart:convert';
//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/date_picker_timeline-1.2.6/lib/date_picker_widget.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_tasks.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_zapisi.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';
import 'package:doctorq/screens/home/home_screen/widgets/recommendation_item_widget.dart';
import 'package:doctorq/screens/home/home_screen/widgets/story_item_widget.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/webviews/someWebPage.dart';
import 'package:doctorq/screens/profile/main_notification.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:doctorq/screens/profile/popular_doctors.dart';
import 'package:doctorq/screens/profile/search_doctors.dart';
import 'package:doctorq/screens/profile/settings/appearance_screen/appearance_screen.dart';
import 'package:doctorq/screens/profile/high_pressure.dart';
import 'package:doctorq/screens/stories/story_scren.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:story_view/story_view.dart";
import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/specialist_doctor_screen/specialist_doctor_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/services/api_service.dart' hide getIt;
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/autolayouthor1_item_widget.dart';
import 'widgets/autolayouthor_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:doctorq/models/recommendation_model.dart';
//import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:flutter_animate/flutter_animate.dart';
//final GlobalKey<RandomTextRevealState> globalKey = GlobalKey();

class ItemController extends GetxController {
  var cats = [].obs; // Reactive list to store fetched items
  var users = [].obs; // Reactive list to store fetched items
  var articles = [].obs;
  var recommendations = <RecommendationModel>[].obs; // Reactive list for recommendations
  var filteredRecords = <CalendarRecordData>[].obs;

  DateTime _selectedDate = DateTime.now();

  void filterRecordsByDate(DateTime date) {
    _selectedDate = date;
    debugPrint('>>> DELETE filterRecordsByDate: date=$date, _calendarRecords.length=${_calendarRecords.length}');
    final list = _calendarRecords.where((record) {
      return record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day;
    }).toList();
    debugPrint('>>> DELETE filterRecordsByDate: list.length=${list.length} for date');
    filteredRecords.assignAll(list);
    if (filteredRecords.isEmpty) {
      filteredRecords.add(CalendarRecordData(
          date: date,
          title: kEmptyDayPlaceholderTitle,
          category: "Пусто"));
      filteredRecords.add(CalendarRecordData(
          date: date,
          title: kEmptyDayPlaceholderTitle,
          category: "Пусто2"));
      filteredRecords.add(CalendarRecordData(
          date: date,
          title: kEmptyDayPlaceholderTitle,
          category: "Пусто3"));
    }
    debugPrint('>>> DELETE filterRecordsByDate: filteredRecords.length=${filteredRecords.length} after assign');
    filteredRecords.refresh();
    update();
  }

  var _calendarRecords = <CalendarRecordData>[].obs;

  Future<void> _saveCalendarRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsString = jsonEncode(_calendarRecords.map((r) => r.toJson()).toList());
    await prefs.setString('calendar_records', recordsString);
  }

  /// После добавления/редактирования: при обновлении удаляем старую запись, затем всегда добавляем текущую (новую или изменённую).
  Future<void> addOrUpdateRecordFromCreate(CalendarRecordData record, {CalendarRecordData? oldRecord}) async {
    if (oldRecord != null) {
      final before = _calendarRecords.length;
      _calendarRecords.removeWhere((r) => identical(r, oldRecord));
      if (_calendarRecords.length == before) {
        _calendarRecords.removeWhere((r) =>
            r.date.compareWithoutTime(oldRecord.date) == 0 &&
            r.title == oldRecord.title &&
            (r.category ?? '') == (oldRecord.category ?? ''));
      }
    }
    _calendarRecords.add(record);
    _calendarRecords.refresh();
    await _saveCalendarRecords();
    filterRecordsByDate(_selectedDate);
  }

  /// Удалить запись (по долгому нажатию). Приёмы не удаляются (isAppointmentCategory из create_record_page_lib).
  Future<void> deleteRecord(CalendarRecordData record) async {
    debugPrint('>>> DELETE deleteRecord CALLED: "${record.title}" date=${record.date} category=${record.category}');
    if (isAppointmentCategory(record.category)) {
      debugPrint('>>> DELETE deleteRecord: SKIP (appointment)');
      return;
    }
    final beforeCount = _calendarRecords.length;
    // Сначала по ссылке (item из filteredRecords — тот же объект из _calendarRecords)
    int removed = _calendarRecords.where((r) => identical(r, record)).length;
    if (removed > 0) {
      _calendarRecords.removeWhere((r) => identical(r, record));
    } else {
      _calendarRecords.removeWhere((r) =>
          !isAppointmentCategory(r.category) &&
          r.date.compareWithoutTime(record.date) == 0 &&
          r.title == record.title &&
          (r.category ?? '') == (record.category ?? ''));
    }
    final afterCount = _calendarRecords.length;
    debugPrint('>>> DELETE deleteRecord: _calendarRecords $beforeCount -> $afterCount (removed ${beforeCount - afterCount}, byRef=$removed)');
    _calendarRecords.refresh();
    await _saveCalendarRecords();
    debugPrint('>>> DELETE deleteRecord: calling filterRecordsByDate($_selectedDate)');
    filterRecordsByDate(_selectedDate);
    debugPrint('>>> DELETE deleteRecord: DONE filteredRecords.length=${filteredRecords.length}');
    filteredRecords.refresh();
    update();
  }
  
  // Геттер для доступа к записям календаря
  List<CalendarRecordData> get calendarRecords => _calendarRecords;

  /// Перезагрузить записи из дневника и обновить список по текущей дате (после возврата из дневника).
  Future<void> refreshCalendarAndFilter() async {
    await Future.delayed(const Duration(milliseconds: 150));
    await _loadCalendarRecords();
    filterRecordsByDate(_selectedDate);
  }

  final storyItems = <StoryItem>[].obs;
  @override
  void onInit() {
    super.onInit();
    refreshData();
    _loadCalendarRecords().then((_) {
      filterRecordsByDate(DateTime.now());
    });
  }

  Future<void> _loadCalendarRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsString = prefs.getString('calendar_records');
    
    // Загружаем записи из дневника
    List<CalendarRecordData> diaryRecords = [];
    if (recordsString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(recordsString);
        diaryRecords = jsonList.map((item) => CalendarRecordData.fromJson(item)).toList();
      } catch (e) {
        print('Error decoding calendar records: $e');
      }
    }
    
    // Загружаем предстоящие сеансы
    final appointmentRecords = await _loadAppointmentsToCalendar();
    
    // Объединяем записи дневника и предстоящих сеансов
    _calendarRecords.assignAll([
      ...diaryRecords,
      ...appointmentRecords,
    ]);
    _calendarRecords.refresh();

    // Initialize with today's records (при вызове из refreshCalendarAndFilter фильтр по _selectedDate сделает вызывающий код)
    filterRecordsByDate(DateTime.now());
  }

  Future<List<CalendarRecordData>> _loadAppointmentsToCalendar() async {
    final appointmentRecords = <CalendarRecordData>[];
    try {
      // Получаем предстоящие сеансы из store
      AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();
      List<Map<String, dynamic>> appointments = storeAppointmentsStore.appointmentsDataList.cast<Map<String, dynamic>>();
      
      print("DEBUG: Loading ${appointments.length} appointments to calendar");

      final currentUser = await Session.getCurrentUser();
      final bool isDoctor = currentUser?.doctorId != null;
      
      for (var appointment in appointments) {
        try {
          // Парсим дату сеанса
          String dateStr = appointment['date'] ?? '';
          String fromTime = appointment['from_time'] ?? '';
          
          if (dateStr.isNotEmpty) {
            DateTime appointmentDate = DateTime.parse(dateStr);
            
            // Показываем время как пришло с бэкенда (уже 24h)
            String timeStr = fromTime;

            final counterpartName = _extractCounterpartName(appointment, isDoctor);
            final contactLabel = _mapContactMethodToLabel(appointment['description']);
            
            // Создаем запись для календаря
            CalendarRecordData appointmentRecord = CalendarRecordData(
              date: appointmentDate,
              title: '${timeStr} - $counterpartName - $contactLabel',
              category: 'Приемы',
              description: 'ID: ${appointment['id']?.toString() ?? 'N/A'}',
            );
            
            appointmentRecords.add(appointmentRecord);
            print("DEBUG: Added appointment to calendar: ${appointmentRecord.title} on ${appointmentDate.toString()}");
          }
        } catch (e) {
          print("DEBUG: Error processing appointment: $e");
        }
      }
    } catch (e) {
      print("DEBUG: Error loading appointments to calendar: $e");
    }
    return appointmentRecords;
  }

  String _extractCounterpartName(Map<String, dynamic> appointment, bool isDoctor) {
    if (isDoctor) {
      final patient = appointment['patient'];
      if (patient is Map) {
        return patient['first_name'] ?? patient['username'] ?? patient['last_name'] ?? 'Пациент';
      }
      return 'Пациент';
    } else {
      final doctor = appointment['doctor'];
      if (doctor is Map) {
        return doctor['first_name'] ??
            doctor['username'] ??
            doctor['last_name'] ??
            (doctor['doctorUser'] is Map
                ? doctor['doctorUser']['first_name'] ?? doctor['doctorUser']['username']
                : null) ??
            'Врач';
      }
      return 'Врач';
    }
  }

  String _mapContactMethodToLabel(dynamic description) {
    switch (description) {
      case 'ContactMethods.voiceCall':
        return 'Аудио';
      case 'ContactMethods.videoCall':
        return 'Видео';
      case 'ContactMethods.message':
        return 'Чат';
      default:
        return 'Прием';
    }
  }

  Future<void> fetchArticles() async {
    print('fetching articles');
    var response = await http.get(Uri.parse(
      'https://admin.onlinedoctor.su/api/articles',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      // items = jsonResponse;
      articles.value = jsonResponse;
//      jsonResponse.map((item) => SpecialistModel.fromJson(item)).toList();
    }
  }

  Future<void> fetchStories() async {
    final response =
        await http.get(Uri.parse('https://admin.onlinedoctor.su/api/stories'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('https://admin.onlinedoctor.su/storage/' +
          jsonData['data'][0]['image']);
      // Extract data from JSON
      final data = (jsonData['data'] as List<dynamic>)
          .map((e) => StoryItem.inlineImage(
                imageFit: BoxFit.cover,
                url: 'https://admin.onlinedoctor.su/storage/' + e['image'],
                controller: StoryController(),
                caption: Text(
                  e['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ))
          .toList();
      //print(data);
      //storyItems.value = data;
      storyItems.value = data;
    } else {
      // Handle error
      print('Failed to load stories');
    }
  }


  Future<void> fetchRecommendations() async {
    // Загружаем статьи вместо рекомендаций
    final response = await http.get(Uri.parse('https://admin.onlinedoctor.su/api/articles'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'] ?? [];
      
      // Перемешиваем статьи случайным образом
      data.shuffle();
      
      // Преобразуем статьи в RecommendationModel для совместимости
      recommendations.value = data.take(10).map((item) {
        return RecommendationModel(
          id: item['id'] as int? ?? 0,
          title: item['title'] as String? ?? '',
          description: item['description'] as String?,
          image: item['image'] as String? ?? '',
          html: item['html'] as String?,
          category_id: item['category_id'] as int?,
        );
      }).toList();
      print('Loaded ${recommendations.length} random articles');
    } else {
      // Handle error
      print('Failed to load articles: ${response.statusCode}');
    }
  }

  Future<void> refreshData() async {
    // fetchDoctors();
    fetchStories();
    fetchArticles();
    fetchRecommendations();
    getDoctors();
    
    final currentUser = await Session.getCurrentUser();
    if (currentUser != null) {
      if (currentUser.doctorId != null) {
        await getAppointmentsD(doctorId: currentUser.doctorId.toString());
      } else if (currentUser.patientId != null) {
        await getAppointments(patientId: currentUser.patientId.toString());
      }
    }

    _loadCalendarRecords().then((res) {
      filterRecordsByDate(DateTime.now());
    });
    // Simulating fetching data from an API
    var response = await http.get(Uri.parse(
      '$kApiDomain/api/specializations',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      // items = jsonResponse;
      cats.value = jsonResponse;
//      jsonResponse.map((item) => SpecialistModel.fromJson(item)).toList();
    }
  }
}
//проверить разницу
class ItemControllerDoctorOld extends GetxController {
  var cats = [].obs; // Reactive list to store fetched items
  var users = [].obs; // Reactive list to store fetched items
  var articles = [].obs;
  final storyItems = <StoryItem>[].obs;
  @override
  void onInit() {
    super.onInit();
    refreshData();
    fetchStories();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    print('fetching articles');
    var response = await http.get(Uri.parse(
      'https://admin.onlinedoctor.su/api/articles',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      // items = jsonResponse;
      articles.value = jsonResponse;
//      jsonResponse.map((item) => SpecialistModel.fromJson(item)).toList();
    }
  }

  Future<void> fetchStories() async {
    final response =
        await http.get(Uri.parse('https://admin.onlinedoctor.su/api/stories'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('https://admin.onlinedoctor.su/storage/' +
          jsonData['data'][0]['image']);
      // Extract data from JSON
      final data = (jsonData['data'] as List<dynamic>)
          .map((e) => StoryItem.inlineImage(
                imageFit: BoxFit.cover,
                url: 'https://admin.onlinedoctor.su/storage/' + e['image'],
                controller: StoryController(),
                caption: Text(
                  e['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ))
          .toList();
      //print(data);
      //storyItems.value = data;
      storyItems.value = data;
    } else {
      // Handle error
      print('Failed to load stories');
    }
  }

  Future<void> refreshData() async {
    // fetchDoctors();
    fetchStories();
    fetchArticles();
    getDoctors();
    // Simulating fetching data from an API
    var response = await http.get(Uri.parse(
      '$kApiDomain/api/specializations',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      // items = jsonResponse;
      cats.value = jsonResponse;
//      jsonResponse.map((item) => SpecialistModel.fromJson(item)).toList();
    }
  }
}

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController autoLayoutVerController = TextEditingController();
  final ItemController itemController = Get.put(ItemController());
  File? _image;

  Future<void> pickImage() async {
    var pr = await SharedPreferences.getInstance();
    print(pr.getString('user_id'));
    print(pr.getString('photo'));
    print("prefs");
    var status = await Permission.photos.request().isGranted;
    await Permission.mediaLibrary.request().isGranted;

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(pickedFile);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      if (_image != null) {
        bool success = await updateProfileWithImage(
          context,
          pickedFile.path,
          context.userData['first_name'],
          context.userData['email'],
        );

        if (success) {
          // После успешного обновления, перезагружаем данные пользователя
          final updatedUser = await Session.getCurrentUser();
          if (updatedUser != null) {
            // Обновляем контекст с новыми данными пользователя
            context.userData['photo'] = updatedUser.photo;
            setState(() {
              // Принудительно обновляем UI
            });
          }
        }
      }
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
//      backgroundColor: Colors.white,
      extendBody: true,
      // floatingActionButton: const FloatingActionButton( heroTag: "b", onPressed: null, child: Text("uId")),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 20,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 4,
                        bottom: 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: CircleAvatar(
                              radius: getVerticalSize(25),
                              backgroundImage:
                                  NetworkImage(context.userData['photo']),
                            ),
                          ),

                          HorizontalSpace(width: 20),

                          //child: FittedBox(
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainProfileScreen()),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: context.userData['first_name'] +
                                      ' ' +
                                      context.userData['last_name'] +
                                      '\n',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '3 близких' +
                                          // context.userData['patient_id'] +
                                          "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainNotificationsScreen()),
                            );
                          },
                          child: Container(
                              padding: getPadding(all: 10),
                              height: getVerticalSize(44),
                              width: getHorizontalSize(44),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors
                                    .white, //ColorConstant.blueA400.withOpacity(0.1),
                              ),
                              child: Icon(Icons.notifications)),
                        ),
                        //  HorizontalSpace(width: 16),
                        /*InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeFavoriteDoctorScreen()),
                            );
                          },
                          child: Container(
                            padding: getPadding(all: 10),
                            height: getVerticalSize(44),
                            width: getHorizontalSize(44),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorConstant.blueA400.withOpacity(0.1),
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.favorite,
                            ),
                          ),
                        ),*/
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: RefreshIndicator(
              displacement: 1.0,
              onRefresh: () async {
                await itemController.refreshData();
                //       await itemController.fetchStories();
                //       await itemController.fetchArticles();
                await Future.delayed(
                    const Duration(seconds: 2)); // Simulate network request
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: getPadding(
                    top: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // VerticalSpace(height: 5),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(
                                left: 20,
                                //top: 30,
                                right: 20,
                              ),
                              child: SingleChildScrollView(
                                  child: Container(
                                      //color: Colors.red,
                                      child: DatePicker(
                                //activeDates: [],
                                //inactiveDates: _generateInactiveDates(),
                                DateTime.now(),

                                deactivatedColor: Colors.grey,

                                initialSelectedDate: DateTime.now(),
                                selectionColor: ColorConstant.fromHex("81AEEA"),
                                height: 66,
                                dateTextStyle: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    color: ColorConstant.blueA400,
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 23),
                                dayTextStyle: TextStyle(
                                    // fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Source Sans Pro',
                                    color: ColorConstant.blueA400),
                                monthTextStyle: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  color: ColorConstant.blueA400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                selectedTextColor: Colors.white,
                                onDateChange: (date) {
                                  print("home tap $date");
                                  itemController.filterRecordsByDate(date);
                                },
                              ))))),

                      Obx(() {
                        return FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          onFinish: (direction) =>
                              printLog('Direction $direction'),
                          child: SizedBox(
                            height: getVerticalSize(
                              160.00,
                            ),
                            width: getHorizontalSize(
                              528.00,
                            ),
                            //  child: NotificationListener<ScrollNotification>(

                            child: ListView.separated(
                              key: ValueKey('tasks_${itemController.filteredRecords.length}'),
                              padding: getPadding(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemCount: itemController.filteredRecords.length,
                              separatorBuilder: (context, index) {
                                return HorizontalSpace(width: 16);
                              },
                              itemBuilder: (context, index) {
                                return AutolayouthorItemWidgetTasks(
                                  item: itemController.filteredRecords[index],
                                  index: index,
                                  onRecordSaved: (record, {oldRecord}) =>
                                      itemController.addOrUpdateRecordFromCreate(record, oldRecord: oldRecord),
                                  onRecordDelete: (record) =>
                                      itemController.deleteRecord(record),
                                  onReturnFromDiary: () => itemController.refreshCalendarAndFilter(),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      //  Frame2087326464(),

                      CustomSearchView(
                        isDark: isDark,
                        width: size.width,
                        focusNode: FocusNode(),
                        readOnly: true,
                        onTap: () {
                             Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularPatientsScreen()),
//                                  TopDoctorScreen()),
                                        ); /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      //  const HomeSearchDoctorScreen()
                                      //    HistoryVideoCallPage()
                                      SearchPatientScreen()));*/
                        },
                        controller: autoLayoutVerController,
                        hintText: "Найти пациента",
                        margin: getMargin(left: 24, right: 24, top: 20),
                        alignment: Alignment.center,
                        suffix: Padding(
                            padding: EdgeInsets.only(
                                right: getHorizontalSize(
                                  15.00,
                                ),
                                left: getHorizontalSize(15)),
                            child: CommonImageView(
                              imagePath: ImageConstant.search,
                            )),
                        suffixConstraints: BoxConstraints(
                          maxWidth: getHorizontalSize(
                            50.00,
                          ),
                          maxHeight: getVerticalSize(
                            50.00,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 20,
                            top: 15,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Доступ к пациентам",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: isDark
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.bluegray800,
                                  fontSize: getFontSize(
                                    15,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                                  .animate()
                                  .fade(delay: Duration(milliseconds: 200))
                                  .scale(),
                            ],
                          ),
                        ),
                      ),
                      
                      Obx(() {
                        print(itemController.storyItems.length);
                        return FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          onFinish: (direction) =>
                              printLog('Direction $direction'),
                          child: SizedBox(
                            height: getVerticalSize(
                              230.00,
                            ),
                            width: getHorizontalSize(
                              528.00,
                            ),
                            //  child: NotificationListener<ScrollNotification>(

                            child: ListView.separated(
                              padding: getPadding(
                                left: 20,
                                right: 20,
                                top: 17,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemCount: itemController.cats.length,
                              separatorBuilder: (context, index) {
                                return HorizontalSpace(width: 16);
                              },
                              itemBuilder: (context, index) {
                                if (index > 1) return Container();
                                var cats = itemController.cats;
                                //return Text("a");
                                return GestureDetector(
                                    onTap: () async {
                                      print("tap tap");
                                      if (index == 0) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularPatientsScreen()),
//                                  TopDoctorScreen()),
                                        );
                                      }
                                      // Handle double tap action
                                      if (index == 1) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(builder: (context) {
                                            return ChooseSpecsScreen();
                                          }),
//                                  TopDoctorScreen()),
                                        );
                                        print('Image double tapped');
                                      }
                                    },
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutolayouthorItemWidgetZapisi(
                                            item: cats[index],
                                            index: index,
                                          ),
                                          Text(
                                            index == 0
                                                ? "Мои пациенты"
                                                : "Пациенты на лечении",
                                            style: TextStyle(
                                              fontSize:
                                                  12.0, // размер в пикселях
                                            ),
                                          )
                                        ]));
                              },
                            ),
                          ),
                        );
                      }),
                    //  Text('123'),
                      //SingleChildScrollView(child: NewsSlider()),
/*
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 20,
                            top: 30,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Избранное",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: isDark
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.bluegray800,
                                  fontSize: getFontSize(
                                    15,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                                  .animate()
                                  .fade(delay: Duration(milliseconds: 200))
                                  .scale(),
                            ],
                          ),
                        ),
                      ),
                      // someObxList(context, itemController), фотки докторов - сторисы
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(
                                left: 20,
                                top: 30,
                                right: 20,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/webview',
                                                arguments:
                                                    'https://admin.onlinedoctor.su/articles/symptom.html');
                                          },
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  ColorConstant.fromHex(
                                                      "C8E0FF"),
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: IconButton(
                                                  onPressed: null,
                                                  icon: Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                  )))),
                                      Text("Пациенты")
                                    ]),
                                    Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/webview',
                                                arguments:
                                                    'https://admin.onlinedoctor.su/articles/symptom.html');
                                          },
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  ColorConstant.fromHex(
                                                      "C8E0FF"), // Изменен с FFFCBB на C8E0FF
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "/webview");
                                                  },
                                                  icon: Icon(Icons.medication,
                                                      color: Colors.grey,
                                                      size: getVerticalSize(
                                                          24))))),
                                      Text("Видео")
                                    ]),
                                    Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/webview',
                                                arguments:
                                                    'https://admin.onlinedoctor.su/articles/symptom.html');
                                          },
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  ColorConstant.fromHex(
                                                      "C8E0FF"),
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "/webview");
                                                  },
                                                  icon: Icon(Icons.info,
                                                      color: Colors
                                                          .grey, // Измените цвет здесь
                                                      size: getVerticalSize(
                                                          24))))),
                                      Text("Полезное")
                                    ]),
                                    Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/webview',
                                                arguments:
                                                    'https://admin.onlinedoctor.su/articles/symptom.html');
                                          },
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  ColorConstant.fromHex(
                                                      "C8E0FF"),
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: IconButton(
                                                  onPressed: null,
                                                  icon: Icon(
                                                    Icons.article,
                                                    color: Colors.grey,
                                                  )))),
                                      Text("Статьи")
                                    ]),
                                  ]))),*/
                      // Раздел "Рекомендуем вам"
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 20,
                            top: 30,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Рекомендуем вам",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: isDark
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.bluegray800,
                                  fontSize: getFontSize(15),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                              Obx(() {
                                return itemController.recommendations.isEmpty
                                    ? Container(
                                        height: getVerticalSize(120.00),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : recommendationsList(itemController.recommendations.toList());
                              }),
                              Obx(() {
                                return itemController.articles.isEmpty
                                    ? SizedBox(height: getVerticalSize(120.00))
                                    : fourThingsArticles(context, itemController.articles.toList());
                              })
                            ],
                          ),
                        ),
                      ),
                      //specsHeader(context, isDark),
                      //specsBody(context, isDark, itemController),
                      //  Text(context.userData['doctor_id']),
                      //  Text(context.userData['patient_id']),
                      //if (context.userData['patient_id'] != null)
                      Visibility(
                          child: DoctorsSliderHeader(isDark: isDark),
                          visible: false),
                      //if (context.userData['patient_id'] != null)
                      Visibility(
                          child: SingleChildScrollView(child: DoctorsSilder()),
                          visible: false),
                      //  NewsHeader(isDark: isDark),
                      // Добавляем отступ внизу для возможности прокрутки
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class NewsHeader extends StatelessWidget {
  NewsHeader({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          left: 20,
          top: 31,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Новости",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: isDark
                    ? ColorConstant.whiteA700
                    : ColorConstant.bluegray800,
                fontSize: getFontSize(
                  20,
                ),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 1,
                bottom: 3,
              ),
              child: InkWell(
                onTap: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TopDoctorScreen()),
                  );*/
                },
                child: Text(
                  "Все",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.blueA400,
                    fontSize: getFontSize(
                      20,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorsSliderHeader extends StatelessWidget {
  const DoctorsSliderHeader({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          left: 20,
          top: 31,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Врачи",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: isDark
                    ? ColorConstant.whiteA700
                    : ColorConstant.bluegray800,
                fontSize: getFontSize(
                  25,
                ),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 1,
                bottom: 3,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeSpecialistDoctorScreen()
                          //TopDoctorScreen()

                          // TopDoctorScreen()),
                          ));
                },
                child: Text(
                  "Все",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.blueA400,
                    fontSize: getFontSize(
                      20,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget recommendationsList(List<RecommendationModel> recommendations) {
  return SizedBox(
    height: getVerticalSize(307.00),
    width: getHorizontalSize(528.00),
    child: ListView.separated(
      padding: getPadding(
      //  left: 20,
        right: 20,
        top: 17,
      ),
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: recommendations.length,
      separatorBuilder: (context, index) {
        return HorizontalSpace(width: 16);
      },
      itemBuilder: (context, index) {
        return RecommendationItemWidget(
          recommendation: recommendations[index],
          index: index,
        );
      },
    ),
  );
}

Widget fourThingsArticles(BuildContext context, List<dynamic> articles) {
  // Берем первые 4 статьи (или меньше, если статей меньше)
  final displayArticles = articles.take(4).toList();
  
  return SizedBox(
    height: getVerticalSize(120.00),
    width: getHorizontalSize(528.00),
    child: ListView.separated(
      padding: getPadding(
        //left: 20,
        right: 20,
        top: 17,
      ),
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: displayArticles.length,
      separatorBuilder: (context, index) {
        return HorizontalSpace(width: 16);
      },
      itemBuilder: (context, index) {
        final article = displayArticles[index];
        final imageUrl = article['image'] != null
            ? 'https://admin.onlinedoctor.su/storage/' + article['image']
            : null;
        final title = article['title'] as String? ?? '';
        final articleId = article['id'] as int? ?? 0;
        
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HighPressureScreen(
                    articleId: articleId,
                    articleTitle: title,
                  ),
                ),
              );
            },
            child: Container(
              width: getHorizontalSize(160),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {
                                  // Fallback если изображение не загрузилось
                                },
                              )
                            : null,
                        color: imageUrl == null ? Colors.grey[300] : null,
                      ),
                      child: imageUrl == null
                          ? Center(child: Icon(Icons.article, color: Colors.grey[600]))
                          : null,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 12,
                      top: 12,
                      bottom: 16,
                      right: 12,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: getFontSize(14),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.bluegray800,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    ),
  );
}

class DoctorsSilder extends StatelessWidget {
  const DoctorsSilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("doctors");
    print(context.doctorsData.length);
    //print(context.doctorsData);
    return FadeInUp(
      child: SizedBox(
        height: getVerticalSize(
          276.00,
        ),
        width: getHorizontalSize(
          512.00,
        ),
        child: ListView.separated(
          padding: getPadding(
            left: 20,
            right: 20,
            top: 26,
          ),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: context.doctorsData.length,
          separatorBuilder: (context, index) {
            return HorizontalSpace(width: 16);
          },
          itemBuilder: (context, index) {
            return DoctorsSliderItem(
              item: context.doctorsData[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

Widget someObxList(context, itemController) {
  return Obx(() {
    //print(itemController.storyItems.length);
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      onFinish: (direction) => printLog('Direction $direction'),
      child: SizedBox(
        height: getVerticalSize(
          220.00,
        ),
        width: //getHorizontalSize(
            MediaQuery.of(context).size.width, //),
        //  child: NotificationListener<ScrollNotification>(

        child: ListView.separated(
          padding: getPadding(
            left: 20,
            right: 20,
            top: 27,
          ),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: itemController.articles.length,
          separatorBuilder: (context, index) {
            return HorizontalSpace(width: 16);
          },
          itemBuilder: (context, index) {
            var stories = itemController.articles;

            return GestureDetector(
                onTap: () async {
                  // Handle double tap action
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => StoryScreen()),
                  );
                  print('Image double tapped');
                },
                child: StoryItemWidget(
                  item: stories[index],
                  index: index,
                ));
          },
        ),
      ),
    );
  });
}

class NewsSlider extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());
  NewsSlider({
    Key? key,
  }) : super(key: key);
  final StoryController controller = StoryController();
  var current_story = 0;
  @override
  Widget build(BuildContext context) {
    print('lets play');
    // controller.play();
    return Center(child: Obx(() {
      print(itemController.storyItems.length);
      print("obx");
      return itemController.storyItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : FadeInUp(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width:
                      550, //getHorizontalSize(MediaQuery.of(context).size.width),
                  child: ListView(children: [
                    Container(
                        //    color: Colors.red,
                        height: MediaQuery.of(context).size.height / 3,
                        child: GestureDetector(
                            onDoubleTap: () {
                              print("dbl");
                              print(current_story);
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => StoryScreen()),
                              );
                              // controller.play();
                              //controller.pause();
                            },
                            child: StoryView(
                              controller: controller,
                              storyItems: itemController.storyItems,
                              /*[
                     StoryItem.text(
                    title:
                        "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
                    backgroundColor: Colors.orange,
                    roundedTop: true,
                  ),*/

                              // StoryItem.inlineImage(
                              //   NetworkImage(
                              //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
                              //   caption: Text(
                              //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       backgroundColor: Colors.black54,
                              //       fontSize: 17,
                              //     ),
                              //   ),
                              // ),
                              /*StoryItem.inlineImage(
                  url:
                      "https://www.diagnosio.com/wp-content/uploads/2021/02/online-doctor-consultation.jpg",
                  controller: controller,
                  caption: Text(
                    "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                ),*/
                              /*     StoryItem.inlineImage(
                  url:
                      "https://media1.tenor.com/m/GBBVrq9U3uUAAAAC/bh187-mr-bean.gif",
                  controller: controller,
                  caption: Text(
                    "Hektas, sektas and skatad",
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                )
            
                ],*/
                              onStoryShow: (storyItem, index) {
                                current_story = index;
                                //              print(current_story);
                                //              print("Showing a story (onstoryshow)");
                              },
                              onComplete: () {
                                //             print("Completed a cycle");
                              },
                              progressPosition: ProgressPosition.top,
                              repeat: true,
                              inline: true,
                              onVerticalSwipeComplete: (p0) {
                                print("swipe?");
                                //controller.play();
                                controller.next();
                              },
                            )))
                  ] //.animate(interval: 400.ms).fade(duration: 300.ms),
                      )),
            );
    }));
  }
}

Widget specsHeader(context, isDark) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: getPadding(
        left: 20,
        top: 30,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Пациенты на лечении",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color:
                  isDark ? ColorConstant.whiteA700 : ColorConstant.bluegray800,
              fontSize: getFontSize(
                25,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
            ),
          ).animate().fade(delay: Duration(milliseconds: 200)).scale(),
          Padding(
            padding: getPadding(
              top: 1,
              bottom: 3,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeSpecialistDoctorScreen()),
                );
              },
              child: Text(
                "Все",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ColorConstant.blueA400,
                  fontSize: getFontSize(
                    16,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget specsBody(context, isDark, itemController) {
  return Obx(() {
    //print(itemController.storyItems.length);
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      onFinish: (direction) => printLog('Direction $direction'),
      child: SizedBox(
        height: getVerticalSize(
          220.00,
        ),
        width: getHorizontalSize(
          528.00,
        ),
        //  child: NotificationListener<ScrollNotification>(

        child: ListView.separated(
          padding: getPadding(
            left: 20,
            right: 20,
            top: 27,
          ),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: itemController.cats.length,
          separatorBuilder: (context, index) {
            return HorizontalSpace(width: 16);
          },
          itemBuilder: (context, index) {
            var cats = itemController.cats;
            return AutolayouthorItemWidget(
              item: cats[index],
              index: index,
            );
          },
        ),
      ),
    );
  });
}
