import 'package:flutter/material.dart';
import 'package:doctorq/app_export.dart';

class AppointmentsLoader extends StatefulWidget {
  const AppointmentsLoader({Key? key}) : super(key: key);

  @override
  State<AppointmentsLoader> createState() => _AppointmentsLoaderState();
}

class _AppointmentsLoaderState extends State<AppointmentsLoader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_pulseAnimation, _rotationAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.blueA400,
                          ColorConstant.blueA400.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.blueA400.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            'Загрузка сеансов...',
            style: TextStyle(
              fontSize: getFontSize(16),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : ColorConstant.bluegray800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Пожалуйста, подождите',
            style: TextStyle(
              fontSize: getFontSize(14),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white70 : ColorConstant.bluegray700,
            ),
          ),
        ],
      ),
    );
  }
}

