import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/list/messaging_ended_screen/messaging_ended_screen.dart';
import 'package:doctorq/screens/profile/settings/appearance_screen/appearance_screen.dart';
import 'package:doctorq/screens/profile/settings/help_screen/help_screen.dart';
import 'package:doctorq/screens/profile/settings/invite_friends_screen/invite_friends_screen.dart';
import 'package:doctorq/screens/profile/settings/logout_modal_bottomsheet/logout_modal_bottomsheet.dart';
import 'package:doctorq/screens/profile/settings/notification_screen/notification_screen.dart';
import 'package:doctorq/screens/profile/change_language.dart';
import 'package:doctorq/screens/profile/settings/security_screen/security_screen.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:doctorq/screens/profile/settings/schedule/schedule_screen.dart';
import 'package:doctorq/models/appointments_model.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/pub.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/api_service.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ProfileSettingsScreen> {
  File? _image;

  Future pickImage() async {
    var pr = await SharedPreferences.getInstance();
    print(pr.getString('user_id'));
    print(pr.getString('photo'));
    print("prefs");
    var status = await Permission.photos.request().isGranted;
    await Permission.mediaLibrary.request().isGranted;

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(pickedFile);
//    setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      if (_image != null) {
        await updateProfileWithImage(
          context,
          pickedFile.path,
          context.userData['first_name'],
          context.userData['email'],
        );

        setState(() {
          //  myDoctorSessions = context.userData;
          // userStore.setUser
        });
        //await uploadImageToLaravel(_image!);
      }
    } else {
      print('No image selected');
    }
    //  });
  }

  Widget sched(context, isRtl) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScheduleSettingsScreen()),
        );
      },
      child: Padding(
        padding: getPadding(top: 16.0, bottom: 16.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /* SizedBox(
                                            width: 500,
                                            height: 500,
                                            child: Text(
                                              jsonEncode(context.userData),
                                              maxLines: 5,
                                            )),*/
                CustomIconButton(
                  isRtl: isRtl,
                  height: 56,
                  width: 56,
                  variant: IconButtonVariant.FillBlueA40019,
                  shape: IconButtonShape.CircleBorder10,
                  padding: IconButtonPadding.PaddingAll16,
                  child: CommonImageView(
                    imagePath: ImageConstant.appearence,
                  ),
                ),
                HorizontalSpace(width: 16),
                Text(
                  "Мое расписание",
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
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorConstant.blueA400,
              size: getSize(20),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(context.userData);
    print("<<");
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
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
                        top: 4,
                        bottom: 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonImageView(
                            imagePath: ImageConstant.appLogo,
                            height: getVerticalSize(36),
                            width: getHorizontalSize(36),
                          ),
                          HorizontalSpace(width: 20),
                          Text(
                            context.userData['first_name'],
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
                        imagePath: ImageConstant.edit,
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
                    top: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
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
                              SizedBox(
                                height: getSize(
                                  100.00,
                                ),
                                width: getSize(
                                  100.00,
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    GestureDetector(
                                        onTap: pickImage,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              getHorizontalSize(
                                                50.00,
                                              ),
                                            ),
                                            child: CommonImageView(
                                              url: context.userData['photo'],
                                              height: getSize(
                                                100.00,
                                              ),
                                              width: getSize(
                                                100.00,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                    CustomIconButton(
                                      isRtl: isRtl,
                                      height: 20,
                                      width: 20,
                                      margin: getMargin(
                                        left: 10,
                                        top: 10,
                                      ),
                                      variant: IconButtonVariant.FillBlueA400,
                                      shape: IconButtonShape.CircleBorder10,
                                      padding: IconButtonPadding.PaddingAll3,
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                        ImageConstant.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              HorizontalSpace(width: 13),
                              Padding(
                                padding: getPadding(
                                  top: 11,
                                  bottom: 8,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 3,
                                      context.userData['username'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: getFontSize(
                                          23,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      maxLines: 3,
                                      context.userData['email'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: getFontSize(
                                          13,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            getMargin(left: 24, top: 10, right: 24, bottom: 0),
                        child: CustomDivider(isDark: isDark),
                      ),
                      FadeInUp(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileSettingsNotificationScreen()),
                                );
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.notifications,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Notification",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            if (context.userData['doctor_id'] != null)
                              sched(context, isRtl),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileSettingsSecurityScreen()),
                                );
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath: ImageConstant.security,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Security",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileSettingsAppearanceScreen()),
                                );
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath: ImageConstant.appearence,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Настройки цветов",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            /*Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    )),
                                    builder: (context) {
                                      return const ChangeLanguageScreen();
                                    });
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath: ImageConstant.reviews,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Language",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            
                            Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileSettingsHelpScreen()),
                                );
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath: ImageConstant.help,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Help",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileSettingsInviteFriendsScreen()),
                                );
                              },
                              child: Padding(
                                padding: getPadding(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 20,
                                    right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomIconButton(
                                          isRtl: isRtl,
                                          height: 56,
                                          width: 56,
                                          variant:
                                              IconButtonVariant.FillBlueA40019,
                                          shape: IconButtonShape.CircleBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll16,
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.inviteFriends,
                                          ),
                                        ),
                                        HorizontalSpace(width: 16),
                                        Text(
                                          "Invite Friends",
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
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstant.blueA400,
                                      size: getSize(20),
                                    )
                                  ],
                                ),
                              ),
                            ),*/
                            Container(
                              margin: getMargin(
                                left: 24,
                                right: 24,
                              ),
                              child: CustomDivider(isDark: isDark),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    )),
                                    builder: (context) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  50), // Adjust this value as needed
                                          child:
                                              ProfileSettingsLogoutModalBottomsheet(),
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: getPadding(
                                  left: 24,
                                  top: 15,
                                  bottom: 15,
                                  right: 24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomIconButton(
                                      isRtl: isRtl,
                                      height: 56,
                                      width: 56,
                                      variant: IconButtonVariant.FillRedA40019,
                                      shape: IconButtonShape.CircleBorder10,
                                      padding: IconButtonPadding.PaddingAll16,
                                      child: CommonImageView(
                                        imagePath: ImageConstant.logout,
                                      ),
                                    ),
                                    HorizontalSpace(width: 16),
                                    Text(
                                      "Выход",
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
                                  ],
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
