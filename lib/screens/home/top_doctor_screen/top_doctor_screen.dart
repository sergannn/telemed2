import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:doctorq/data_files/doctors_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/listfullname3_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/services/api_service.dart';

class TopDoctorScreen extends StatefulWidget {
  const TopDoctorScreen({Key? key}) : super(key: key);

  @override
  State<TopDoctorScreen> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<TopDoctorScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getSpecs();
    tabController = tabController =
        TabController(length: context.specsData.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
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
    print("and the specs:");
    print(context.specsData.length);

    return Scaffold(
      body: SingleChildScrollView(
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
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          "Top Doctor",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              26,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: getPadding(all: 10),
                      height: getVerticalSize(44),
                      width: getHorizontalSize(44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorConstant.blueA400.withOpacity(0.1),
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.filter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(height: 24),
            SizedBox(
              //height: getVerticalSize(240),
              child: GridView.builder(
                padding: getPadding(
                  left: 20,
                  top: 10,
                  right: 20,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 2.767,
                  // mainAxisExtent: getVerticalSize(
                  //   158.00,
                  // ),
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: getHorizontalSize(
                    10.00,
                  ),
                  crossAxisSpacing: getHorizontalSize(
                    10.00,
                  ),
                ),
                itemCount: 9, //availableTimesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      tabController!.animateTo(index);
                      setState(() {
                        // selectedTime = index;
                      });
                    },
                    child: Container(
                      padding: getPadding(
                        left: 20,
                        top: 8,
                        right: 20,
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        color: getRandomDarkBackgroundColor(), // Colors.red,
                        //    _randomColorForWhiteText(), //ColorConstant.blueA400,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            21.50,
                          ),
                        ),
                        border: Border.all(
                          color: ColorConstant.pink300E5, //(),
                          //  color: ColorConstant.blueA400,
                          // width: getHorizontalSize(
                          //    2.00,
                          //  ),
                        ),
                      ),
                      child: FittedBox(
                          child: Text(
                        maxLines: 2,
                        context.specsData[index].name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConstant.whiteA700,
                          fontSize: getFontSize(
                            25,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  );
                },
              ),
            ),
            /*FadeInUp(
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: context.specsData.length,
                  separatorBuilder: (context, index) {
                    return HorizontalSpace(width: 16);
                  },
                  itemBuilder: (context, index) {
                    var cats = context.specsData;
                    return Text(cats[index].name);
                  },
                ),
              ),
            ),*/
            VerticalSpace(height: 24),
            SizedBox(
              height: getVerticalSize(36),
              child: TabBar(
                controller: tabController,
                tabs: [
                  //  Row(children: [
                  ...context.specsData.map((tab) => Tab(text: tab.name)),
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
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context)
                  .size
                  .height, ////Media(), //size.height - getVerticalSize(192),
              child: TabBarView(
                controller: tabController,
                children: [
                  //Text("Hello"),
                  //...context.specsData.map((tab) => Tab(text: tab.name))
                  ...context.specsData.map((spec) => ListView.builder(
                        padding: getPadding(
                          left: 20,
                          right: 20,
                          top: 24,
                          bottom: 34,
                        ),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            context.doctorsData.length, // doctorList.length,
                        itemBuilder: (context, index) {
                          print("))");
                          if (context.doctorsData[index]['specializations']
                              .map((e) => e['name'])
                              .toList()
                              .contains(spec.name)) {
                            return Listfullname3ItemWidget(index: index);
                          } else {
                            print(context.doctorsData[index]['specializations']
                                .map((e) => e['name'])
                                .toList());
                            return Container();
                          }
                        },
                      )), /*
                  ListView.builder(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                      top: 24,
                      bottom: 34,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      return Listfullname3ItemWidget(index: index);
                    },
                  ),
                  ListView.builder(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                      top: 24,
                      bottom: 34,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      return Listfullname3ItemWidget(index: index);
                    },
                  ),
                  ListView.builder(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                      top: 24,
                      bottom: 34,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      return Listfullname3ItemWidget(index: index);
                    },
                  ),
                  ListView.builder(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                      top: 24,
                      bottom: 34,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      return Listfullname3ItemWidget(index: index);
                    },
                  ),
                  ListView.builder(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                      top: 24,
                      bottom: 34,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      return Listfullname3ItemWidget(index: index);
                    },
                  ),
              */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
