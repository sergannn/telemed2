import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/spacing.dart';
import '../../../widgets/bkBtn.dart';
import 'widgets/gridlocation_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

class HomeSpecialistDoctorScreen extends StatefulWidget {
  const HomeSpecialistDoctorScreen({Key? key}) : super(key: key);

  @override
  _HomeSpecialistDoctorScreenState createState() =>
      _HomeSpecialistDoctorScreenState();
}

class _HomeSpecialistDoctorScreenState
    extends State<HomeSpecialistDoctorScreen> {
  late Future<List<SpecialistModel>> specialistsFuture;

  @override
  void initState() {
    super.initState();
    specialistsFuture = fetchSpecialists(); // Initialize future in initState
  }

  Future<void> refreshSpecialists() async {
    setState(() {
      specialistsFuture =
          fetchSpecialists(); // Update future to trigger UI update
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: getPadding(
                        top: 10,
                        bottom: 6,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const BkBtn(),
                          HorizontalSpace(width: 20),
                          Padding(
                            padding: getPadding(
                              left: 0,
                              top: 1,
                            ),
                            child: Text(
                              "Специальности",
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
                          ),
                        ],
                      ),
                    ),
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
            ),
            VerticalSpace(height: 10),
            Expanded(
                child: SafeArea(
              child: Container(
                width: size.width,
                margin: getMargin(
                  top: 16,
                ),
                child: RefreshIndicator.adaptive(
                  displacement: 1.0,
                  onRefresh: refreshSpecialists,
                  child: FutureBuilder<List<SpecialistModel>>(
                    future: fetchSpecialists(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<SpecialistModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Show a loading spinner
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Error: ${snapshot.error}')); // Error handling
                      } else {
                        return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.146,
                            mainAxisSpacing: 10.00,
                            crossAxisSpacing: 20.00,
                          ),
                          itemBuilder: (context, index) {
                            return GridlocationItemWidget(
                                index: index, items: snapshot.data!
                                //specialist: snapshot.data![index],
                                );
                          },
                        );
                      }
                    },
                  ), /*
                  Align(
                    alignment: Alignment.topCenter,
                    child: GridView.builder(
                      padding: getPadding(
                        left: 24,
                        right: 24,
                        bottom: 40,
                      ),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.146,
                        // mainAxisExtent: getVerticalSize(
                        //   158.00,
                        // ),
                        crossAxisCount: 2,
                        mainAxisSpacing: getHorizontalSize(
                          10.00,
                        ),
                        crossAxisSpacing: getHorizontalSize(
                          20.00,
                        ),
                      ),
                      physics: BouncingScrollPhysics(),
                      itemCount: specialistList.length,
                      itemBuilder: (context, index) {
                        return GridlocationItemWidget(
                          items: snapshot.data,
                          index: index,
                        );
                      },
                    ),
                  ),*/
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
