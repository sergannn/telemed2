import 'dart:async';
import 'dart:convert';

import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/utils/utility.dart';

import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/spacing.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../ser_view.dart';
import '../../../../utils/pub.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class OnlineController extends GetxController {
  var cats = [].obs; // Reactive list to store fetched items
  var users = [].obs;
  var status = ''.obs;
  late Timer? _timer;
  //get http => null; // Reactive list to store fetched items
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    startFetchingData();
  }

  void startFetchingData() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkDoctor().then((value) {
        // Update the reactive variables here
        status.value = value;
      }).catchError((error) {
        printLog('Error fetching data: $error');
      });
    });
  }

  Future<String> checkDoctor() async {
    // Simulating fetching data from an API
    var response = await http.get(Uri.parse(
//http://localhost:8000/api/get-value?table_name=online&field_to_get=status&where_condition=5
        //'http://h315225216.nichost.ru/itmo2020/Student/doctor/cats.php'
        'https://fu-laravel.onrender.com/api/get-value?table_name=online&field_to_get=status&where_condition=5'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse["value"]["status"];
    } else {
      printLog('Failed to load items');
      return 'false';
    }
  }
}

// ignore: must_be_immutable
class AppointmentsListVideoCallScreen extends StatelessWidget {
  AppointmentsModel appointment;
  String user;
  bool role = false;
  String? id = '-1';
  AppointmentsListVideoCallScreen(
      {Key? key, this.id, required this.user, required this.appointment}) : super(key: key);
  final OnlineController onlineController = Get.put(OnlineController());
  @override
  Widget build(BuildContext context) {
    getRole().then((v) {
      role = v;
    });
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                          appointment.name,
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VerticalSpace(height: 14),
                    Container(
                      height: getVerticalSize(100),
                      margin: getMargin(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            12.00,
                          ),
                        ),
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
                          SizedBox(
                            height: getSize(
                              100.00,
                            ),
                            width: getSize(
                              100.00,
                            ),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        getHorizontalSize(
                                          12.00,
                                        ),
                                      ),
                                      bottomLeft: Radius.circular(
                                        getHorizontalSize(
                                          12.00,
                                        ),
                                      ),
                                    ),
                                    child: CommonImageView(
                                      imagePath: appointment.img,
                                      height: getSize(
                                        100.00,
                                      ),
                                      width: getSize(
                                        100.00,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                CustomIconButton(
                                  isRtl: isRtl,
                                  height: 36,
                                  width: 36,
                                  margin: getMargin(
                                    left: 10,
                                    top: 10,
                                  ),
                                  variant:
                                      IconButtonVariant.OutlineIndigoA20014_1,
                                  shape: IconButtonShape.CustomBorderTL12,
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                      appointment.contactMethodIcon,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          HorizontalSpace(width: 20),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointment.name,
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
                                        Padding(
                                          padding: getPadding(
                                            top: 3,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                appointment.contactMethodIcon ==
                                                        ImageConstant.call
                                                    ? 'VoiceCall'
                                                    : appointment
                                                                .contactMethodIcon ==
                                                            ImageConstant
                                                                .videocam
                                                        ? 'VideoCall'
                                                        : 'Message',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: getFontSize(
                                                    11,
                                                  ),
                                                  fontFamily: 'Source Sans Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  left: 4,
                                                  top: 1,
                                                ),
                                                child: Text(
                                                  "-",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: getFontSize(
                                                      11,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  left: 4,
                                                  bottom: 1,
                                                ),
                                                child: Text(
                                                  appointment.status,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: appointment.status ==
                                                            'Scheduled'
                                                        ? ColorConstant
                                                            .indigo601
                                                        : appointment.status ==
                                                                'Completed'
                                                            ? const Color(0xFF23A757)
                                                            : const Color(0xFFDA1414),
                                                    fontSize: getFontSize(
                                                      11,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 3,
                                          ),
                                          child: Text(
                                            appointment.time,
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
                                  ),
                                  Container(
                                    margin: getMargin(
                                        left: isRtl ? 20 : 0,
                                        right: isRtl ? 0 : 20),
                                    padding: getPadding(all: 10),
                                    height: getVerticalSize(44),
                                    width: getHorizontalSize(44),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorConstant.blueA400
                                          .withOpacity(0.1),
                                    ),
                                    child: CommonImageView(
                                      imagePath: appointment.contactMethodIcon,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: getMargin(left: 20, right: 20, top: 20),
                        padding: getPadding(left: 30, right: 30),
                        height: getVerticalSize(
                          157.00,
                        ),
                        width: size.width,
                        decoration: BoxDecoration(
                          color: isDark
                              ? ColorConstant.darkContainer
                              : ColorConstant.whiteA700,
                          border: Border.all(
                            color: ColorConstant.blueA400,
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
                                    imagePath: ImageConstant.patients,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 14,
                                  ),
                                  child: Text(
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
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 8,
                                    bottom: 3,
                                  ),
                                  child: Text(
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
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Visit Time",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              18,
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
                          top: 16,
                          right: 24,
                        ),
                        child: Text(
                          "Morning",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 15,
                          right: 24,
                        ),
                        child: Text(
                          "Monday, March 27 2022",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 14,
                          right: 24,
                        ),
                        child: Text(
                          "10:00 - 10:30 AM",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: getMargin(
                        left: 24,
                        top: 17,
                        right: 24,
                      ),
                      child: CustomDivider(isDark: isDark),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Patient Information",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              18,
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
                          top: 16,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Age",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                HorizontalSpace(width: 8),
                                Text(
                                  "30+",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Phone",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                HorizontalSpace(width: 8),
                                Text(
                                  "+62857-3637-8399",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Full Name",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                HorizontalSpace(width: 8),
                                Text(
                                  "Adam Smith",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: getMargin(
                        left: 24,
                        top: 24,
                        right: 24,
                      ),
                      child: CustomDivider(isDark: isDark),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Fee Information",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              18,
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
                          top: 14,
                          right: 24,
                        ),
                        child: Text(
                          "${Constants.currency}5 (Paid)",
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
                    //    Obx(() => Text(onlineController.status.value)),
                    Obx(() => CustomButton(
                          isDark: isDark,
                          width: size.width,
                          text: onlineController.status.value == 'online'
                              ? "ОК! Начать"
                              : "Ожидаем подключения",
                          margin: getMargin(
                            left: 24,
                            top: 20,
                            right: 24,
                            bottom: 20,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SerView(
                                      doctorId: id ?? '-1',
                                      user: user,
                                      doctor: role)
                                  //LightAppointmentsListVideoCallRingingScreen(
                                  //  appointment: appointment,
                                  //  contactMethod: ContactMethods.videoCall,
                                  //)
                                  ),
                            );
                          },
                          fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                          alignment: Alignment.center,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
