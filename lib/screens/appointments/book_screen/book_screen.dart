import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/past_appointments/past_appointments.dart';
import 'package:doctorq/screens/appointments/review_screen/review_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    Map<dynamic, dynamic> doctor = context.selectedDoctor;
    //print(doctor["doctorSession"]["sessionWeekDays"]);
    print(doctor);
    List<dynamic> daysOfWeek = doctor["schedule"].map((e) => e['day']).toList();
    print("Days of week: $daysOfWeek");

    print("kuku");
    print(daysOfWeek);
    //[0]["sessionWeekDays"].map((e) => e['day_of_week']).toList();
    List<DateTime> _generateInactiveDates() {
      List<DateTime> inactiveDates = [];

      // Add current week
      for (int day = 1; day <= 70; day++) {
        DateTime date = DateTime.now().add(Duration(days: day - 1));
        print(date.weekday);
        if (!daysOfWeek.contains(date.weekday)) inactiveDates.add(date);
      }

      return inactiveDates;
    }

    print('Days of week: $daysOfWeek');
    print(_generateInactiveDates());
    return Scaffold(
      body: SafeArea(
          child:
              // floatingActionButton: const FloatingActionButton(onPressed: null, child: Text("2")),
              SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
//          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          //        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              margin: getMargin(top: 26, bottom: 10),
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
                    Row(
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          "Запись к врачу",
                          // doctor["username"],
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
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                          child: Container(
                            padding: getPadding(all: 10),
                            height: getVerticalSize(44),
                            width: getHorizontalSize(44),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
//                              color: ColorConstant.blueA400.withOpacity(0.1),
                            ),
                            child: CommonImageView(
                              color: Colors.red,
                              imagePath: isFav
                                  ? ImageConstant.favorite
                                  : ImageConstant.favoriteBorder,
                            ),
                          ),
                        ),
                        HorizontalSpace(width: 16),
                        /* Container(
                          padding: getPadding(all: 10),
                          height: getVerticalSize(44),
                          width: getHorizontalSize(44),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.blueA400.withOpacity(0.1),
                          ),
                          child: CommonImageView(
                            imagePath: ImageConstant.share,
                          ),
                        ),*/
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                VerticalSpace(height: 14),
                Container(
                  margin: getMargin(left: 20, right: 20),
                  height: getVerticalSize(100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        12.00,
                      ),
                    ),
                    color: isDark
                        ? ColorConstant.darkTextField
                        : Colors.white, //ColorConstant.whiteA700,
                    border: Border.all(
                      color: ColorConstant.bluegray50,
                      width: getHorizontalSize(
                        1.00,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: isRtl
                              ? Radius.circular(
                                  getHorizontalSize(
                                    0.00,
                                  ),
                                )
                              : Radius.circular(
                                  getHorizontalSize(
                                    12.00,
                                  ),
                                ),
                          bottomLeft: isRtl
                              ? Radius.circular(
                                  getHorizontalSize(
                                    0.00,
                                  ),
                                )
                              : Radius.circular(
                                  getHorizontalSize(
                                    12.00,
                                  ),
                                ),
                          bottomRight: isRtl
                              ? Radius.circular(
                                  getHorizontalSize(
                                    12.00,
                                  ),
                                )
                              : Radius.circular(
                                  getHorizontalSize(
                                    0.00,
                                  ),
                                ),
                          topRight: isRtl
                              ? Radius.circular(
                                  getHorizontalSize(
                                    12.00,
                                  ),
                                )
                              : Radius.circular(
                                  getHorizontalSize(
                                    0.00,
                                  ),
                                ),
                        ),
                        child: CommonImageView(
                          url: doctor["photo"],
                          height: getSize(
                            100.00,
                          ),
                          width: getSize(
                            100.00,
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      HorizontalSpace(width: 20),
                      Expanded(
                        child: Padding(
                          padding: getPadding(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                doctor["username"],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: getFontSize(
                                    16,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              /*  HorizontalSpace(width: 4),
                                    Text(
                                      "4.7 (4692 reviews)",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: getFontSize(
                                          11,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),*/

                              Container(
                                margin: getMargin(top: 3),
                                child: Text(
                                  doctor['specializations'].length == 0
                                      ? ''
                                      : doctor['specializations'][0]['name'],
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      11,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        child: doctorDetails(isRtl, isDark),
                        padding: getPadding(
                          left: 24,
                          top: 16,
                          right: 24,
                        ))),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 16,
                      right: 24,
                    ),
                    child: Text(
                      "О враче",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color:
                            isDark ? Colors.white : ColorConstant.bluegray800,
                        fontSize: getFontSize(
                          16,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    374.00,
                  ),
                  margin: getMargin(
                    left: 24,
                    top: 16,
                    right: 24,
                  ),
                  child: Text(
                    "Dr. Jenny Wilson is the top most Cardiologist specialist in Nanyang Hospital at London. She achived several awards for her wonderful contribution in medical field. She is available for private consultation.",
                    maxLines: null,
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
                //workingTime(),
                //reviewsWidget(),

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
                        //activeDates: [],
                        inactiveDates: _generateInactiveDates(),
                        DateTime.now(),
                        deactivatedColor: Colors.grey,

                        initialSelectedDate: DateTime.now(),
                        selectionColor: ColorConstant.fromHex(
                            "C8E0FF"), // ColorConstant.blueA400,
                        height: MediaQuery.of(context).size.height * 0.15,
                        dateTextStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            color: ColorConstant.black900,
                            fontWeight: FontWeight.w600,
                            fontSize: 23),
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
                          fontSize: 14,
                        ),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      )),
                    )),
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Book Appointment",
                  margin: getMargin(
                    left: 24,
                    top: 25,
                    right: 24,
                    bottom: 20,
                  ),
                  onTap: () {
                    print(selectedDate);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentsStep2FilledScreen(
                              date: selectedDate)),
                    );
                  },
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                ),
              ],
            ),
          ],
        ),
      )),
    );
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
}
