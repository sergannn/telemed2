import 'package:animate_do/animate_do.dart';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/listreply1_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class UpcomingAppointments extends StatelessWidget {
  UpcomingAppointments({Key? key}) : super(key: key);

  final TextEditingController autoLayoutVerController = TextEditingController();

  final bool doctor = false;

  @override
  Widget build(BuildContext context) {
    // loadData();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<Map<dynamic, dynamic>> appointmentsList = context.appointmentsData;
    // Группировка по дате
    Map<String, List<Map<dynamic, dynamic>>> groupedAppointments = {};
    final formatter = DateFormat('EEEE', 'ru_RU');
    for (var appointment in appointmentsList) {
      String ad = appointment['date'];
      String at = appointment['from_time'];
      DateTime appDateTime =
          DateFormat('yyyy-MM-dd HH:mm').parse(ad + " " + at);
      print(appDateTime);
      bool isPast = appDateTime.isBefore(DateTime.now());
      print(
          "Is ${DateFormat('yyyy-MM-dd HH:mm').format(appDateTime)} past? ${isPast ? 'Yes' : 'No'}");

      if (!isPast) {
        String date = appointment['date'];
        if (!groupedAppointments.containsKey(date)) {
          groupedAppointments[date] = [];
        }
        groupedAppointments[date]!.add(appointment);
      }
    }
    print("grouped:");
    print(groupedAppointments);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //  SearchBar(
          //     isDark: isDark, autoLayoutVerController: autoLayoutVerController),
          // InfoBar(isDark: isDark),
          Align(
              alignment: Alignment.center,
              child: FadeInUp(
                  child: Padding(
                      padding: getPadding(
                        left: 24,
                        top: 18,
                        right: 24,
                      ),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: groupedAppointments.length,
                          itemBuilder: (context, index) {
                            String date =
                                groupedAppointments.keys.elementAt(index);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Заголовок даты
                                Padding(
                                  padding: getPadding(
                                    left: 24,
                                    top: 18,
                                    right: 24,
                                  ),
                                  child: Text(
                                    StringUtils.capitalize(formatter
                                            .format(DateTime.parse(date))) +
                                        ', ' +
                                        date,
                                    style: TextStyle(
                                      fontSize: getFontSize(16),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : ColorConstant.bluegray700,
                                    ),
                                  ),
                                ),
                                // Список встреч за эту дату
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: appointmentsList.length,
                                  itemBuilder: (context, index) {
                                    //print(appointmentsList[index]);
                                    String ad = appointmentsList[index]['date'];
                                    String at =
                                        appointmentsList[index]['from_time'];
                                    DateTime appDateTime =
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .parse(ad + " " + at);
                                    print(appDateTime);
                                    bool isPast =
                                        appDateTime.isBefore(DateTime.now());
                                    print(
                                        "Is ${DateFormat('yyyy-MM-dd HH:mm').format(appDateTime)} past? ${isPast ? 'Yes' : 'No'}");

                                    if (!isPast &&
                                        appointmentsList[index]['date'] == date)
                                      return AppointmentListItem(
                                        isPast: isPast,
                                        index: index,
                                        item: appointmentsList[index],
                                      );
                                    return const SizedBox.shrink();
                                  },
                                )
                              ],
                            );
                          })))),

          VerticalSpace(height: 40),
        ],
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  const InfoBar({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: getPadding(
            left: 24,
            top: 29,
            right: 24,
          ),
          child: Text(
            context.userData['username'] ?? 'unknown',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: isDark ? Colors.white : ColorConstant.bluegray700,
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          "Tomorrow, March 27 2022",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: isDark ? ColorConstant.whiteA700 : ColorConstant.bluegray800,
            fontSize: getFontSize(
              16,
            ),
            fontFamily: 'Source Sans Pro',
            fontWeight: FontWeight.w400,
          ),
        ),
        // FloatingActionButton.large(onPressed: () {}, child: Text('refresh'))
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.isDark,
    required this.autoLayoutVerController,
  }) : super(key: key);

  final bool isDark;
  final TextEditingController autoLayoutVerController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          left: 24,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomSearchView(
                isDark: isDark,
                width: 324,
                focusNode: FocusNode(),
                controller: autoLayoutVerController,
                hintText: "Поиск",
                suffix: Padding(
                    padding: EdgeInsets.only(
                      right: getHorizontalSize(
                        15.00,
                      ),
                      left: getHorizontalSize(
                        15.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.search,
                    )),
                suffixConstraints: BoxConstraints(
                  maxWidth: getHorizontalSize(
                    54.00,
                  ),
                  maxHeight: getVerticalSize(
                    24.00,
                  ),
                ),
              ),
            ),
            HorizontalSpace(width: 12),
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
    );
  }
}
