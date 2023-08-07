import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegas_club/common/utils/localizations.dart';

extension ValidText on String {
  String translate(BuildContext context) {
    return AppLocalizations.of(context)!.translate(toLowerCase());
  }
}

extension ValidNum on int {
  String toDecimal() {
    return NumberFormat.decimalPattern("vi").format(this);
  }

  String getDateOfWeekEn() {
    switch (this) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      default:
        return "Sun";
    }
  }
}

extension Validdouble on double {
  String toDecimal() {
    return NumberFormat.decimalPattern("en").format(this);
  }
}

extension ValidDate on DateTime {
  String parseDate(String format) {
    return DateFormat(format).format(this).toString();
  }

  DateTime toDayAfter(int day) {
    return add(Duration(days: day));
  }

  /// Get Month After number month
  DateTime toMonthAfter(int numberMonth) {
    return DateTime(year, month + numberMonth, day);
  }

  String toOnlyTime() {
    final formatter = DateFormat("HH:mm a");
    return formatter.format(toLocal());
  }

  String toDateString() {
    final formatter = DateFormat("yyyy MMM dd - HH:mm a");
    return formatter.format(toLocal());
  }

  String toDateFormatString(int day) {
    return "${DateFormat("HH:mm a ").format(toLocal())}${day.getDateOfWeekEn().toUpperCase()} ,${DateFormat("dd/MM/yyyy").format(toLocal())}";
  }

  String toFormatStringDateTime(String format) {
    return DateFormat(format).format(toLocal());
  }
}

extension NavigatorStateExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
