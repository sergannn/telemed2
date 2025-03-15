import 'package:doctorq/screens/medcard/profile_survey.dart';

import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
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

            //Text(context.specsData.length.toString()),
            //DatePicker(height: 100, DateTime.now()),
            Container(
                width: double.infinity, // Makes the container full width
                margin:
                    EdgeInsets.symmetric(horizontal: 16), // Adds side margins
                child: SpecsTabBar(
                    ['Документы', 'Анкета', 'Дневник'], tabController)),
            MedCardList(tabController, MediaQuery.of(context).size.height),
            VerticalSpace(height: 24),
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
          Text("a"),
          // Вторая вкладка - анкета
          SurveyScreen(),

          // Третья вкладка - дневник
          TableCalendar(
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
