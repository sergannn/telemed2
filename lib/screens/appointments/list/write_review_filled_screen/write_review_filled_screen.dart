import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_radio_button.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/spacing.dart';

// ignore: must_be_immutable
class AppointmentsListWriteReviewFilledScreen extends StatefulWidget {
  ContactMethods contactMethod;
  AppointmentsModel appointment;
  AppointmentsListWriteReviewFilledScreen({Key? key, required this.contactMethod,required this.appointment}) : super(key: key);

  @override
  State<AppointmentsListWriteReviewFilledScreen> createState() => _AppointmentsListWriteReviewFilledScreenState();
}

class _AppointmentsListWriteReviewFilledScreenState extends State<AppointmentsListWriteReviewFilledScreen> {
  String radioGroup = "";

  List<String> radioList = ["yes", "no"];

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
       body:SafeArea(
          child:
           SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
              width: size.width,
              margin: getMargin(top: 26, bottom: 10),
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
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          'Write areview',
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
                  ],
                ),
              ),
            ),
            
              
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 37,
                    right: 24,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        94.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: widget.appointment.img,
                      height: getSize(
                        188.00,
                      ),
                      width: getSize(
                        188.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    218.00,
                  ),
                  margin: getMargin(
                    left: 24,
                    top: 40,
                    right: 24,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "How was your experience\nwith",
                          style: TextStyle(
                            color:isDark?Colors.white: ColorConstant.gray900,
                            fontSize: getFontSize(
                              20,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color:isDark?Colors.white: ColorConstant.gray900,
                            fontSize: getFontSize(
                              20,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: widget.appointment.name,
                          style: TextStyle(
                            color: ColorConstant.blueA400,
                            fontSize: getFontSize(
                              20,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "?",
                          style: TextStyle(
                            color:isDark?Colors.white: ColorConstant.gray900,
                            fontSize: getFontSize(
                              20,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                VerticalSpace(height: 24),
               RatingBar(
   initialRating: 0,
   itemSize: 32,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   ratingWidget: RatingWidget(
     full: Image.asset(ImageConstant.star),
     half: Image.asset(ImageConstant.starHalf),
     empty: Image.asset(ImageConstant.starBorder),
   ),
   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
   onRatingUpdate: (rating) {
     printLog('Rating $rating');
   },
),
               
                Container(
                  height: getVerticalSize(
                    1.00,
                  ),
                  width: getHorizontalSize(
                    380.00,
                  ),
                  margin: getMargin(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.bluegray50,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 28,
                    right: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Write a comment",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: isDark?Colors.white: ColorConstant.bluegray800,
                          fontSize: getFontSize(
                            16,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
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
                    ],
                  ),
                ),
                CustomTextFormField(isDark: isDark,
                  width: size.width,
                  focusNode: FocusNode(),
                  hintText:
                      "Tell people about your experience",
                  margin: getMargin(
                    left: 24,
                    top: 15,
                    right: 24,
                  ),
                  shape: TextFormFieldShape.RoundedBorder16,
                  padding: TextFormFieldPadding.PaddingAll18,
                 
                  textInputAction: TextInputAction.done,
                  suffix: Container(
                    margin: getMargin(
                      left: 11,
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
                  maxLines: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: getHorizontalSize(
                      328.00,
                    ),
                    margin: getMargin(
                      left: 24,
                      top: 30,
                      right: 24,
                    ),
                    child: Text(
                      "Would you recommend Dr. Jenny Wilson to your friends?",
                      maxLines: null,
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
                ),
                VerticalSpace(height: 12),
                Padding(
                  padding: getPadding(
                    left: 20,
                    right: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomRadioButton(
                        text: "Yes",
                        iconSize: 16,
                        value: radioList[0],
                        groupValue: radioGroup,
                        margin: getMargin(
                          top: 2,
                          bottom: 2,
                        ),
                        onChange: (value) {
                          radioGroup = value;
                          setState(() {
                            
                          });
                        },
                      ),
                      CustomRadioButton(
                        text: "No",
                        iconSize: 16,
                        value: radioList[1],
                        groupValue: radioGroup,
                        margin: getMargin(
                          left: 24,
                          top: 2,
                          bottom: 2,
                        ),
                        onChange: (value) {
                          radioGroup = value;
                          setState(() {
                            
                          });
                        },
                      ),
                    ],
                  ),
                ),
                CustomButton(isDark:isDark,
                  width: size.width,
                  text: "Submit Review",
                  margin: getMargin(
                    left: 24,
                    top: 34,
                    right: 24,
                    bottom: 20,
                  ),
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    Main()), (Route<dynamic> route) => false);
                  },
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
