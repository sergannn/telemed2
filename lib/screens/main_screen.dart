import 'package:doctorq/app_export.dart';
import 'package:doctorq/persistent_bottom_nav_bar_v2-5.3.1/lib/persistent_bottom_nav_bar_v2.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen_forFuture.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      StoriesScreen()
      //   const HistoryScreen(),
    ];
  }

//  List<PersistentBottomNavBarItem> _navBarsItems() {
  List<PersistentTabConfig> _dNavBarsItems() {
    return [
      PersistentTabConfig(
          onSelectedTabPressWhenNoScreensPushed: () {
            print("hmmmm");
          },
          screen: _buildScreens()[1],
          item: ItemConfig(
            icon: SvgPicture.string(
              SvgConstant.zapisi,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            inactiveIcon: SvgPicture.string(
              SvgConstant.zapisi,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.overlay),
            ),
            title: ("Профиль"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[2],
          item: ItemConfig(
              icon: SvgPicture.string(
                SvgConstant.medkarta,
                width: getHorizontalSize(30),
                height: getVerticalSize(30),
              ),
              inactiveIcon: SvgPicture.string(SvgConstant.medkarta,
                  width: getHorizontalSize(30),
                  height: getVerticalSize(30),
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.overlay)))),
      //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
      //inactiveColorPrimary: ColorConstant.blueA400,

      PersistentTabConfig(
          screen: _buildScreens()[0],
          item: ItemConfig(
              icon: SvgPicture.string(
                SvgConstant.health,
                width: getHorizontalSize(30),
                height: getVerticalSize(30),
              ),
              inactiveIcon: SvgPicture.string(SvgConstant.health,
                  width: getHorizontalSize(30),
                  height: getVerticalSize(30),
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.overlay)))),
      //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
      //inactiveColorPrimary: ColorConstant.blueA400,

      /* PersistentTabConfig(
          screen: _buildScreens()[3],
          item: ItemConfig(
            icon: Image.asset(
              ImageConstant.history,
            ),
            inactiveIcon: Image.asset(
              ImageConstant.inActiveHome,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            title: ("История"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
*/
      /*   PersistentBottomNavBarItem(
        icon: Image.asset(
          ImageConstant.eventNote,
          // width: getHorizontalSize(26),
          // height: getVerticalSize(26),
        ),
        inactiveIcon: Image.asset(
          ImageConstant.inActiveEventNote,
          width: getHorizontalSize(33),
          height: getVerticalSize(33),
        ),
        title: ("Appointment"),
        activeColorSecondary: ColorConstant.blueA400,
        activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
        inactiveColorPrimary: ColorConstant.blueA400,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          ImageConstant.history,
          // width: getHorizontalSize(26),
          // height: getVerticalSize(26),
        ),
        inactiveIcon: Image.asset(
          ImageConstant.inActiveHistory,
          width: getHorizontalSize(30),
          height: getVerticalSize(30),
        ),
        title: ("History"),
        activeColorSecondary: ColorConstant.blueA400,
        activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
        inactiveColorPrimary: ColorConstant.blueA400,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          ImageConstant.person,
          // width: getHorizontalSize(26),
          // height: getVerticalSize(26),
        ),
        inactiveIcon: Image.asset(
          ImageConstant.inActivePerson,
          width: getHorizontalSize(30),
          height: getVerticalSize(30),
        ),
        title: ("Profile"),
        activeColorSecondary: ColorConstant.blueA400,
        activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
        inactiveColorPrimary: ColorConstant.blueA400,
      ),*/
    ];
  }

  List<PersistentTabConfig> _pNavBarsItems() {
    return [
      PersistentTabConfig(
          screen: _buildScreens()[2],
          item: ItemConfig(
            icon: Icon(Icons.border_color,
                color: const Color.fromARGB(255, 92, 92, 92)),
            inactiveIcon: Icon(
              Icons.border_color,
              size: 28,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
            title: ("Записи"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[1],
          item: ItemConfig(
            icon: Icon(Icons.chrome_reader_mode,
                color: const Color.fromARGB(255, 92, 92, 92)),
            inactiveIcon: Icon(
              Icons.chrome_reader_mode,
              size: 28,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
            title: ("Мед карта"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[0],
          item: ItemConfig(
            icon: Icon(
              Icons.house_siding_outlined,
              color: const Color.fromARGB(255, 37, 37, 37),
            ),
            title: ("Главная"),
            activeColorSecondary: ColorConstant.blueA400,
            inactiveIcon: Icon(
              Icons.house_siding_outlined,
              size: 28,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
          )),
      PersistentTabConfig(
          screen: _buildScreens()[3],
          item: ItemConfig(
            icon: Icon(Icons.favorite,
                color: const Color.fromARGB(255, 92, 92, 92)),
            inactiveIcon: Icon(
              Icons.favorite,
              size: 28,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
            title: ("Здоровье"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: MainProfileScreen(),
          item: ItemConfig(
            title: "Профиль",
            icon: Icon(Icons.account_box,
                color: const Color.fromARGB(255, 92, 92, 92)), // Image.asset(
            inactiveIcon: Icon(Icons.account_box,
                size: 28, color: const Color.fromARGB(255, 36, 36, 36)),
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
    var tabs =
        userData['patient_id'] != null ? _pNavBarsItems() : _dNavBarsItems();
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
            child: IconTheme(
              data: IconThemeData(
                size: item.iconSize,
                color: isSelected
                    ? item.activeForegroundColor
                    : item.inactiveForegroundColor,
              ),
              child: isSelected ? item.icon : item.inactiveIcon,
            ),
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
              child: IconTheme(
                data: IconThemeData(
                  size: item.iconSize,
                  color: isSelected
                      ? item.activeForegroundColor
                      : item.inactiveForegroundColor,
                ),
                child: isSelected ? item.icon : item.inactiveIcon,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final midIndex = (navBarConfig.items.length / 2).floor();

    return DecoratedNavBar(
      decoration: navBarDecoration,
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
