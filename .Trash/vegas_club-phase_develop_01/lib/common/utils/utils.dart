import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/service/navigator.service.dart';

class Utils {
  static Route createRouteBottomToTop(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static Route createRouteRightToLeft(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static String checkDate(BuildContext context, DateTime date) {
    DateTime dateTime = DateTime(date.year, date.month, date.day);
    DateTime dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (dateTime == dateNow) {
      return "today".translate(context);
    } else if (dateNow.difference(dateTime).inDays == 1) {
      return "yesterday".translate(context);
    } else if (dateNow.difference(dateTime).inDays == 2) {
      return "day_before_yesterday".translate(context);
    }

    // final formatter =
    //     DateFormat(DateFormat("dd MMM yyyy - HH:mm").format(date.toLocal()));
    return DateFormat("dd MMM yyyy - HH:mm a").format(date.toLocal());
  }

  static String checkDetailDate(BuildContext context, DateTime date) {
    DateTime dateTime = DateTime(date.year, date.month, date.day);
    DateTime dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (dateTime == dateNow) {
      return DateFormat("HH:mm").format(date);
    } else if (dateNow.difference(dateTime).inDays == 1) {
      return "yesterday".translate(context);
    }
    // else if (dateNow.difference(dateTime).inDays == 2) {
    //   return "day_before_yesterday".translate(context);
    // }

    final formatter = DateFormat("dd/MM/yyyy");
    return dateTime != null ? formatter.format(dateTime.toLocal()) : "-:-";
  }

  static String toDateAndTime(DateTime dateTime, {String? format}) {
    final formatter = DateFormat(format ?? "yyyy.MM.dd - HH:mm aa");
    return dateTime != null ? formatter.format(dateTime.toLocal()) : "-:-";
  }

  static getImageFromId(int id) {
    return "$baseUrl/api/v1/attachments/download/$id";
  }

  static int getNumberDateOfMonth() {
    DateTime firstDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime endDate =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    int date = endDate.difference(firstDate).inDays;
    return date;
  }

  static List<DateTime> getListDayOfCurrentWeek(DateTime dateTime) {
    DateTime now = DateTime.now();
    int weekDay = dateTime.weekday;
    DateTime firstDateOfWeek = now.subtract(Duration(days: weekDay - 1));
    List<DateTime> weekDates =
        List.generate(7, (index) => firstDateOfWeek.add(Duration(days: index)));
    print("week date: ${weekDates.toList()}");
    return weekDates;
  }

  static int getDateOfWeek(String dayOfWeek) {
    int day = -1;
    switch (dayOfWeek) {
      case "Everyday":
        day = 0;
        break;
      case "Monday":
        day = 1;
        break;
      case "Tuesday":
        day = 2;
        break;
      case "Wednesday":
        day = 3;
        break;
      case "Thursday":
        day = 4;
        break;
      case "Friday":
        day = 5;
        break;
      case "Saturday":
        day = 6;
        break;
      case "Sunday":
        day = 7;
        break;
      default:
        break;
    }
    return day;
  }

  void showSnackbar(String text) {
    var snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(
            locator.get<CommonService>().navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
