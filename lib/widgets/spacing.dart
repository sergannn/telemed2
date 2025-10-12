import 'package:flutter/material.dart';
import '../app_export.dart';

// ignore: must_be_immutable
class HorizontalSpace extends StatelessWidget {
  double width;
  HorizontalSpace(
    {Key? key, 
      required this.width
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(width),
    );
  }
}



// ignore: must_be_immutable
class VerticalSpace extends StatelessWidget {
  double height;
  VerticalSpace(
    {Key? key, 
      required this.height
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getVerticalSize(height),
    );
  }
}


// ignore: must_be_immutable
class CustomDivider extends StatelessWidget {

   CustomDivider({
    Key? key,
    required this.isDark,
    this.bottomPadding=0,
    this.topPadding=0,
  
  }) : super(key: key);

  final bool isDark;
  double topPadding;
  double bottomPadding;
 


  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;

    return Container(
      height: 1,
      width: size.width,
      margin: getMargin(
      
     top: topPadding,
     bottom: bottomPadding
      ),
      color:isDark?ColorConstant.darkLine: ColorConstant.bluegray50,
     );
  }
}

