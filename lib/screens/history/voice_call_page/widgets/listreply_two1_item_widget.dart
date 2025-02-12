import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../data_files/doctors_list.dart';
import '../../../../widgets/spacing.dart';
import '../../voice_call_details_screen/voice_call_details_screen.dart';

// ignore: must_be_immutable
class ListreplyTwo1ItemWidget extends StatelessWidget {
  ListreplyTwo1ItemWidget({Key? key, required this.index}) : super(key: key);

 int index;

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
bool isRtl = context.locale==Constants.arLocal;
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        ),
        onTap: (){
          Navigator.of(context,
          rootNavigator: true
          ).push(
   
    MaterialPageRoute(builder: (context)
 =>HistoryVoiceCallDetailsScreen(doctor: doctorList[index],)),
  );
        },
       
       child: Container(
          height: getVerticalSize(100),
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
              color:isDark?ColorConstant.darkLine: ColorConstant.bluegray50,
              width: getHorizontalSize(
                1.00,
              ),
            ),
          ),
          child: Row(
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                         borderRadius: BorderRadius.only(
                          topLeft:isRtl? Radius.circular(
                            getHorizontalSize(
                              0.00,
                            ),
                          ): Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ),
                          bottomLeft:isRtl?Radius.circular(
                            getHorizontalSize(
                              0.00,
                            ),
                          ): Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ),
                          bottomRight:isRtl?Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ): Radius.circular(
                            getHorizontalSize(
                              0.00,
                            ),
                          ),
                          topRight:isRtl?Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ): Radius.circular(
                            getHorizontalSize(
                              0.00,
                            ),
                          ),
                        ),
                     
                        child: CommonImageView(
                          imagePath: doctorList[index].img,
                          height: getSize(
                            100.00,
                          ),
                          width: getSize(
                            100.00,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      isRtl: isRtl,
                      height: 36,
                      width: 36,
                      margin: getMargin(
                        
                        top: 10,
                      ),
                      variant: IconButtonVariant.OutlineIndigoA20014_1,
                      shape: IconButtonShape.CustomBorderTL12,
                      alignment:isRtl?Alignment.bottomLeft: Alignment.bottomRight,
                      child: Image.asset(ImageConstant.call,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              HorizontalSpace(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            doctorList[index].name,
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
                          Padding(
                            padding: getPadding(
                              top: 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Voice Call',
                                     
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
                                Padding(
                                  padding: getPadding(
                                    left: 4,
                                    top: 1,
                                  ),
                                  child: Text(
                                    "-",
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
                                Padding(
                                  padding: getPadding(
                                    left: 4,
                                    bottom: 1,
                                  ),
                                  child: Text(
                                    'Completed',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: const Color(0xFF23A757)
                                              ,
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
                              top: 3,
                            ),
                            child: Text(
                              'Today, 11:00 - 11:30 AM',
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
                    Container(
                      margin: getMargin(
                          left: isRtl ? 20 : 0, right: isRtl ? 0 : 20),
                      padding: getPadding(all: 10),
                      height: getVerticalSize(44),
                      width: getHorizontalSize(44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorConstant.blueA400.withOpacity(0.1),
                      ),
                      child: Icon(Icons.arrow_forward_ios_rounded,
                      size: getSize(18),
                      color: ColorConstant.blueA400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
      
      ),
    );
  }

}
