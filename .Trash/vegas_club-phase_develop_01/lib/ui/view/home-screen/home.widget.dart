import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegas_club/ui/view/host-screen/host.screen.dart';
import 'package:vegas_club/ui/view/notification-screen/notification.screen.dart';
import 'package:vegas_club/ui/view/profile-screen/profile.screen.dart';
import 'package:vegas_club/ui/view/user-screen/user.screen.dart';
import 'package:vegas_club/view_model/profile_screen.viewmodel.dart';
import 'package:vegas_club/view_model/promo_calendart_screen.viewmodel.dart';

List<Widget> widgetOptions = [
  MultiProvider(providers: [
    ChangeNotifierProvider<PromoCalendarViewModel>(
        create: (_) => PromoCalendarViewModel()),
    ChangeNotifierProvider<ProfileViewModel>(create: (_) => ProfileViewModel()),
  ], child: const ProfileScreen()),
  const HostScreen(),
  // SizedBox(),
  const NotificationScreen(
    isBack: false,
    isRouteFromBottomBar: true,
  ),

  const UserScreen(),
];
