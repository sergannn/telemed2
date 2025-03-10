import 'dart:math';
import 'dart:typed_data';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor1_item_widget.dart';

import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    tabController =
        TabController(length: context.specsData.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
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
            ...topBack(text: "Медкарта", context: context, back: false),

            //Text(context.specsData.length.toString()),
            //DatePicker(height: 100, DateTime.now()),
            Container(
                width: double.infinity, // Makes the container full width
                margin:
                    EdgeInsets.symmetric(horizontal: 16), // Adds side margins
                child: SpecsTabBar(
                    ['Документы', 'Анкета', 'Дневник'], tabController)),
            CatDoctorsList(context.specsData, tabController,
                MediaQuery.of(context).size.height),
            VerticalSpace(height: 24),
          ],
        ),
      ),
    );
  }

  Widget CatDoctorsList(doctorData, tabController, height) {
    return SizedBox(
      height: height,
      child: TabBarView(
        controller: tabController,
        children: [
          ...doctorData.map((spec) => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                padding: EdgeInsets.all(16),
                itemCount: doctorData.length,
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FutureBuilder<Uint8List>(
                            future: http.get(
                              Uri.parse(
                                  'https://api.api-ninjas.com/v1/randomimage?category=nature'),
                              headers: {
                                'X-Api-Key':
                                    'asYXsFiF+s0CXdGmy2oSg==mDD7MRrJJuANFnMx'
                              },
                            ).then((response) {
                              if (response.statusCode == 200) {
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
                                  return Image.memory(
                                    snapshot.data!,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    cacheWidth: 150, // Оптимизация памяти
                                    cacheHeight: 150, // Оптимизация памяти
                                  );
                                } catch (e) {
                                  print('Error decoding image: $e');
                                  return Container(
                                    width: double.infinity,
                                    height: 150,
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
                                  height: 150,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: Icon(Icons.error,
                                        color: Colors.grey[600]),
                                  ),
                                );
                              }
                              return Container(
                                width: double.infinity,
                                height: 150,
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
                          'Документ ${index + 1}',
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
