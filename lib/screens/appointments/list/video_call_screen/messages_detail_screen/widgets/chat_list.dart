import 'package:doctorq/widgets/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../app_export.dart';
import '../../../../../../data_files/chat_list.dart';

// ignore: must_be_immutable
class ChatListWidget extends StatelessWidget {
  int index;
  ChatListWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Container(
      child: chatList[index].isMine
          ? Align(
              alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: getHorizontalSize(
                  300.00,
                ),
                padding: getPadding(
                  left: 14,
                  right: 14,
                  top: 16,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.blueA400,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                    bottomRight: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                    topRight: Radius.circular(
                      getHorizontalSize(
                        0.00,
                      ),
                    ),
                    bottomLeft: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: getHorizontalSize(
                        207.00,
                      ),
                      child: Text(
                        chatList[index].msg,
                        maxLines: null,
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
                    HorizontalSpace(width: 24),
                    Align(
                      alignment:
                          isRtl ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        "8:12 Am",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.whiteA700,
                          fontSize: getFontSize(
                            12,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Align(
              alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: getHorizontalSize(
                  300.00,
                ),
                padding: getPadding(
                  left: 14,
                  right: 14,
                  top: 16,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? ColorConstant.darkContainer
                      : ColorConstant.gray100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      getHorizontalSize(
                        0.00,
                      ),
                    ),
                    topRight: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                    bottomRight: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                    bottomLeft: Radius.circular(
                      getHorizontalSize(
                        15.00,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: getHorizontalSize(
                        207.00,
                      ),
                      child: Text(
                        chatList[index].msg,
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.bluegray400,
                          fontSize: getFontSize(
                            14,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment:
                          isRtl ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        "8:12 Am",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.bluegray400,
                          fontSize: getFontSize(
                            12,
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
    );
  }
}
