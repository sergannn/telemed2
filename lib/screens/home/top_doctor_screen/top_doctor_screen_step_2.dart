import 'dart:math';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor1_item_widget.dart';
import 'package:doctorq/screens/home/home_screen/widgets/doctor_item.dart';
import 'package:doctorq/screens/profile/popular_doctors.dart';

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
            ...topBack(text: "Запись к врачу", context: context),

            VerticalSpace(height: 24),
            Container(
              width: double.infinity, // Makes the container full width
              margin: EdgeInsets.symmetric(horizontal: 16), // Adds side margins
              child: TextField(
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
                    borderSide: BorderSide(color: const Color.fromARGB(255, 96, 159, 222), width: 1),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Зеленый контейнер
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: getPadding(
                    left: 24,
                    top: 0,
                    right: 24,
                  ),
                  child: Container(
                    height: 28, // Увеличенная высота
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center, // Центрирование содержимого
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Заголовок

                        // Описание
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            'Запись осуществляется по вашему местному времени',
                            textAlign: TextAlign.center, // Центрирование текста
                            style: TextStyle(
                              color: const Color.fromARGB(255, 17, 17, 17),
                              fontSize: 10,
                            ),
                          ),
                        ),

                        // Кнопка и время
                      ],
                    ),
                  ),
                )),

            VerticalSpace(height: 24),

            //Text(context.specsData.length.toString()),
            //DatePicker(height: 100, DateTime.now()),
            Container(
                width: double.infinity, // Makes the container full width
                margin:
                    EdgeInsets.symmetric(horizontal: 16), // Adds side margins
                child: SpecsTabBar(context.specsData, tabController)),
            CatDoctorsList(context.specsData, tabController,
                MediaQuery.of(context).size.height),
            VerticalSpace(height: 24),
          ],
        ),
      ),
    );
  }

  Widget CatDoctorsList(specsData, tabController, height) {
    return SizedBox(
      height: height,

      ///Media(), //size.height - getVerticalSize(192),
      child: TabBarView(
        controller: tabController,
        children: [
          ...specsData.map((spec) => ListView.builder(
                padding: getPadding(
                  left: 20,
                  right: 20,
                  top: 24,
                  bottom: 34,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: context.doctorsData.length, // Use actual doctors count
                
                itemBuilder: (context, index) {
                  if (context.doctorsData[index] != null) {
                    // Debug print to see what's happening
                    print('Checking doctor ${context.doctorsData[index]['username']} for spec ${spec.name}');
                    print('Doctor specializations: ${context.doctorsData[index]['specializations']}');
                    
                    if (context.doctorsData[index]['specializations']
                        .map((e) => e['name'])
                        .toList()
                        .contains(spec.name)) {
                      print('Doctor ${context.doctorsData[index]['specializations']} matches spec ${spec.name}');
                      // return Column(
       // children: List.generate(context.doctorsData.length, (index) {
      return DoctorItem(
        item: context.doctorsData[index],
        index: index,
      );
    
                      return Text(context.doctorsData[index]['username']);
                   /*   return DoctorsSliderItem(
                        item: context.doctorsData[index],
                        index: index,
                      );*/
                    } else {
                      print('Doctor ${context.doctorsData[index]['specializations']} does NOT match spec ${spec.name}');
                      return Container();
                    }
                  } else {
                    print('Doctor at index $index is null');
                    return Container();
                  }
                },
              )),
        ],
      ),
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
