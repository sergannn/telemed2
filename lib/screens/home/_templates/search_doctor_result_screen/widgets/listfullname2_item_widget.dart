import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Listfullname2ItemWidget extends StatelessWidget {
  const Listfullname2ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(
        top: 8.0,
        bottom: 8.0,
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
              imagePath: ImageConstant.imgImage4,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: getPadding(
                    left: 20,
                    top: 13,
                    bottom: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          right: 10,
                        ),
                        child: Text(
                          "Dr. Dianne Russell",
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
                          top: 7,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CommonImageView(
                              svgPath: ImageConstant.imgClock,
                              height: getSize(
                                16.00,
                              ),
                              width: getSize(
                                16.00,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 4,
                                top: 2,
                                bottom: 2,
                              ),
                              child: Text(
                                "4.7 (4692 reviews)",
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: getHorizontalSize(
                          159.00,
                        ),
                        margin: getMargin(
                          top: 7,
                          right: 10,
                        ),
                        child: Text(
                          "Cardio Specialist -  Ramsay College  Hospital",
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              11,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 12,
                    top: 32,
                    right: 20,
                    bottom: 32,
                  ),
                  child: CommonImageView(
                    svgPath: ImageConstant.imgFavorite,
                    height: getSize(
                      36.00,
                    ),
                    width: getSize(
                      36.00,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
