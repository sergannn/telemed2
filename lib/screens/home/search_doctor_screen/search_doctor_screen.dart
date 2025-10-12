import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import '../../../data_files/doctors_list.dart';
import 'widgets/listfullname1_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';

class HomeSearchDoctorScreen extends StatefulWidget {
  const HomeSearchDoctorScreen({Key? key}) : super(key: key);

  @override
  State<HomeSearchDoctorScreen> createState() =>
      _HomeSearchDoctorScreenState();
}

class _HomeSearchDoctorScreenState
    extends State<HomeSearchDoctorScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController autoLayoutVerController = TextEditingController();
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = tabController = TabController(length: 6, vsync: this);
    autoLayoutVerController.text = 'Dr.';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Expanded(
                      child: CustomSearchView(
                        isDark: isDark,
                        width: size.width,
                        focusNode: FocusNode(),
                        controller: autoLayoutVerController,
                        hintText: "Search",
                        alignment: Alignment.center,
                        suffix: Padding(
                            padding: EdgeInsets.only(
                                right: getHorizontalSize(
                                  15.00,
                                ),
                                left: getHorizontalSize(15)),
                            child: CommonImageView(
                              imagePath: ImageConstant.search,
                            )),
                        suffixConstraints: BoxConstraints(
                          maxWidth: getHorizontalSize(
                            50.00,
                          ),
                          maxHeight: getVerticalSize(
                            50.00,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(height: 24),
            SizedBox(
              height: getVerticalSize(36),
              child: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Brain',
                  ),
                  Tab(
                    text: 'Cardio',
                  ),
                  Tab(
                    text: 'Eye',
                  ),
                  Tab(
                    text: 'Dentist',
                  ),
                  Tab(
                    text: 'Nerve',
                  ),
                ],
                isScrollable: true,
                padding: getPadding(left: 20, right: 20),
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
              height: size.height - getVerticalSize(200),
              child: TabBarView(
                controller: tabController,
                children: [
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
                      return Listfullname1ItemWidget(index: index);
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
                      return Listfullname1ItemWidget(index: index);
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
                      return Listfullname1ItemWidget(index: index);
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
                      return Listfullname1ItemWidget(index: index);
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
                      return Listfullname1ItemWidget(index: index);
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
                      return Listfullname1ItemWidget(index: index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
