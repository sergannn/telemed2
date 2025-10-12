import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListfullnameOne2ItemWidget extends StatelessWidget {
  const ListfullnameOne2ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: getPadding(
          top: 7.2999955,
          right: 39,
          bottom: 7.2999955,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: getPadding(
                bottom: 1,
              ),
              child: Text(
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
            ),
            Padding(
              padding: getPadding(
                left: 20,
                top: 1,
              ),
              child: Text(
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
            ),
            Padding(
              padding: getPadding(
                left: 8,
                bottom: 1,
              ),
              child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
