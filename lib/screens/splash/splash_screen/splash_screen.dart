import 'dart:async';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/splash/carousel_one_screen/carousel_one_screen.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CarouselOneScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VerticalSpace(height: 60),
            Padding(
              padding: getPadding(left: 24, right: 24),
              child: SizedBox(
                height: getVerticalSize(350),
                width: size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConstant.logoDecoration,
                      height: getVerticalSize(350),
                      width: size.width,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.appLogo,
                            height: getVerticalSize(140),
                            width: getHorizontalSize(140),
                          ),
                          Text(
                            "DoctorQ",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.blueA400,
                              fontSize: getFontSize(
                                44.418983459472656,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SpinKitCircle(
              color: ColorConstant.blueA400,
              size: 60,
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
