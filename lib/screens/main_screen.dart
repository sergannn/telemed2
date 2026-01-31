import 'package:doctorq/app_export.dart';
import 'package:doctorq/persistent_bottom_nav_bar_v2-5.3.1/lib/persistent_bottom_nav_bar_v2.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
//import 'package:doctorq/screens/appointments/AppointmentsScreenDoctor.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen_forFuture.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/screens/profile/health_screen.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/theme/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Виджет для отображения иконок из Figma с поддержкой активного/неактивного состояния
class FigmaIcon extends StatelessWidget {
  final String imagePath;
  final bool isActive;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;

  const FigmaIcon({
    Key? key,
    required this.imagePath,
    this.isActive = false,
    this.size,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 24.0;
    final Color color = isActive 
        ? (activeColor ?? const Color.fromARGB(255, 36, 36, 36))
        : (inactiveColor ?? const Color.fromARGB(255, 92, 92, 92));

    return SvgPicture.asset(
      imagePath,
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      allowDrawingOutsideViewBox: true,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => SizedBox(
        width: iconSize,
        height: iconSize,
      ),
      errorBuilder: (context, error, stackTrace) {
        print('Ошибка загрузки SVG: $imagePath');
        print('Ошибка: $error');
        print('Stack trace: $stackTrace');
        // Fallback на стандартную иконку при ошибке
        return Icon(
          Icons.circle,
          size: iconSize,
          color: color,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class Main extends StatelessWidget {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      MedCardScreen(),
      //   HomeSpecialistDoctorScreen(),
//      ProfileBlankScreen(),
//      ProfileSettingsScreen(), //uId: uId ?? '-1'),
      const AppointmentsScreen(), //uId ?? '-1'),
      StoriesScreen(),
      HealthScreen()
      //   const HistoryScreen(),
    ];
  }



  List<PersistentTabConfig> _pNavBarsItems() {
    return [
      PersistentTabConfig(
          screen: _buildScreens()[2],
          item: ItemConfig(
            icon: FigmaIcon(
              imagePath: ImageConstant.iconAppointments,
              isActive: true,
              size: 28,
              activeColor: const Color.fromARGB(255, 36, 36, 36),
            ),
            inactiveIcon: FigmaIcon(
              imagePath: ImageConstant.iconAppointments,
              isActive: false,
              size: 28,
              inactiveColor: const Color.fromARGB(255, 92, 92, 92),
            ),
            title: ("Записи"),
            activeColorSecondary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[1],
          item: ItemConfig(
            icon: FigmaIcon(
              imagePath: ImageConstant.iconMyArticles,
              isActive: true,
              size: 28,
              activeColor: const Color.fromARGB(255, 36, 36, 36),
            ),
            inactiveIcon: FigmaIcon(
              imagePath: ImageConstant.iconMyArticles,
              isActive: false,
              size: 28,
              inactiveColor: const Color.fromARGB(255, 92, 92, 92),
            ),
            title: ("Мои статьи"),
            activeColorSecondary: ColorConstant.blueA400,
          )),
     PersistentTabConfig(
          screen: _buildScreens()[0],
          item: ItemConfig(
            icon: Icon(
              Icons.house_siding_outlined,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
            title: ("Главная"),
            activeColorSecondary: ColorConstant.blueA400,
            inactiveIcon: Icon(
              Icons.house_siding_outlined,
              size: 28,
              color: const Color.fromARGB(255, 92, 92, 92),
            ),
          )),
      PersistentTabConfig(
          screen: _buildScreens()[4],
          item: ItemConfig(
            icon: FigmaIcon(
              imagePath: ImageConstant.iconHealth,
              isActive: true,
              size: 28,
              activeColor: const Color.fromARGB(255, 36, 36, 36),
            ),
            inactiveIcon: FigmaIcon(
              imagePath: ImageConstant.iconHealth,
              isActive: false,
              size: 28,
              inactiveColor: const Color.fromARGB(255, 92, 92, 92),
            ),
            title: ("Здоровье"),
            activeColorSecondary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: MainProfileScreen(),
          item: ItemConfig(
            title: "Профиль",
            icon: FigmaIcon(
              imagePath: ImageConstant.iconChats,
              isActive: true,
              size: 28,
              activeColor: const Color.fromARGB(255, 36, 36, 36),
            ),
            inactiveIcon: FigmaIcon(
              imagePath: ImageConstant.iconChats,
              isActive: false,
              size: 28,
              inactiveColor: const Color.fromARGB(255, 92, 92, 92),
            ),
            activeColorSecondary: ColorConstant.blueA400,
          ))
    ];
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserStore storeUserStore = getIt.get<UserStore>();
    Map<dynamic, dynamic> userData = storeUserStore.userData;
    print("its build main");
    print(userData);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var tabs = _pNavBarsItems();
//        userData['patient_id'] != null ? _pNavBarsItems() : _dNavBarsItems();
// Добавьте этот метод

    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            // Handle blocked back navigation
            print('Back navigation prevented');
          }
        },
        child: PersistentTabView(
          // avoidBottomPadding: false,

          //context,
          controller: _controller,
          //screens: _buildScreens(),
          tabs: tabs,
          navBarBuilder: (navBarConfig) => CustomBottomNavBar(
            controller: _controller,
            navBarConfig: navBarConfig,
          ),

          //confineInSafeArea: true,
          backgroundColor: isDark
              ? ColorConstant.darkBg
              : Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBar:
              false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          /*itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),*/
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            // animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),

          //navBarStyle:
          //    NavBarStyle.style9, // Choose the nav bar style with this property.
          navBarHeight: getVerticalSize(70),
        ));
  }
}
//part of "../persistent_bottom_nav_bar_v2.dart";

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    required this.navBarConfig,
    required this.controller,
    this.navBarDecoration = const NavBarDecoration(),
    super.key,
  }) : assert(
          navBarConfig.items.length.isOdd,
          "The number of items must be odd for this style",
        );

  final NavBarConfig navBarConfig;
  final PersistentTabController controller;

  final NavBarDecoration navBarDecoration;
  
  Widget buildMiddleItemForTest(ItemConfig item, bool isSelected) {
    return _buildMiddleItem(item, isSelected);
  }

  Widget buildItemForTest(ItemConfig item, bool isSelected) {
    return _buildItem(item, isSelected);
  }

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: isSelected ? item.icon : item.inactiveIcon,
          ),
          if (item.title != null)
            FittedBox(
              child: Text(
                item.title! + '',
                style: item.textStyle.apply(
                  color: isSelected
                      ? item.activeForegroundColor
                      : item.inactiveForegroundColor,
                ),
              ),
            ),
        ],
      );

  Widget _buildMiddleItem(ItemConfig item, bool isSelected) => Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
//          color: item.activeForegroundColor,
            color: ColorConstant.fromHex("C8E0FF")),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: isSelected ? item.icon : item.inactiveIcon,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final midIndex = (navBarConfig.items.length / 2).floor();

    return DecoratedNavBar(
      decoration: NavBarDecoration(
        color: Colors.white, // Явно указываем белый фон
        padding: navBarDecoration.padding,
        filter: navBarDecoration.filter,
        border: navBarDecoration.border,
        borderRadius: navBarDecoration.borderRadius,
        boxShadow: navBarDecoration.boxShadow,
        gradient: navBarDecoration.gradient,
        backgroundBlendMode: navBarDecoration.backgroundBlendMode,
        shape: navBarDecoration.shape,
      ),
      filter: navBarConfig.selectedItem.filter,
      opacity: navBarConfig.selectedItem.opacity,
      height: navBarConfig.navBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navBarConfig.items.map((item) {
          final int index = navBarConfig.items.indexOf(item);
          return Expanded(
            child: InkWell(
              onTap: () {
                navBarConfig.onItemSelected(index);
              },
              child: index == midIndex
                  ? _buildMiddleItem(
                      item,
                      navBarConfig.selectedIndex == index,
                    )
                  : _buildItem(
                      item,
                      navBarConfig.selectedIndex == index,
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
