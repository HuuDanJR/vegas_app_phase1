import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vegas_club/ui/share_widget/modal_bottom_sheet_custom.dart';
import 'package:vegas_club/ui/view/home-screen/home.widget.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({
    Key? key,
    required this.onPageView,
  }) : super(key: key);

  final Function(int)? onPageView;
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  PersistentTabController? _controller;

  final int _selectedIndex = 0;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    // TODO: implement initState
    super.initState();
  }

  // void _onItemTapped(int index) {
  //   if (index != 3) {
  //     setState(() {
  //       _selectedIndex = index;
  //       widget.onPageView!(_selectedIndex);
  //     });
  //   } else {
  //     showModalBottomSheet(
  //         context: context,
  //         builder: (context) {
  //           return Container(
  //             height: 200,
  //             width: width(context),
  //           );
  //         });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: widgetOptions,
      items: [
        PersistentBottomNavBarItem(
          activeColorPrimary: ColorName.primary,
          inactiveColorPrimary: Colors.black,
          title: "Home",
          icon: const Icon(
            Icons.home,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: ColorName.primary,
          inactiveColorPrimary: Colors.black,
          title: "Hot line",
          icon: const Icon(Icons.phone_enabled_sharp),
        ),
        PersistentBottomNavBarItem(
          contentPadding: 0,
          activeColorPrimary: ColorName.primary,
          inactiveColorPrimary: Colors.black,
          title: "Notification",
          icon: Container(
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const SizedBox(
                  width: 30.0,
                  height: 40.0,
                  child: Icon(
                    Icons.notifications_none_outlined,
                  ),
                ),
                Consumer<NotificationScreenViewModel>(
                    builder: (context, model, _) {
                  if (model.sumNotification == 0) {
                    return const SizedBox();
                  }
                  return Positioned(
                    right: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: FittedBox(
                            child: Text(
                          model.sumNotification.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                      )),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
        PersistentBottomNavBarItem(
          onPressed: (BuildContext? contextTmp) {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const FractionallySizedBox(
                      heightFactor: 0.85, child: ModalCustomBottomSheet());
                });
          },
          activeColorPrimary: ColorName.primary,
          inactiveColorPrimary: Colors.black,
          title: "Menu",
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ],

      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
