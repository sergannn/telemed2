import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:doctorq/data_files/doctors_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget.dart';
import 'package:doctorq/screens/home/top_doctor_screen/top_doctor_screen_step_2.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'widgets/listfullname3_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/services/api_service.dart';

class ChooseSpecsScreen extends StatefulWidget {
  const ChooseSpecsScreen({Key? key,}) : super(key: key);

  @override
  State<ChooseSpecsScreen> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<ChooseSpecsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredSpecs = [];
  List<Map<String, dynamic>> _allSpecs = [];
  
  @override
  void initState() {
    super.initState();
    _initializeSpecs();
    _searchController.addListener(_onSearchChanged);
  }
  
  void _initializeSpecs() {
    // Создаем список специализаций с подсчетом врачей
    _allSpecs = context.specsData.map((spec) {
      int doctorCount = _countDoctorsForSpec(spec.name);
      return {
        'name': spec.name,
        'doctorCount': doctorCount,
        'originalSpec': spec,
      };
    }).toList();
    
    // Сортируем по количеству врачей (по возрастанию)
    _allSpecs.sort((a, b) => a['doctorCount'].compareTo(b['doctorCount']));
    _filteredSpecs = List.from(_allSpecs);
    
    // Инициализируем TabController с безопасной длиной
    int safeLength = _allSpecs.isNotEmpty ? _allSpecs.length : 1;
    tabController = TabController(length: safeLength, vsync: this);
  }
  
  int _countDoctorsForSpec(String specName) {
    return context.doctorsData.where((doctor) {
      if (doctor['specializations'] == null) return false;
      return doctor['specializations'].any((spec) => spec['name'] == specName);
    }).length;
  }
  
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSpecs = List.from(_allSpecs);
      } else {
        _filteredSpecs = _allSpecs.where((spec) {
          return spec['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  final List<Color?> _darkBackgroundColors = [
    Colors.red[800], // Deep Orange
    Colors.pink[800], // Deep Pink
    Colors.purple[800], // Deep Purple
    Colors.indigo[800], // Deep Indigo
    Colors.blue[800], // Deep Blue

    Colors.teal[800], // Deep Teal
    Colors.green[800], // Deep Green
    Colors.amber[800], // Deep Amber
    Colors.orange[800], // Deep Orange
    Colors.brown[800], // Deep Brown
    Colors.blueGrey[800], // Deep Blue Grey
    Colors.grey[800], // Deep Grey
  ];

  Color? getRandomDarkBackgroundColor() {
    final random = Random();
    return _darkBackgroundColors[random.nextInt(_darkBackgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    print(context.doctorsData[0]);
    print("its the first doctor");
    print("of ");
    print(context.doctorsData.length);
    print(context.doctorsData);
    print("and the specs:");
    print(context.specsData.length);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [ 
            SizedBox(height: 15),
            ...topBack(text: "Специализации", context: context),
            VerticalSpace(height: 24),
            Container(
              width: double.infinity, // Makes the container full width
              margin: EdgeInsets.symmetric(horizontal: 16), // Adds side margins
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  hintText: 'Поиск специализаций...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color:const Color.fromARGB(255, 96, 159, 222), width: 1),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
              ),
            ),
            VerticalSpace(height: 24),
            /*Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Специализации врача',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/
            specsList(),
            //Text(context.specsData.length.toString()),
            //SpecsTabBar(context.specsData, tabController),
            //CatDoctorsList(context.specsData, tabController,
            //     MediaQuery.of(context).size.height),
            // VerticalSpace(height: 24),
          ],
        ),
      ),
    );
  }

  Widget specsList() {
    return SizedBox(
      child: ListView.builder(
        padding: getPadding(
          left: 20,
          top: 10,
          right: 20,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _filteredSpecs.length,
        itemBuilder: (context, index) {
          final spec = _filteredSpecs[index];
          final specName = spec['name'];
          final doctorCount = spec['doctorCount'];
          
          // Находим случайного врача этой специализации
          final doctorsWithSpec = context.doctorsData.where((doctor) {
            if (doctor['specializations'] == null) return false;
            return doctor['specializations'].any((spec) => spec['name'] == specName);
          }).toList();
          
          String? randomDoctorPhoto;
          if (doctorsWithSpec.isNotEmpty) {
            Random random = Random();
            int randomIndex = random.nextInt(doctorsWithSpec.length);
            randomDoctorPhoto = doctorsWithSpec[randomIndex]['photo'];
          }
          
          return InkWell(
            onTap: () {
              print("Navigating to spec: $specName");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChooseSpecScreen2(selectedSpec: specName)),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon section
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.width / 8,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: getRandomDarkBackgroundColor(),
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  // Content section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          specName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(16),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$doctorCount врачей',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorConstant.blueA400,
                            fontSize: getFontSize(14),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow section
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
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

  Widget CatDoctorsList(doctorData, tabController, height) {
    return SizedBox(
      height: height,

      ///Media(), //size.height - getVerticalSize(192),
      child: TabBarView(
        controller: tabController,
        children: [
          ...doctorData.map((spec) => ListView.builder(
                padding: getPadding(
                  left: 20,
                  right: 20,
                  top: 24,
                  bottom: 34,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctorData.length, // doctorList.length,
                itemBuilder: (context, index) {
                  if (context.doctorsData[index] != null) {
                    if (context.doctorsData[index]['specializations']
                        .map((e) => e['name'])
                        .toList()
                        .contains(spec.name)) {
                      return Listfullname3ItemWidget(index: index);
                    }
                  } else {
                    print(context.doctorsData[index]['specializations']
                        .map((e) => e['name'])
                        .toList());
                    return Container();
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget SpecsTabBar(specData, tabController) {
    return TabBar(
      controller: tabController,
      tabs: [
        //  Row(children: [
        ...specData.map((tab) => Tab(text: tab.name)),
        //    ]),
        //   Row(children: [
        /* Tab(
                    text: 'Все',
                  )*/
      ],
      isScrollable: true,
      padding: getPadding(left: 25, right: 25),
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ColorConstant.blueA400),
      unselectedLabelColor: ColorConstant.blueA400,
      unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(16),
          fontWeight: FontWeight.w600,
          fontFamily: 'Source Sans Pro'),
      labelColor: Colors.white,
      labelStyle: TextStyle(
          fontSize: getFontSize(16),
          fontWeight: FontWeight.w600,
          fontFamily: 'Source Sans Pro'),
    );
  }
}
