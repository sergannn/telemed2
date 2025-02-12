import 'widgets/listfullname2_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LightHomeSearchDoctorResultScreen extends StatelessWidget {
  TextEditingController autoLayoutVerController = TextEditingController();

  LightHomeSearchDoctorResultScreen({Key? key}) : super(key: key);

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
                top: 24,
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
                        bottom: 10,
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgAutolayouthor,
                        height: getSize(
                          24.00,
                        ),
                        width: getSize(
                          24.00,
                        ),
                      ),
                    ),
                    CustomSearchView(
                      isDark: isDark,
                      width: 336,
                      focusNode: FocusNode(),
                      controller: autoLayoutVerController,
                      hintText: "\"Dr. |\"",
                      suffix: Padding(
                        padding: EdgeInsets.only(
                          right: getHorizontalSize(
                            15.00,
                          ),
                        ),
                        child: IconButton(
                          onPressed: autoLayoutVerController.clear,
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        minWidth: getHorizontalSize(
                          24.00,
                        ),
                        minHeight: getVerticalSize(
                          24.00,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: getVerticalSize(
                    792.00,
                  ),
                  width: size.width,
                  margin: getMargin(
                    top: 24,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: getHorizontalSize(
                            404.00,
                          ),
                          margin: getMargin(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: getPadding(
                                        left: 15,
                                        top: 10,
                                        right: 16,
                                        bottom: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.blueA400,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "All",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: getFontSize(
                                            16,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: getMargin(
                                        left: 8,
                                      ),
                                      padding: getPadding(
                                        left: 16,
                                        top: 10,
                                        right: 16,
                                        bottom: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.blueA400,
                                          width: getHorizontalSize(
                                            2.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Brain",
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
                                    Container(
                                      margin: getMargin(
                                        left: 8,
                                      ),
                                      padding: getPadding(
                                        left: 16,
                                        top: 10,
                                        right: 16,
                                        bottom: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.blueA400,
                                          width: getHorizontalSize(
                                            2.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Cardio",
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
                                    Container(
                                      margin: getMargin(
                                        left: 8,
                                      ),
                                      padding: getPadding(
                                        left: 16,
                                        top: 12,
                                        right: 16,
                                        bottom: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.blueA400,
                                          width: getHorizontalSize(
                                            2.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Eye",
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
                                    Container(
                                      margin: getMargin(
                                        left: 8,
                                      ),
                                      padding: getPadding(
                                        left: 16,
                                        top: 10,
                                        right: 16,
                                        bottom: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.blueA400,
                                          width: getHorizontalSize(
                                            2.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Dentist",
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
                                    Container(
                                      margin: getMargin(
                                        left: 8,
                                      ),
                                      padding: getPadding(
                                        left: 16,
                                        top: 10,
                                        right: 16,
                                        bottom: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            18.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.blueA400,
                                          width: getHorizontalSize(
                                            2.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Nerve",
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
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 24,
                                  right: 10,
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return const Listfullname2ItemWidget();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: getMargin(
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(
                                  24.00,
                                ),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  24.00,
                                ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomButton(
                                isDark: isDark,
                                width: 107,
                                text: "\"Home\"",
                                margin: getMargin(
                                  left: 40,
                                  top: 24,
                                  bottom: 32,
                                ),
                                variant: ButtonVariant.FillBlueA40019,
                                shape: ButtonShape.RoundedBorder12,
                                padding: ButtonPadding.PaddingAll12,
                                prefixWidget: Container(
                                  margin: getMargin(
                                    right: 12,
                                  ),
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgAutolayouthor,
                                    height: getSize(
                                      24.00,
                                    ),
                                    width: getSize(
                                      24.00,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 32,
                                  top: 25,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 32,
                                  top: 25,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 32,
                                  top: 25,
                                  right: 40,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
