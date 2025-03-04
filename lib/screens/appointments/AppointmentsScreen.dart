import 'dart:convert';
import 'dart:developer';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/past_appointments/past_appointments.dart';
import 'package:doctorq/screens/appointments/upcoming_appointments/UpcomingAppointments.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/loading_overlay.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../utils/pub.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool showUpcomming = true;
  List myAppointments = [];

  @override
  initState() {
    super.initState();
    loadData();

    /*   pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
        ),
        onRefresh: () async {
          print("refresh");
        });*/
  }

  loadData() async {
    printLog('Getting Appointments');

    Future.delayed(Duration.zero, () {
      MyOverlay.show(context);
    });

    UserStore storeUserStore = getIt.get<UserStore>();
    Map<dynamic, dynamic> userData = storeUserStore.userData;
    print(userData);
    // пример того как грузить много данных
    List<bool> resultOfRequests = await Future.wait([
      userData['patient_id'] != null
          ? getAppointments(patientId: '1') //userData['patient_id'])
          : getAppointmentsD(doctorId: userData['doctor_id'])
    ]);

    setState(() {
      myAppointments = context.appointmentsData;
    });

    inspect(resultOfRequests);

    printLog('Appointments loaded');

    MyOverlay.hide();
  }

//  late PullToRefreshController pullToRefreshController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //...topBack("Записи", context),
            //  const HeaderNavBar(),
            HeaderFilterButtons(),
            VerticalSpace(height: 24),
            Expanded(
                child: RefreshIndicator(
              displacement: 1.0,
              onRefresh: () async {
                print("refreshing??");
                //await itemController.refreshData();
                await Future.delayed(const Duration(seconds: 2));
                await loadData();
                setState(() {
                  myAppointments = context.appointmentsData;
                }); // Simulate network request
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child:
                    showUpcomming ? UpcomingAppointments() : PastAppointments(),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container HeaderFilterButtons() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.fromHex("E4F0FF"),
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            24.0,
          ),
        ),
      ),
      // color: ColorConstant.fromHex("E4F0FF"),
      height: getVerticalSize(
        45.00,
      ),
      margin: getMargin(left: 20, top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  showUpcomming = true;
                });
              },
              child: Container(
                // padding: getPadding(top: 8, bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: showUpcomming ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      24.0,
                    ),
                  ),
                  /* border: Border.all(
                    color: ColorConstant.blueA400,
                    width: getHorizontalSize(
                      0.00,
                    ),
                  ),*/
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Предстоящие',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: getFontSize(12),
                          fontWeight: FontWeight.w600,
                          color: showUpcomming
                              ? Colors.black
                              : ColorConstant.blueA400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          HorizontalSpace(width: 16),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  showUpcomming = false;
                });
              },
              child: Container(
                padding: getPadding(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: !showUpcomming ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      24.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Прошедшие',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: getFontSize(12),
                          fontWeight: FontWeight.w600,
                          color: showUpcomming
                              ? Colors.black
                              : ColorConstant.blueA400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderNavBar extends StatelessWidget {
  const HeaderNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width,
        margin: getMargin(
          top: 26,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CommonImageView(
                    imagePath: ImageConstant.appLogo,
                    height: getVerticalSize(36),
                    width: getHorizontalSize(36),
                  ),
                  HorizontalSpace(width: 20),
                  Text(
                    "Сеансы",
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
              /*  Container(
                padding: getPadding(all: 10),
                height: getVerticalSize(44),
                width: getHorizontalSize(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstant.blueA400.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: ColorConstant.blueA400,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
