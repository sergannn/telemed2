import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../app_export.dart';
import '../../widgets/spacing.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  
  @override
  Widget build(BuildContext context) {
   bool isDark =Theme.of(context).brightness==Brightness.dark;
bool isRtl = context.locale==Constants.arLocal;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: size.width,
            margin: getMargin(
              left: 20,
              top: 35,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Change Language",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getFontSize(
                      20,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: getPadding(
                      top: 4,
                      bottom: 3,
                    ),
                    child: Text(
                      "Done",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                      
                        fontSize: getFontSize(
                          14,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w500,
                        height: 1.29,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
            
              margin: getMargin(
                left: 24,
                top: 21,
                bottom: 10,
                right: 24,
              ),
            child: CustomDivider(isDark: isDark,
            
            ),
            ),
            InkWell(
              onTap: () async {
                setState(() async {
                  await context.setLocale(const Locale("en"));
                });
              },
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 10,
                  bottom: 10,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       
                       
                        Padding(
                          padding: getPadding(left: 14, right: 14),
                          child: Text(
                            "English (US)",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color:isDark?ColorConstant.bluegray400: ColorConstant.bluegray800,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                              height: 1.29,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isRtl?const SizedBox():
                   Icon(Icons.check_rounded,
                   color: ColorConstant.blueA400,
                   )
                
                  ],
                ),
              ),
            ),
            Container(
            
              margin: getMargin(
                left: 24,
                top: 10,
                bottom: 10,
                right: 24,
              ),
              child: CustomDivider(isDark: isDark,
            
            ),
            ),
            InkWell(
               onTap: () async {
                        setState(() async {
                         
                          await context.setLocale(const Locale("ar"));
                        });
                      },
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 10,
                  bottom: 10,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       
                      
                        Padding(
                          padding: getPadding(left: 14, right: 14),
                          child: Text(
                            "العربية",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color:isDark?ColorConstant.bluegray400: ColorConstant.bluegray800,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                              height: 1.29,
                            ),
                          ),
                        ),
                      ],
                    ),
                  isRtl?
                   Icon(Icons.check_rounded,
                   color: ColorConstant.blueA400,
                   ):const SizedBox()
                  
                  ],
                ),
              ),
            ),
            Container(
            
              margin: getMargin(
                left: 24,
                top: 10,
                bottom: 10,
                right: 24,
              ),
              child: CustomDivider(isDark: isDark,
            
            ),
            ),
         
         VerticalSpace(height: 50)
         
          ],
        ),
      ],
    );
  }
}