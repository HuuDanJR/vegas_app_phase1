import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegas_club/models/promo_request.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/ui/view/booking-status-screen/history_booking.screen.dart';
import 'package:vegas_club/ui/view/booking-status-screen/list_car_booking.screen.dart';
import 'package:vegas_club/ui/view/coupon-list-screen/coupon_list.screen.dart';
import 'package:vegas_club/ui/view/error-screen/error.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/cart.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.widget.dart';
import 'package:vegas_club/ui/view/home-screen/home.screen.dart';
import 'package:vegas_club/ui/view/host-screen/history_call.screen.dart';
import 'package:vegas_club/ui/view/host-screen/host.screen.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_request.screen.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_reservation.screen.dart';
import 'package:vegas_club/ui/view/member-ship-screen/member_ship.screen.dart';
import 'package:vegas_club/ui/view/message-screen/message.screen.dart';
import 'package:vegas_club/ui/view/notification-screen/notification.screen.dart';
import 'package:vegas_club/ui/view/point-pyramid-screen/point_pyramid.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/detail_promotion_v2.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/jackpot_page.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/list_promotion_detail.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promo.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promo_calendar.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promotion_list.screen.dart';
import 'package:vegas_club/ui/view/qr-scanner-view/qr_scanner.screen.dart';
import 'package:vegas_club/ui/view/roulette-screen/roulette.screen.dart';
import 'package:vegas_club/ui/view/splash_screen.dart';
import 'package:vegas_club/ui/view/user-screen/chage_password.screen.dart';
import 'package:vegas_club/ui/view/user-screen/user.screen.dart';
import 'package:vegas_club/ui/view/voucher-list-screen/voucher_list.screen.dart';
import 'package:vegas_club/view_model/home_screen.viewmodel.dart';

import 'ui/view/video_stream_screen/video_stream_2.screen.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case LoginScreen.route:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case HomeScreen.route:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<HomeScreenViewModel>(
                create: (BuildContext context) => HomeScreenViewModel(),
                child: const HomeScreen()));
      case MessageScreen.route:
        return MaterialPageRoute(builder: (context) => const MessageScreen());
      case HistoryCallScreen.route:
        return MaterialPageRoute(builder: (context) => const HistoryCallScreen());
      case HistoryBooking.routeName:
        return MaterialPageRoute(builder: (context) => const HistoryBooking());
      case MachineReservationScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const MachineReservationScreen());
      case ListCarBookingScreen.routeName:
        return MaterialPageRoute(
            builder: ((context) => const ListCarBookingScreen()));
      case MachineRequestScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MachineRequestScreen());
      case QrScannerScreen.route:
        return MaterialPageRoute(builder: (context) => const QrScannerScreen());
      case ProductDetailWidget.route:
        return MaterialPageRoute(
            builder: (context) => ProductDetailWidget(
                  productResponse: arg as ProductResponse,
                ));
      case CartScreen.route:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      case FoodReservationScreen.route:
        return MaterialPageRoute(builder: (context) => const FoodReservationScreen());
      // case MyWidget.routeName:
      //   return MaterialPageRoute(builder: (context) => MyWidget());
      case VoucherListScreen.route:
        return MaterialPageRoute(builder: (context) => const VoucherListScreen());
      case CouponListScreen.route:
        return MaterialPageRoute(builder: (context) => const CouponListScreen());
      case PointPyramidScreen.route:
        return MaterialPageRoute(builder: (context) => const PointPyramidScreen());

      case PromoCalendarScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PromoCalendarScreen());
      // case JackpotScreen.route:
      //   return MaterialPageRoute(builder: (context) => JackpotScreen());
      case PromoScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PromoScreen());
      case VideoStream2Screeen.routeName:
        return MaterialPageRoute(builder: (context) => const VideoStream2Screeen());
      case RouletteScreen.routeName:
        return MaterialPageRoute(builder: (context) => const RouletteScreen());

      case HostScreen.route:
        return MaterialPageRoute(
            builder: (context) => HostScreen(
                  isBack: settings.arguments as bool,
                ));
      case MembershipScreen.route:
        return MaterialPageRoute(builder: (context) => const MembershipScreen());
      case Jackpotpage.route:
        return MaterialPageRoute(builder: (context) => const Jackpotpage());
      case UserScreen.routeName:
        return MaterialPageRoute(builder: (context) => const UserScreen());
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ChangePasswordScreen());
      case ListPromotionDetial.routeName:
        return MaterialPageRoute(
            builder: (context) => ListPromotionDetial(
                  listWidget: settings.arguments as List<PromotionDetailModel>,
                ));
      case NotificationScreen.route:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case DetailPromotionV2Screen.routeName:
        return MaterialPageRoute(
            builder: (context) => DetailPromotionV2Screen(
                  promotionDetailModel:
                      settings.arguments as PromotionDetailModel,
                ));

      case SplashScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen());
      //
      case ErrorScreen.route:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
      case PromotionListScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => PromotionListScreen(
                  promotions: settings.arguments as List<PromotionDetailModel>,
                ));
      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}
