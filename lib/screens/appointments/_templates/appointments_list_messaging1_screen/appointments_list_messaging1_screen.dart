import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

class AppointmentsListMessaging1Screen extends StatelessWidget {
  const AppointmentsListMessaging1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:SafeArea(
          child:
           SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
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
                          Padding(
                            padding: getPadding(
                              top: 10,
                              bottom: 5,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 4,
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
                                Padding(
                                  padding: getPadding(
                                    left: 20,
                                    top: 2,
                                  ),
                                  child: Text(
                                    "Messaging",
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
                          CommonImageView(
                            svgPath: ImageConstant.imgFavorite,
                            height: getSize(
                              44.00,
                            ),
                            width: getSize(
                              44.00,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 26,
                      right: 24,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
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
                            imagePath: ImageConstant.imgImage17,
                            height: getSize(
                              100.00,
                            ),
                            width: getSize(
                              100.00,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  12.00,
                                ),
                              ),
                              bottomRight: Radius.circular(
                                getHorizontalSize(
                                  12.00,
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: getPadding(
                                  left: 20,
                                  top: 28,
                                  right: 20,
                                ),
                                child: Text(
                                  "Dr. Eleanor Pena",
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
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 20,
                                  top: 13,
                                  right: 20,
                                  bottom: 28,
                                ),
                                child: Text(
                                  "10:00 - 10:30 AM",
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
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 24,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.gray100,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          getHorizontalSize(
                            12.00,
                          ),
                        ),
                        bottomLeft: Radius.circular(
                          getHorizontalSize(
                            12.00,
                          ),
                        ),
                        bottomRight: Radius.circular(
                          getHorizontalSize(
                            12.00,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: getHorizontalSize(
                            229.00,
                          ),
                          margin: getMargin(
                            left: 20,
                            top: 18,
                            bottom: 14,
                          ),
                          child: Text(
                            "Hello Adam, I am Dr. Eleanor Pena.\nI will help to solve your disease complaints.",
                            maxLines: null,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray900A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 38,
                            top: 66,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:00",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray600,
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
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.gray100,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: getHorizontalSize(
                            214.00,
                          ),
                          margin: getMargin(
                            left: 20,
                            top: 18,
                            bottom: 17,
                          ),
                          child: Text(
                            "First, can you tell me about your illness so far",
                            maxLines: null,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray900A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 53,
                            top: 42,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:00",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray600,
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
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.gray100,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: getHorizontalSize(
                            228.00,
                          ),
                          margin: getMargin(
                            left: 20,
                            top: 18,
                            bottom: 16,
                          ),
                          child: Text(
                            "This is very important so that I can help identify your disease and the solution 😁",
                            maxLines: null,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray900A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 39,
                            top: 66,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:01",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.gray600,
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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 24,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.blueA400Cc,
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
                        bottomRight: Radius.circular(
                          getHorizontalSize(
                            12.00,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 16,
                            bottom: 15,
                          ),
                          child: Text(
                            "Hello Dr. Eleanor Pena",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 120,
                            top: 18,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:01",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.blueA400Cc,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: getHorizontalSize(
                            258.00,
                          ),
                          margin: getMargin(
                            top: 18,
                            bottom: 17,
                          ),
                          child: Text(
                            "I have had a heart problem for the past 3 days, I often feel tired and out of breath",
                            maxLines: null,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 10,
                            top: 66,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:01",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.blueA400Cc,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 17,
                            bottom: 14,
                          ),
                          child: Text(
                            "Sometimes I throw up too",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700A2,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 95,
                            top: 18,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "10:02",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
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
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      left: 24,
                      top: 14,
                      right: 24,
                      bottom: 48,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteA700,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          20.00,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 24,
                            top: 30,
                            bottom: 25,
                          ),
                          child: Text(
                            "Type message ...",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.bluegray300,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: 20,
                            right: 24,
                            bottom: 20,
                          ),
                          child: CommonImageView(
                            imagePath: ImageConstant.imgAutolayouthor,
                            height: getSize(
                              32.00,
                            ),
                            width: getSize(
                              32.00,
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
    );
  }
}
