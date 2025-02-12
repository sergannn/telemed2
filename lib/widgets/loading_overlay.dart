import 'package:flutter/material.dart';

import '../theme/color_constant.dart';
import '../theme/app_decoration.dart';
import '../theme/app_style.dart';
import '../theme/image_constant.dart';

import 'common_image_view.dart';

class MyOverlay {
  static final MyOverlay _singleton = MyOverlay._internal();
  factory MyOverlay() => _singleton;
  MyOverlay._internal();

  static OverlayEntry? _overlayEntry;
  static OverlayState? _overlayState;
  static bool _isVisible = false;

  static void show(BuildContext context) {
    if (!_isVisible) {
      _overlayState = Overlay.of(context);
      _overlayEntry = _createOverlayEntry();
      _overlayState!.insert(_overlayEntry!);
      _isVisible = true;
    }
  }

  static void hide() {
    if (_isVisible) {
      _overlayEntry!.remove();
      _isVisible = false;
    }
  }

  static OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return Container(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            hide();
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.hexFFF,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10.0,
                      offset: Offset(0.0, 2.0),
                      color: Color.fromRGBO(112, 121, 144, 0.2),
                    ),
                  ],
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                padding: const EdgeInsets.all(25),
                child: CommonImageView(
                  imagePath: ImageConstant.imgEmpty,
                  height: 50,
                ),
              ),
              Positioned(
                bottom: 5,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    'Загрузка',
                    textAlign: TextAlign.center,
                    style: AppStyle.txt16w400hex2789FF.copyWith(
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
