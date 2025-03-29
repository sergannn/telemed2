import 'dart:convert';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/steps/step_3_filled_screen/step_3_filled_screen.dart';
import 'package:doctorq/screens/profile/doctors_info.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class AppointmentManager {
  final String doctorId;
  DateTime date;
  String formattedDate = '';
  List<dynamic> availableTimes = [];
  int selectedTime = 0;
  ContactMethods contactMethod = ContactMethods.message;

  AppointmentManager({required this.doctorId, required this.date});

  Future<void> fetchTimes() async {
    // Format the date as yyyy-MM-dd
    formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    // Simulating fetching data from an API
    String apiUrl =
        'https://onlinedoctor.su/doctor-session-time?adminAppointmentDoctorId=$doctorId&date=$formattedDate&timezone_offset_minutes=180';
    print(apiUrl);
    printLog(apiUrl);
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data']['slots'];
        availableTimes = jsonResponse;
      } else {
        availableTimes = ['No dates'];
        //  date = formattedDate;
      }
    } catch (e) {
      printLog('Error fetching times: $e');
      availableTimes = ['No dates'];
    }
    printLog(availableTimes);
  }
}

class AppointmentsStep2FilledScreen extends StatefulWidget {
  DateTime date;
  late AppointmentManager appointmentManager;

  AppointmentsStep2FilledScreen({Key? key, required this.date})
      : super(key: key);
  @override
  State<AppointmentsStep2FilledScreen> createState() =>
      _AppointmentsStep2FilledScreenState();
}

enum ContactMethods { message, voiceCall, videoCall }

class _AppointmentsStep2FilledScreenState
    extends State<AppointmentsStep2FilledScreen> {
  late Map<dynamic, dynamic> doctor;
//  late TimeController timeController;
  late AppointmentManager appointmentManager;
  Future<void> _loadData() async {
    await appointmentManager.fetchTimes();
    printLog('loading data...');
    setState(() {
      availableTimesList = appointmentManager.availableTimes;
      formattedDate = appointmentManager.formattedDate;
    });
  }

  @override
  void initState() {
    printLog('initing');
    super.initState();
    doctor = context.selectedDoctor;
    appointmentManager = AppointmentManager(
      doctorId: doctor['doctor_id'],
      date: widget.date,
    );
    appointmentManager.fetchTimes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();
  }

  bool isMorning = true;
  int selectedTime = 0;
  ContactMethods contactMethod = ContactMethods.message;

  late List<dynamic> availableTimesList = ['...'];
  late String formattedDate = '...';
  @override
  Widget build(BuildContext context) {
    void _handleRefresh() {
      appointmentManager.fetchTimes();
    }

    Widget _buildContent() {
      return Text("Загрузка...");
      // ... existing content ...
    }

    Widget _buildLoadingIndicator(bool isLoading) {
      if (isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return _buildContent();
    }

//    final timeController = Get.find<TimeController>();
    // appointmentManager.fetchTimes();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
//    bool isRtl = context.locale == Constants.arLocal;

    return Scaffold(
      /* appBar: AppBar(title: Text('Available Times'), actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            appointmentManager.fetchTimes();

            setState(() {
              availableTimesList = appointmentManager.availableTimes;
              printLog('refreshing');
              printLog(widget.date);

//            timeController.fetchTimes();
            });
          },
        ),
      ]),
      // floatingActionButton: FloatingActionButton(onPressed: null, child: Text('doctor id: ${doctor['doctor_id']}')),
      */
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...topBack(text: "Запись к врачу", context: context),
            GestureDetector(
                child: DoctorInfoWidget(),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorInfoScreen()));
                }),
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
                            'Наш тест на важные показатели здоровья покажет вам , на что обратить свое внимание и носит рекомендательный характер. Пройдите по ссылке, чтобы ознакомиться и уже сейчас сделать свой организм выносливее и крепче',
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 20,
                  top: 20,
                  bottom: 10,
                  right: 20,
                ),
                child: Text(
                  "Выберите время",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.bluegray800,
                    fontSize: getFontSize(
                      16,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getVerticalSize(280),
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
                  maxCrossAxisExtent: 170,
                  mainAxisSpacing: getHorizontalSize(
                    10.00,
                  ),
                  crossAxisSpacing: getHorizontalSize(
                    10.00,
                  ),
                ),
                itemCount: availableTimesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = index;
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
                        color: selectedTime == index
                            ? ColorConstant.blueA400
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            21.50,
                          ),
                        ),
                        border: Border.all(
                          color: ColorConstant.blueA400,
                          width: getHorizontalSize(
                            0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        availableTimesList[0] != 'No dates'
                            ? availableTimesList[index]
                                .split('-')
                                .map((e) => e + '\n')
                                .join()
                            : 'Свободных мест на \n ${appointmentManager.formattedDate} нет',
                        // availableTimesList[index] +
                        //     '${isMorning ? ' AM' : ' PM'}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTime == index
                              ? Colors.white
                              : ColorConstant.blueA400,
                          fontSize: getFontSize(
                            12,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 20,
                  top: 40,
                  right: 20,
                ),
                child: Text(
                  "Выберите вид дальнейшей консультации",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.bluegray800,
                    fontSize: getFontSize(
                      16,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            VerticalSpace(height: 14),
            InkWell(
              onTap: () {
                setState(() {
                  contactMethod = ContactMethods.message;
                });
              },
              child: Container(
                margin: getMargin(
                  top: 8.0,
                  left: 20,
                  right: 20,
                  bottom: 8.0,
                ),
                padding: getPadding(left: 20, right: 20, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      56.00,
                    ),
                  ),
                  border: Border.all(
                      color: contactMethod == ContactMethods.message
                          ? Colors.transparent
                          : ColorConstant.lightLine),
                  gradient: LinearGradient(
                    begin: const Alignment(
                      1,
                      1.0024292469024658,
                    ),
                    end: const Alignment(
                      0,
                      0.0024292469024658203,
                    ),
                    colors: contactMethod == ContactMethods.message
                        ? [
                            const Color(0xFFE4F0FF), const Color(0xFFE4F0FF)
                            //  ColorConstant.blueA400,
                            //  ColorConstant.blue300,
                          ]
                        : [Colors.transparent, Colors.transparent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomIconButton(
                          isRtl: false,
                          height: 56,
                          width: 56,
                          variant: contactMethod == ContactMethods.message
                              ? IconButtonVariant.FillWhiteA700
                              : IconButtonVariant.FillBlueA40019,
                          shape: IconButtonShape.RoundedBorder28,
                          padding: IconButtonPadding.PaddingAll16,
                          child: CommonImageView(
                            imagePath: ImageConstant.reviews,
                          ),
                        ),
                        HorizontalSpace(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Чат",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(18),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 3,
                              ),
                              child: Text(
                                "Онлайн-консультация",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(14),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  contactMethod = ContactMethods.voiceCall;
                });
              },
              child: Container(
                margin: getMargin(
                  top: 8.0,
                  left: 20,
                  right: 20,
                  bottom: 8.0,
                ),
                padding: getPadding(left: 20, right: 20, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      56.00,
                    ),
                  ),
                  border: Border.all(
                      color: contactMethod == ContactMethods.voiceCall
                          ? Colors.transparent
                          : ColorConstant.lightLine),
                  gradient: LinearGradient(
                    begin: const Alignment(
                      1,
                      1.0024292469024658,
                    ),
                    end: const Alignment(
                      0,
                      0.0024292469024658203,
                    ),
                    colors: contactMethod == ContactMethods.voiceCall
                        ? [const Color(0xFFE4F0FF), const Color(0xFFE4F0FF)]
                        : [Colors.transparent, Colors.transparent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomIconButton(
                          isRtl: false,
                          height: 56,
                          width: 56,
                          variant: contactMethod == ContactMethods.voiceCall
                              ? IconButtonVariant.FillWhiteA700
                              : IconButtonVariant.FillBlueA40019,
                          shape: IconButtonShape.RoundedBorder28,
                          padding: IconButtonPadding.PaddingAll16,
                          child: CommonImageView(
                            imagePath: ImageConstant.call,
                          ),
                        ),
                        HorizontalSpace(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Аудио",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(18),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 3,
                              ),
                              child: Text(
                                "Онлайн-консультация",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(14),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  contactMethod = ContactMethods.videoCall;
                });
              },
              child: Container(
                margin: getMargin(
                  top: 8.0,
                  left: 20,
                  right: 20,
                  bottom: 8.0,
                ),
                padding: getPadding(left: 20, right: 20, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      56.00,
                    ),
                  ),
                  border: Border.all(
                      color: contactMethod == ContactMethods.videoCall
                          ? Colors.transparent
                          : ColorConstant.lightLine),
                  gradient: LinearGradient(
                    begin: const Alignment(
                      1,
                      1.0024292469024658,
                    ),
                    end: const Alignment(
                      0,
                      0.0024292469024658203,
                    ),
                    colors: contactMethod == ContactMethods.videoCall
                        ? [const Color(0xFFE4F0FF), const Color(0xFFE4F0FF)]
                        : [Colors.transparent, Colors.transparent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomIconButton(
                          isRtl: false,
                          height: 56,
                          width: 56,
                          variant: contactMethod == ContactMethods.videoCall
                              ? IconButtonVariant.FillWhiteA700
                              : IconButtonVariant.FillBlueA40019,
                          shape: IconButtonShape.RoundedBorder28,
                          padding: IconButtonPadding.PaddingAll16,
                          child: CommonImageView(
                            imagePath: ImageConstant.videocam,
                          ),
                        ),
                        HorizontalSpace(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Видео",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(18),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 3,
                              ),
                              child: Text(
                                "Онлайн-консультация",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(14),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppointmentsStep3FilledScreen(
                            time: availableTimesList[selectedTime],
                            date: appointmentManager.date,
                            contactMethod: contactMethod,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget DoctorInfoWidget() {
    return Align(
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
            color: const Color.fromARGB(255, 247, 247, 247).withOpacity(0.8),
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
                    backgroundImage: AssetImage(
                        'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Парфaнов К.С.',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Акушер-гинеколог'),
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
                          color: const Color.fromARGB(255, 176, 214, 254),
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 10, minHeight: 4),
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
                                    color: Color.fromARGB(255, 16, 16, 16),
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
                  borderRadius: BorderRadius.circular(12), // Закругленные углы
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
    );
  }
}
