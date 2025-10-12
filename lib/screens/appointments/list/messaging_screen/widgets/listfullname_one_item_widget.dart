import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListfullnameOneItemWidget extends StatelessWidget {
  const ListfullnameOneItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Full Name",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
          HorizontalSpace(width: 20),
          Text(
            ":",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
         
         HorizontalSpace(width: 8),
          Text(
            "Adam Smith",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: getFontSize(
                16,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
 
 
  }
}
