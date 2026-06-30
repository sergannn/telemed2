import 'dart:math';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';

import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

class ChooseSpecScreen2 extends StatefulWidget {
  final String? selectedSpec;
  
  const ChooseSpecScreen2({Key? key, this.selectedSpec}) : super(key: key);

  @override
  State<ChooseSpecScreen2> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<ChooseSpecScreen2>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    
    // Безопасная инициализация TabController
    int safeLength = context.specsData.isNotEmpty ? context.specsData.length : 1;
    tabController = TabController(length: safeLength, vsync: this);
    
    // Автоматически переключаемся на выбранную специализацию
    if (widget.selectedSpec != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        int selectedIndex = _findSpecIndex(widget.selectedSpec!);
        if (selectedIndex != -1 && tabController != null) {
          tabController!.animateTo(selectedIndex);
        }
      });
    }
  }
  
  int _findSpecIndex(String specName) {
    for (int i = 0; i < context.specsData.length; i++) {
      if (context.specsData[i].name == specName) {
        return i;
      }
    }
    return -1;
  }

  @override
  void dispose() {
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...topBack(text: "Запись к врачу", context: context),
          VerticalSpace(height: 24),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                hintText: 'Найти врача',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 96, 159, 222),
                    width: 1,
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: getPadding(
                left: 24,
                top: 0,
                right: 24,
              ),
              child: Container(
                height: 28,
                margin: const EdgeInsets.only(top: 0),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238)
                      .withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    'Запись осуществляется по вашему местному времени',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 17, 17, 17),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
          VerticalSpace(height: 24),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: SpecsTabBar(context.specsData, tabController),
          ),
          Expanded(
            child: CatDoctorsList(context.specsData, tabController),
          ),
          VerticalSpace(height: 24),
        ],
      ),
    );
  }

  Widget CatDoctorsList(specsData, tabController) {
    return TabBarView(
      controller: tabController,
      children: [
        ...specsData.map((spec) {
          final filteredDoctors = context.doctorsData.where((doctor) {
            if (doctor == null || doctor['specializations'] == null) {
              return false;
            }

            return doctor['specializations']
                .map((e) => e['name'])
                .toList()
                .contains(spec.name);
          }).toList();

          return ListView.builder(
            padding: getPadding(
              left: 20,
              right: 20,
              top: 24,
              bottom: 34,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              return DoctorItem(
                item: filteredDoctors[index],
                index: index,
              );
            },
          );
        }),
      ],
    );
  }

  Widget SpecsTabBar(specData, tabController) {
    return Container(
        // color: ColorConstant.fromHex("E4F0FF"),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(120), bottomLeft: Radius.circular(120)),
          color: ColorConstant.fromHex("E4F0FF"),
        ),
        child: TabBar(
          //dividerHeight: 10,
          controller: tabController,
          tabs: [
            //  Row(children: [
            ...specData.map((tab) => Tab(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6), // Отступы вокруг текста
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: Text(tab.name)))), //, text: tab.name)),
            //    ]),
            //   Row(children: [
            /* Tab(
                    text: 'Все',
                  )*/
          ],
          isScrollable: true,
          padding: getPadding(top: 10, bottom: 10),
          indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(120),
              color: Colors.white),
          unselectedLabelColor: ColorConstant.blueA400,
          unselectedLabelStyle: TextStyle(
              fontSize: getFontSize(12),
              fontWeight: FontWeight.w600,
              fontFamily: 'Source Sans Pro'),
          labelColor: Colors.black,
          labelStyle: TextStyle(
              fontSize: getFontSize(12),
              fontWeight: FontWeight.w600,
              fontFamily: 'Source Sans Pro'),
        ));
  }
}
