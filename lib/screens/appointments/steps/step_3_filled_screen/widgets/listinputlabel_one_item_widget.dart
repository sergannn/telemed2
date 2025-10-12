import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListinputlabelOneItemWidget extends StatelessWidget {
  ListinputlabelOneItemWidget({Key? key}) : super(key: key);

  TextEditingController autoLayoutHorOneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Container(
      margin: getMargin(
        top: 12.0,
        bottom: 12.0,
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
              width: getHorizontalSize(
                380.00,
              ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 3,
                            ),
                            child: Text(
                              "Phone Number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorConstant.bluegray800A2,
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
                              bottom: 5,
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
                  ),
                   CustomSearchView(isDark:isDark,
                    width: 380,
                    focusNode: FocusNode(),
                    controller: autoLayoutHorOneController,
                    hintText: "\"+62857-3637-8399\"",
                    margin: getMargin(
                      top: 11,
                    ),
                    variant: SearchViewVariant.OutlineBlueA400,
                    fontStyle:
                        SearchViewFontStyle.SourceSansProSemiBold16Gray900a2,
                    alignment: Alignment.centerLeft,
                    suffix: Padding(
                      padding: EdgeInsets.only(
                        right: getHorizontalSize(
                          15.00,
                        ),
                      ),
                      child: IconButton(
                        onPressed: autoLayoutHorOneController.clear,
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
    );
  }
}
