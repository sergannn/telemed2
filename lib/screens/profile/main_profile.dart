import 'dart:convert';
//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/chat/chat_screen.dart';
import 'package:doctorq/date_picker_timeline-1.2.6/lib/date_picker_widget.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreenDoctor.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_tasks.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_zapisi.dart';
import 'package:doctorq/screens/home/home_screen/widgets/story_item_widget.dart';
import 'package:doctorq/screens/profile/edit_profile_information.dart';
import 'package:doctorq/screens/profile/exit_sure.dart';
import 'package:doctorq/screens/profile/main_notification.dart';
import 'package:doctorq/screens/profile/my_wallet.dart';
import 'package:doctorq/screens/profile/promocodes_certificates.dart';
import 'package:doctorq/screens/profile/questions_screen.dart';
import 'package:doctorq/screens/profile/questions_screen.dart';
import 'package:doctorq/screens/profile/settings/appearance_screen/appearance_screen.dart';
import 'package:doctorq/screens/profile/settings/logout_modal_bottomsheet/logout_modal_bottomsheet.dart';
import 'package:doctorq/screens/profile/settings/schedule/schedule_screen.dart';
import 'package:doctorq/screens/profile/settings/settings_all.dart';
import 'package:doctorq/screens/profile/settings/settings_screen.dart';
import 'package:doctorq/screens/profile/widgets/autolayouthor_item_widget_profile_tasks.dart';
import 'package:doctorq/screens/stories/story_scren.dart';
import 'package:doctorq/services/auth_service.dart';
import "package:story_view/story_view.dart";
import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';

import 'package:doctorq/screens/home/specialist_doctor_screen/specialist_doctor_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/spacing.dart';
//import 'widgets/autolayouthor1_item_widget.dart';
//import 'widgets/autolayouthor_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_animate/flutter_animate.dart';
//final GlobalKey<RandomTextRevealState> globalKey = GlobalKey();

// ignore: must_be_immutable
class MainProfileScreen extends StatelessWidget {
  TextEditingController autoLayoutVerController = TextEditingController();
  final ItemController itemController = Get.put(ItemController());

  MainProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var titles = [
      "Путеводитель",
      "Ваши симптомы",
      "Синдром-чокер",
      "Статус здоровья"
    ];
    var images = [
      'assets/images/11.png', // Путеводитель
      'assets/images/12.png', // Симптомы здоровья
      'assets/images/13.png', // Синдром-чокер
      'assets/images/11.png', // Статус здоровья
    ];

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
                          CircleAvatar(
                            radius: getVerticalSize(25),
                            backgroundImage:
                                NetworkImage(context.userData['photo']),
                          ),

                          HorizontalSpace(width: 20),

                          //child: FittedBox(
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AkkEditScreen()));
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
                                    builder: (context) => SettingsAllScreen())
                                //HomeNotificationScreen()
                                //),
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
                              child: Icon(Icons.settings)),
                        ),
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
                                height: 56,
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
                                  //setState(() {});
                                  // New date selected
                                  //setState(() {
                                  //  selectedDate = date;
                                  //});
                                },
                              ))))),

                      Obx(() {
                        //print(itemController.storyItems.length);
                        return FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          onFinish: (direction) =>
                              printLog('Direction $direction'),
                          child: SizedBox(
                            height: getVerticalSize(
                              100.00,
                            ),
                            width: getHorizontalSize(
                              528.00,
                            ),
                            //  child: NotificationListener<ScrollNotification>(

                            child: ListView.separated(
                              padding: getPadding(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: itemController._calendarRecords.length,
                              separatorBuilder: (context, index) {
                                return HorizontalSpace(width: 16);
                              },
                              itemBuilder: (context, index) {
                                var cats = itemController._calendarRecords;
                                //return Text("a");

                                return AutolayouthorItemWidgetProfileTasks(
                                  item: cats[index],
                                  index: index,
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      //  Frame2087326464(),
// Код разделов меню профиля
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                     GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(Icons.wallet,
                                          color: ColorConstant.bluegray800),
                                      HorizontalSpace(width: 16),
                                      Text(
                                        "Мое расписание",
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Source Sans Pro',
                                          color: ColorConstant.bluegray800,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(Icons.chevron_right,
                                          color: ColorConstant.bluegray800),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleSettingsScreen()));
                                  }),
                              VerticalSpace(height: 16),
                              GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(Icons.wallet,
                                          color: ColorConstant.bluegray800),
                                      HorizontalSpace(width: 16),
                                      Text(
                                        "Мой кошелек",
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Source Sans Pro',
                                          color: ColorConstant.bluegray800,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(Icons.chevron_right,
                                          color: ColorConstant.bluegray800),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyWalletScreen()));
                                  }),
                              VerticalSpace(height: 16),
                              GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(Icons.card_giftcard,
                                          color: ColorConstant.bluegray800),
                                      HorizontalSpace(width: 16),
                                      Text(
                                        "Промокоды и Сертификаты",
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Source Sans Pro',
                                          color: ColorConstant.bluegray800,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container()), //пустое место
                                      Icon(Icons.chevron_right,
                                          color: ColorConstant.bluegray800),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PromocodesCertificatesScreen()));
                                  }),
                              VerticalSpace(height: 16),
                              GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(Icons.archive,
                                          color: ColorConstant.bluegray800),
                                      HorizontalSpace(width: 16),
                                      Text(
                                        "Архив записей",
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Source Sans Pro',
                                          color: ColorConstant.bluegray800,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(Icons.chevron_right,
                                          color: ColorConstant.bluegray800),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            
                                                AppointmentsScreen(
                                                    mode: 'old')));
                                  }),
                              VerticalSpace(height: 16),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ChatScreen();
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.support,
                                        color: ColorConstant.bluegray800),
                                    HorizontalSpace(width: 16),
                                    Text(
                                      "Чат с поддержкой",
                                      style: TextStyle(
                                        fontSize: getFontSize(14),
                                        fontFamily: 'Source Sans Pro',
                                        color: ColorConstant.bluegray800,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Icon(Icons.chevron_right,
                                        color: ColorConstant.bluegray800),
                                  ],
                                ),
                              ),
                              VerticalSpace(height: 16),
                              GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(Icons.feedback,
                                          color: ColorConstant.bluegray800),
                                      HorizontalSpace(width: 16),
                                      Text(
                                        "Вопросы и предложения",
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Source Sans Pro',
                                          color: ColorConstant.bluegray800,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(Icons.chevron_right,
                                          color: ColorConstant.bluegray800),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FAQScreen()));
                                  }),
                            ],
                          ),
                        ),
                      ),
/*
                      Obx(() {
                        //print(itemController.storyItems.length);
                        return FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          onFinish: (direction) =>
                              printLog('Direction $direction'),
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
                                top: 28,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: itemController._calendarRecords.length,
                              separatorBuilder: (context, index) {
                                return HorizontalSpace(width: 16);
                              },
                              itemBuilder: (context, index) {
                                var cats = itemController._calendarRecords;
                                //return Text("a");
                                return GestureDetector(
                                    onTap: () async {
                                      print("tap tap");
                                      // Handle double tap action
                                      if (index == 1) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseSpecsScreen()),
//                                  TopDoctorScreen()),
                                        );
                                        print('Image double tapped');
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Персональный трекер",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Source Sans Pro',
                                            fontWeight: FontWeight
                                                .w600, // размер в пикселях
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  12.0), // Увеличен отступ сверху
                                          child: AutolayouthorItemWidgetZapisi(
                                            item: cats[index],
                                            index: index,
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          ),
                        );
                      }),
                      //SingleChildScrollView(child: NewsSlider()),
*/
                      // Раздел "Рекомендуем вам"
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 20,
                            top: 14,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Выгодные предложения для вас",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: isDark
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.bluegray800,
                                  fontSize: getFontSize(16),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                              fourThings(titles, images)
                            ],
                          ),
                        ),
                      ),
                      //specsHeader(context, isDark),
                      //specsBody(context, isDark, itemController),
                      //  Text(context.userData['doctor_id']),
                      //  Text(context.userData['patient_id']),
                      //if (context.userData['patient_id'] != null)

                      //  NewsHeader(isDark: isDark),

                      Padding(
                          padding: getPadding(
                            left: 20,
                            right: 20,
                            bottom: 20,
                            top: 30,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    barrierColor: Colors.black.withOpacity(0.8),
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return ProfileSettingsLogoutModalBottomsheet();
                                    });
                              },
                              child: GestureDetector(
                                onTap: () {
                                  print("tapap");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ExiteSureScreen()));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.bluegray800,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.logout_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    HorizontalSpace(width: 26),
                                    Text(
                                      "Выход из аккаунта",
                                      style: TextStyle(
                                        fontSize: getFontSize(16),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w800,
                                        color: ColorConstant.bluegray800,
                                      ),
                                    ),
                                  ],
                                ),
                              )))
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

Widget fourThings(titles, images) {
  return SizedBox(
    height: getVerticalSize(120.00),
    width: getHorizontalSize(528.00),
    child: ListView.separated(
      padding: getPadding(
        left: 20,
        right: 20,
        top: 6,
      ),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) {
        return HorizontalSpace(width: 16);
      },
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/webview',
                  arguments:
                      'https://admin.onlinedoctor.su/articles/symptom.html');
            },
            child: Container(
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
                      width: getHorizontalSize(140),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 16,
                      top: 12,
                      bottom: 16,
                      right: 16,
                    ),
                    child: Text(
                      titles[index],
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
          physics: const BouncingScrollPhysics(),
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
