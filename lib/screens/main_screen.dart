import 'package:doctorq/app_export.dart';
import 'package:doctorq/chat/chat_screen.dart';
import 'package:doctorq/screens/history/history_screen.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/profile/blank_screen/blank_screen.dart';
import 'package:doctorq/screens/profile/settings_screen.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:doctorq/chat/main.dart';

// ignore: must_be_immutable
class Main extends StatelessWidget {
  //AppointmentsModel appointment;
  // String? user;
  // late String uId;
  // Home() {
  //   print(user);

  //   Map<String, dynamic> userData = jsonDecode(user ?? '{"user_id":"-1"}');
  //   print('its userdata');
  //   print(userData);
  //   uId = userData['user_id'] ?? '-1'; // Fallback to '-1' if user_id is missing
  //   print("uId::");
  //   print(uId);
  // }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ProfileBlankScreen(),
//      ProfileSettingsScreen(), //uId: uId ?? '-1'),
      const AppointmentsScreen(), //uId ?? '-1'),
      //   const HistoryScreen(),
    ];
  }

//  List<PersistentBottomNavBarItem> _navBarsItems() {
  List<PersistentTabConfig> _dNavBarsItems() {
    return [
      /*PersistentTabConfig(
          screen: _buildScreens()[0],
          item: ItemConfig(
            icon: Image.asset(
              ImageConstant.home,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            inactiveIcon: Image.asset(
              ImageConstant.inActiveHome,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            title: ("Домой"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),*/
      PersistentTabConfig(
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
          screen: _buildScreens()[0],
          item: ItemConfig(
            icon: SvgPicture.string(
              SvgConstant.chats,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            inactiveIcon: SvgPicture.string(
              SvgConstant.chats,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            title: ("Домой"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[1],
          item: ItemConfig(
            icon: SvgPicture.string(
              SvgConstant.chats,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            inactiveIcon: SvgPicture.string(
              SvgConstant.chats,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
            title: ("Профиль"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      PersistentTabConfig(
          screen: _buildScreens()[2],
          item: ItemConfig(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),

            title: ("Сеансы"),
            activeColorSecondary: ColorConstant.blueA400,
            //activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
            //inactiveColorPrimary: ColorConstant.blueA400,
          )),
      /*  PersistentTabConfig(
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

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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
    tabs.add(PersistentTabConfig(
        screen: ChatScreen(),
        item: ItemConfig(
          title: "Чаты",
          icon: SvgPicture.string(
            SvgConstant.chats,
            width: getHorizontalSize(30),
            height: getVerticalSize(30),
          ),
          inactiveIcon: SvgPicture.string(
            SvgConstant.chats,
            width: getHorizontalSize(30),
            height: getVerticalSize(30),
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.overlay),
          ),

          //   title: ("Помощник"),
          activeColorSecondary: ColorConstant.blueA400,
          // activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
          // inactiveColorPrimary: ColorConstant.blueA400,
        )));
    tabs.add(PersistentTabConfig(
        screen: ChatScreen(),
        item: ItemConfig(
          iconSize: 50,
          title: "Помощник",
          icon: Icon(
            Icons.chat,
            semanticLabel: "aa",
            //size: 15.0,
          ), // Image.asset(
          inactiveIcon: Icon(
            Icons.chat,
            semanticLabel: "aa",
          ),
//              width: getHorizontalSize(30), height: getVerticalSize(30)),

          //   title: ("Помощник"),
          activeColorSecondary: ColorConstant.blueA400,
          // activeColorPrimary: ColorConstant.blueA400.withOpacity(0.1),
          // inactiveColorPrimary: ColorConstant.blueA400,
        )));
    return PersistentTabView(
      //context,
      controller: _controller,
      //screens: _buildScreens(),
      tabs: tabs,
      navBarBuilder: (navBarConfig) => CustomBottomNavBar(
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
      /*
      decoration: NavBarDecoration(
        border: Border.all(
          color: isDark ? ColorConstant.darkLine : ColorConstant.lightLine,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        colorBehindNavBar: Colors.white,
      ),*/
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
    );
  }
}
//part of "../persistent_bottom_nav_bar_v2.dart";

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    super.key,
  }) : assert(
          navBarConfig.items.length.isOdd,
          "The number of items must be odd for this style",
        );

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

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
