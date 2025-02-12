import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPrivacyPolicyScreen extends StatelessWidget {
  const ProfileSettingsPrivacyPolicyScreen({Key? key}) : super(key: key);

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
                top: 36,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 204,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: getPadding(
                        bottom: 3,
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
                        top: 1,
                      ),
                      child: Text(
                        "Privacy Policy",
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(
                    top: 38,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: getHorizontalSize(
                          380.00,
                        ),
                        margin: getMargin(
                          left: 24,
                          right: 24,
                        ),
                        child: Text(
                          "Odio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu. Sit amet venenatis urna cursus eget nunc scelerisque viverra. Purus in massa tempor nec feugiat. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Aenean vel elit scelerisque mauris pellentesque.\n\nOdio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu.",
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.bluegray700,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: getMargin(
                            top: 95,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 40,
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
                                  left: 30,
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
                                  left: 30,
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
                              CustomButton(
                                isDark: isDark,
                                width: 112,
                                text: "\"Profile\"",
                                margin: getMargin(
                                  left: 30,
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
