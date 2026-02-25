import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileSettingsContactUsBlankScreen extends StatefulWidget {
  ProfileSettingsContactUsBlankScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsContactUsBlankScreen> createState() =>
      _ProfileSettingsContactUsBlankScreenState();
}

class _ProfileSettingsContactUsBlankScreenState
    extends State<ProfileSettingsContactUsBlankScreen> {
  TextEditingController autoLayoutHorOneController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void dispose() {
    autoLayoutHorOneController.dispose();
    _fullNameFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
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
                top: 36,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 241,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: getPadding(
                        bottom: 2,
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
                      ),
                      child: Text(
                        "Contact us",
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
                    top: 34,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          margin: getMargin(
                            left: 24,
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
                                                  "Full Name",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .bluegray800A2,
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.redA700A2,
                                                    fontSize: getFontSize(
                                                      14,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        isDark: isDark,
                                        width: 380,
                                        focusNode: _fullNameFocusNode,
                                        hintText: "\"Full Name\"",
                                        margin: getMargin(
                                          top: 11,
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
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
                                                  "Email",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .bluegray800A2,
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.redA700A2,
                                                    fontSize: getFontSize(
                                                      14,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      CustomSearchView(
                                        isDark: isDark,
                                        width: 380,
                                        focusNode: FocusNode(),
                                        controller: autoLayoutHorOneController,
                                        hintText: "\"Email\"",
                                        margin: getMargin(
                                          top: 11,
                                        ),
                                        variant:
                                            SearchViewVariant.OutlineBluegray50,
                                        fontStyle: SearchViewFontStyle
                                            .SourceSansProSemiBold16,
                                        alignment: Alignment.centerLeft,
                                        suffix: Padding(
                                          padding: EdgeInsets.only(
                                            right: getHorizontalSize(
                                              15.00,
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed:
                                                autoLayoutHorOneController
                                                    .clear,
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
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
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
                              Padding(
                                padding: getPadding(
                                  left: 24,
                                  right: 24,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 1,
                                        bottom: 1,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: getPadding(
                                              top: 5,
                                            ),
                                            child: Text(
                                              "Message",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.bluegray800,
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
                                              bottom: 7,
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
                                    Padding(
                                      padding: getPadding(
                                        top: 4,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        "Max 250 words",
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
                              CustomTextFormField(
                                isDark: isDark,
                                width: 380,
                                focusNode: _messageFocusNode,
                                hintText: "\"Message\"",
                                margin: getMargin(
                                  top: 12,
                                ),
                                shape: TextFormFieldShape.RoundedBorder16,
                                padding: TextFormFieldPadding.PaddingAll18,
                                fontStyle: TextFormFieldFontStyle
                                    .SourceSansProSemiBold16Gray900,
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
                                maxLines: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        isDark: isDark,
                        width: 380,
                        text: "\"Send Message\"",
                        margin: getMargin(
                          left: 24,
                          top: 24,
                          right: 24,
                        ),
                        variant: ButtonVariant.FillBlueA100,
                        fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: getMargin(
                          top: 223,
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
