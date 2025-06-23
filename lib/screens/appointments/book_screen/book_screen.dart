import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/past_appointments/past_appointments.dart';
import 'package:doctorq/screens/appointments/review_screen/review_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/profile/doctors_info.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/custom_icon_button.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
bool isWeekday(DateTime date) {
  int dayOfWeek = date.weekday;
  return dayOfWeek >= 1 && dayOfWeek <= 5; // Monday to Friday
}

class AppointmentsBookScreen extends StatefulWidget {
  AppointmentsBookScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsBookScreen> createState() => _AppointmentsBookScreenState();



}

class _AppointmentsBookScreenState extends State<AppointmentsBookScreen> {
  DateTime selectedDate = DateTime.now();
  bool isFav = false;
  bool firstFound = false;

List<DateTime> _generateInactiveDates(daysOfWeek) {
      List<DateTime> inactiveDates = [];

      // Add current week
      for (int day = 1; day <= 70; day++) {
        DateTime date = DateTime.now().add(Duration(days: day - 1));
        //print(date.weekday);
        if (daysOfWeek.contains(date.weekday)) inactiveDates.add(date);
      }
      if(inactiveDates.isEmpty) { 
        
        //inactiveDates.add(DateTime.now());
      }
      else { 
        if(firstFound==false) {
        selectedDate=inactiveDates.first;
        firstFound=true;}
      }
      return inactiveDates;
 }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    //  bool isRtl = context.locale == Constants.arLocal;
    print(context.selectedDoctor);
    print("ku");
    print("empty");
    print(context.selectedDoctor.isEmpty);
    if (context.selectedDoctor.isEmpty == true) {
      context.setSelectedDoctorByIndex(1);
    }
    print("ku");
    print("empty");
    print(context.selectedDoctor.isEmpty);

    Map<dynamic, dynamic> doctor = context.selectedDoctor;
    //print(doctor["doctorSession"]["sessionWeekDays"]);
    print(doctor);
    List<dynamic> daysOfWeek = doctor["schedule"].map((e) => e['day']).toList();
    print("Days of week: $daysOfWeek");

    print("kuku");
    print(daysOfWeek);
    //[0]["sessionWeekDays"].map((e) => e['day_of_week']).toList();
    

    print('Days of week: $daysOfWeek');
    print("sel");
    print(selectedDate);
    print(_generateInactiveDates(daysOfWeek));
    return Scaffold(
        body:
            // floatingActionButton: const FloatingActionButton(onPressed: null, child: Text("2")),
            SingleChildScrollView(
      child: Column(
        children: [
          ...topBack(text: "Запись к врачу", context: context),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoctorInfoScreen()));
            },
            child:
                // Зеленый контейнер
                Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 4,
                  right: 24,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 247, 247)
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: //
                                NetworkImage(context.selectedDoctor[
                                    'photo']), // Используем AssetImage вместо Image.asset
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.selectedDoctor['username'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(context.selectedDoctor['specializations']
                                            .length ==
                                        0
                                    ? ''
                                    : context.selectedDoctor['specializations']
                                        [0]['name'])
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 176, 214, 254),
                                ),
                                constraints: const BoxConstraints(
                                    minWidth: 10, minHeight: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.currency_ruble,
                                      size: 12,
                                      color: Color.fromARGB(255, 16, 16, 16),
                                    ),
                                    const Text('2300',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 16, 16, 16),
                                            fontSize: 11)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Отступ между строками
                      Container(
                        width: double.infinity, // Полная ширина
                        height: 40, // Высота изображения
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(12), // Закругленные углы
                          image: DecorationImage(
                            image: AssetImage('assets/images/icons.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Зеленый контейнер
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 14,
                  right: 24,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238)
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Заголовок
                      Text(
                        'О враче',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 17, 17, 17),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),

                      // Описание
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          context.selectedDoctor['description'] ??
                              '...Наш тест на важные показатели здоровья покажет вам , на что обратить свое внимание и носит рекомендательный характер. Пройдите по ссылке, чтобы ознакомиться и уже сейчас сделать свой организм выносливее и крепче',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 17, 17, 17),
                            fontSize: 12,
                          ),
                        ),
                      ),

                      SizedBox(height: 12),
                      // Кнопка и время
                    ],
                  ),
                ),
              )),
          VerticalSpace(height: 5),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 16,
                  right: 24,
                ),
                child: SingleChildScrollView(
                    child: DatePicker(
                  DateTime.now(),
                  //activeDates: [],
                  locale: 'ru_RU',
                  
                  activeDates: _generateInactiveDates(doctor["schedule"].map((e) => e['day']).toList()),
                  deactivatedColor: Colors.grey,

                  initialSelectedDate: _generateInactiveDates(doctor["schedule"].map((e) => e['day']).toList()).isEmpty ? null : _generateInactiveDates(doctor["schedule"].map((e) => e['day']).toList()).first ,
                  selectionColor: ColorConstant.fromHex(
                      "C8E0FF"), // ColorConstant.blueA400,
                  height: MediaQuery.of(context).size.height * 0.15,
                
                  dayTextStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Source Sans Pro',
                    color: ColorConstant.black900,
                  ),
                  monthTextStyle: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: ColorConstant.black900,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    print(date);
                    print(selectedDate);
                    print("changed");
                    setState(() {
                      selectedDate = date;
                    });
                  },
                )),
              )),
              _generateInactiveDates(doctor["schedule"].map((e) => e['day']).toList()).isNotEmpty ?
          CustomButton(
            
              isDark: isDark,
              width: size.width,
              text: "Записаться",
              margin: getMargin(
                left: 24,
                top: 22,
                right: 24,
              ),
              variant: ButtonVariant.FillBlueA400,
              fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
              alignment: Alignment.center,
              onTap: () {
                print(selectedDate);
                print("se date<<");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppointmentsStep2FilledScreen(date: selectedDate)),
                );
              }) :  CustomButton(
            
              isDark: isDark,
              width: size.width,
              text: "Нет дат для записи",
              margin: getMargin(
                left: 24,
                top: 22,
                right: 24,
              ),
              variant: ButtonVariant.FillBlueA400,
              fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
              alignment: Alignment.center,
              onTap: () {
                print(selectedDate);
               
              }),
        ],
      ),
    ));
  }

  Widget doctorDetails(isRtl, isDark) {
    return SvgPicture.string(
        width: MediaQuery.of(context).size.width, SvgConstant.star_svg);
    return Container(
        margin: getMargin(left: 20, right: 20, top: 20),
        padding: getPadding(left: 30, right: 30),
        //height: getVerticalSize(
        //  57.00,
        //),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors
              .white, //isDark ? ColorConstant.darkContainer : ColorConstant.whiteA700,
          border: Border.all(
            color: Colors.white, //ColorConstant.white,
          ),
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(4, (int index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonImageView(
                          imagePath: ImageConstant.starHalf,
                          height: getSize(
                            16.00,
                          ),
                          width: getSize(
                            16.00,
                          ),
                        ),
                        HorizontalSpace(width: 4),
                        Text(
                          "5000+",
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
                      ]),
                  Text(
                    "Patients",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            }),
            /*   Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIconButton(
                  isRtl: isRtl,
                  height: 44,
                  width: 44,
                  variant: IconButtonVariant.FillBlueA40019,
                  shape: IconButtonShape.CircleBorder22,
                  child: CommonImageView(
                    imagePath: ImageConstant.person,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 14,
                  ),
                  child: Text(
                    "15+",
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
                Padding(
                  padding: getPadding(
                    top: 8,
                    bottom: 3,
                  ),
                  child: Text(
                    "Years experiences",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIconButton(
                  isRtl: isRtl,
                  height: 44,
                  width: 44,
                  variant: IconButtonVariant.FillBlueA40019,
                  shape: IconButtonShape.CircleBorder22,
                  child: CommonImageView(
                    imagePath: ImageConstant.reviews,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 14,
                  ),
                  child: Text(
                    "3800+",
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
                Padding(
                  padding: getPadding(
                    top: 8,
                    bottom: 3,
                  ),
                  child: Text(
                    "Reviews",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        ));
  }

  List<Widget> workingTime() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: getPadding(
            left: 24,
            top: 16,
            right: 24,
          ),
          child: Text(
            "Working Time",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              //isDark ? Colors.white : ColorConstant.bluegray800,
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: getPadding(
            left: 24,
            top: 10,
            right: 24,
          ),
          child: Text(
            "Mon - Fri, 09.00 AM - 20.00 PM",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: getFontSize(
                14,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      )
    ];
  }

  Widget reviewsWidget() {
    return Padding(
      padding: getPadding(
        left: 24,
        top: 18,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Reviews",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors
                  .white, //isDark ? Colors.white : ColorConstant.bluegray800,
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppointmentsReviewScreen()),
              );
            },
            child: Text(
              "See reviews",
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
        ],
      ),
    );
  }

  forceLog() {}
}
