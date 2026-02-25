import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_3_filled_screen/proffit.dart';
import 'package:doctorq/screens/appointments/upcoming_appointments/UpcomingAppointments.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/spacing.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed; // Используем onPressed вместо onTap
  final bool isDark;
  final double width;
  final String text;
  final EdgeInsetsGeometry? margin;
  final ButtonVariant variant;
  final ButtonFontStyle fontStyle;
  final Alignment alignment;

  const CustomButtonWidget({
    Key? key,
    this.onPressed, // Используем onPressed вместо onTap
    required this.isDark,
    required this.width,
    required this.text,
    this.margin,
    required this.variant,
    required this.fontStyle,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isDark
              ? const Color.fromARGB(255, 125, 171, 223)
              : const Color.fromARGB(255, 125, 171, 223),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed, // Используем onPressed вместо onTap
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppointmentsStep3FilledScreen extends StatefulWidget {
  ContactMethods contactMethod;
  DateTime date;
  String time;
  AppointmentsStep3FilledScreen({
    Key? key,
    required this.contactMethod,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  _AppointmentsStep3FilledScreenState createState() =>
      _AppointmentsStep3FilledScreenState();
}

class _AppointmentsStep3FilledScreenState
    extends State<AppointmentsStep3FilledScreen> {
  final FocusNode _complaintFocusNode = FocusNode();

  @override
  void dispose() {
    _complaintFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ...topBack(text: "Доступ к пациентам", context: context, height: 0.0),
            VerticalSpace(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                    backgroundImage: AssetImage(
                                        'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Парфенова К.С.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const Text('Женщина, 71'),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 176, 214, 254),
                                        ),
                                        constraints: const BoxConstraints(
                                            minWidth: 10, minHeight: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.currency_ruble,
                                              size: 12,
                                              color: Color.fromARGB(
                                                  255, 16, 16, 16),
                                            ),
                                            const Text('2300',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                    fontSize: 11)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 8), // Отступ между строками
                              Container(
                                width: double.infinity, // Полная ширина
                                height: 40, // Высота изображения
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      12), // Закругленные углы
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/icons.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
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
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Заголовок
                                Text(
                                  'Время/дата',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),

                                // Описание
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Вставить отображение выбранных даты/времени для записи',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
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
                    Container(
                      width: double.infinity,
                      margin: getMargin(
                        left: 24,
                        top: 24,
                        right: 24,
                      ),
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    2.00,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: getPadding(
                                        left: 24,
                                        top: 1,
                                        right: 24,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: getPadding(
                                              top: 3,
                                            ),
                                            child: Text(
                                              "Коротко опишите проблему",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : ColorConstant.gray900A2,
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
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              "*",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ColorConstant.redA700A2,
                                                fontSize: getFontSize(
                                                  14,
                                                ),
                                                fontFamily: 'Source Sans Pro',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: isDark
                                            ? customDarkBoxShadow
                                            : customBoxShadow),
                                    child: CustomTextFormField(
                                      isDark: isDark,
                                      width: 380,
                                      focusNode: _complaintFocusNode,
                                      hintText:
                                          "Сильные боли в животе. Интервал 5-10 минут, 7 дней. В том числе,  головная боль на протяжении 10 дней.",
                                      margin: getMargin(
                                        top: 11,
                                      ),
                                      shape: TextFormFieldShape.RoundedBorder16,
                                      padding:
                                          TextFormFieldPadding.PaddingAll18,
                                      fontStyle: TextFormFieldFontStyle
                                          .SourceSansProSemiBold16Gray900a2,
                                      textInputAction: TextInputAction.done,
                                      alignment: Alignment.centerLeft,
                                      suffix: Container(
                                        margin: getMargin(
                                          left: 30,
                                          top: 30,
                                          right: 14,
                                          bottom: 6,
                                        ),
                                        child: CommonImageView(
                                          svgPath: ImageConstant.imgSearch,
                                        ),
                                      ),
                                      suffixConstraints: BoxConstraints(
                                        minWidth: getHorizontalSize(
                                          6.00,
                                        ),
                                        minHeight: getVerticalSize(
                                          6.00,
                                        ),
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButtonWidget(
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
              onPressed: () async {
                // UserStore storeUserStore = getIt.get<UserStore>();
                Map<dynamic, dynamic> userData = context.userData;
                Map<dynamic, dynamic> selectedDoctor = context.selectedDoctor;

                printLog('contactMethod ${widget.contactMethod}');
                printLog('date ${DateFormat('yy-MM-dd').format(widget.date)}');
                printLog('time ${widget.time}');
                printLog('time ${userData}');

                bool result = await setAppointment(
                    doctor_id: selectedDoctor['doctor_id'],
                    date: DateFormat('yyyy-MM-dd').format(widget.date),
                    patient_id: userData['patient_id'],
                    status: "1",
                    from_time: widget.time.split('-')[0].trim().split(' ')[0],
                    from_time_type:
                        widget.time.split('-')[0].trim().split(' ')[1],
                    to_time: widget.time.split('-')[1].trim().split(' ')[0],
                    to_time_type:
                        widget.time.split('-')[1].trim().split(' ')[1],
                    description: widget.contactMethod.toString(),
                    service_id: "1",
                    payment_type: "1",
                    payable_amount: "500");
                if (result) {
                  //добавили комнату
                  //endpoint в graph ---
                  snackBar(context, message: 'Вы успешно записались на прием');
                } else {
                  snackBar(context, message: 'Ошибка');
                }
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProffitScreen(
                              contactMethod: widget.contactMethod,
                              date: widget.date,
                              time: widget.time)));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
