import 'dart:typed_data';

import 'package:doctorq/screens/medcard/profile_survey.dart';

import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class MedCardScreen extends StatefulWidget {
  const MedCardScreen({Key? key}) : super(key: key);

  @override
  State<MedCardScreen> createState() => _MedCardScreenState();
}

class _MedCardScreenState extends State<MedCardScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getSpecs();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
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
            ...topBack(
                text: "Медкарта",
                context: context,
                back: false,
                icon: Icon(Icons.favorite)),
            Container(
                width: double.infinity, // Makes the container full width
                margin:
                    EdgeInsets.symmetric(horizontal: 16), // Adds side margins
                child: SpecsTabBar(
                    ['Документы', 'Анкета', 'Дневник'], tabController)),
            MedCardList(tabController, MediaQuery.of(context).size.height),
            VerticalSpace(height: 224),
          ],
        ),
      ),
    );
  }

  Widget MedCardList(tabController, height) {
    print(tabController.length);
    print("it was length");

    return SizedBox(
      height: height,
      child: TabBarView(
        controller: tabController,
        children: [
          // Первая вкладка - сетка документов
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            padding: EdgeInsets.all(16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 0
                        ? CircleAvatar(
                            //radius: 150,
                            backgroundColor: Colors.red,
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.add)))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FutureBuilder<Uint8List>(
                              future: http.get(
                                  Uri.parse(
                                      'https://api.api-ninjas.com/v1/randomimage?category=abstract'),
                                  headers: {
                                    'X-Api-Key':
                                        'asYXsFiF+s0CXdGdmy2oSg==mDD7MRrJJuANFnMx',
                                    'Accept': 'image/jpg'
                                  }).then((response) {
                                print(response.statusCode);
                                print(response.body);
                                if (response.statusCode == 200) {
                                  print(response.body);
                                  return response.bodyBytes;
                                } else {
                                  throw Exception('Failed to load image');
                                }
                              }).catchError((error) {
                                print('Error loading image: $error');
                                return null;
                              }),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  try {
                                    //return Text("s");
                                    return Image.memory(
                                      snapshot.data!,
                                      width: double.infinity,
                                      height: getVerticalSize(100),
                                      fit: BoxFit.contain,
                                      cacheWidth: 150,
                                      cacheHeight: 150,
                                    );
                                  } catch (e) {
                                    print('Error decoding image: $e');
                                    return Container(
                                      width: double.infinity,
                                      height: getVerticalSize(100),
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Icon(Icons.error,
                                            color: Colors.grey[600]),
                                      ),
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return Container(
                                    width: double.infinity,
                                    height: getVerticalSize(100),
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: Icon(Icons.error,
                                          color: Colors.grey[600]),
                                    ),
                                  );
                                }
                                return Container(
                                  width: double.infinity,
                                  height: getVerticalSize(100),
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                    SizedBox(height: 8),
                    Text(
                      index == 0 ? 'Добавить' : 'Документ ${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getFontSize(14),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Source Sans Pro',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Вторая вкладка - анкета
          /*Container( margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/5),
       child:*/
          SurveyScreen(),

          // Третья вкладка - дневник
          TableCalendar(
            rangeStartDay: DateTime.now(),
            rangeEndDay: DateTime(2025, 4, 19),
            onCalendarCreated: (pageController) {},
            eventLoader: (day) {
              if (day.weekday == DateTime.monday) {
                return ['Cyclic event'];
              }

              return [];
            },
            locale: 'ru_RU',
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
          ),
          /*   ShowCalendarToolWidget(
            action: '',
            dateStr: '',
          )*/
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
          onTap: (int index) {
            // Navigate to a new screen when a tab is tapped
            if (index == 10) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SurveyScreen())).then((_) {
                // Return to the previous tab after navigation
                if (mounted) {
                  tabController.animateTo(0);
                }
              });
              ;
            }
          },
          //dividerHeight: 10,
          controller: tabController,
          tabs: [
            ...specData.map((tab) => Tab(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6), // Отступы вокруг текста
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: Text(tab)))), //, text: tab.name)),
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
