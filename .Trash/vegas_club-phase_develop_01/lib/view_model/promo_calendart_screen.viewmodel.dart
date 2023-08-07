import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/promo_request.dart';
import 'package:vegas_club/models/response/calendar_promo_response.dart';
import 'package:vegas_club/models/response/date_of_season_response.dart';
import 'package:vegas_club/ui/share_widget/dropdown.widget.dart';

class PromoCalendarViewModel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  List<CalendarPromoResponse> listCalendarPromoResponse = [];
  List<PromotionListModel> listPromotionByDate = [];
  bool isShowAllTitle = false;
  bool isSelectedTitle = false;
  List<String> listDayOfWeek = [];
  int indexTitleSelected = -1;
  List<int> listDayOfMonth = [];
  List<DateOfSeasonResponse> listDayOfSeason = [];
  String color = '#fff';
  List<DropdownModel> listWeek = [
    DropdownModel(display: "week", value: "-1"),
    DropdownModel(display: "1 week", value: "1"),
    DropdownModel(display: "2 week", value: "2")
  ];
  int weekSelected = 0;
  Future<void> initData() async {
    listPromotionByDate = [];
    indexTitleSelected = -1;
    isShowAllTitle = false;
    isSelectedTitle = false;
    listDayOfWeek = [];
    listDayOfMonth = [];
    listDayOfSeason = [];
    weekSelected = 0;
    notifyListeners();
  }

  Future<void> setListWeek() async {
    weekSelected = weekSelected + 1;
    if(weekSelected > 2) {
      weekSelected = 0;
    }
    // List<DropdownModel> weekNum = listWeek.where((element) => int.parse(element.value!) == week).toList();
    // weekSelected = int.parse(listWeek[weekSelected].value!);
    notifyListeners();
  }

  void showAllTitle() {
    isShowAllTitle = !isShowAllTitle;

    notifyListeners();
  }

  void setItemCalendarSelected(
      CalendarPromoResponse calendarPromoResponse, int indexSelected) {
    if (indexTitleSelected != indexSelected) {
      indexTitleSelected = indexSelected;
      if (indexTitleSelected != -1) {
        listDayOfWeek = calendarPromoResponse.getListDayOfWeek();
        color = calendarPromoResponse.color!;
        if (calendarPromoResponse.getListDayOfMonth().isNotEmpty) {
          color = calendarPromoResponse.color!;
          listDayOfWeek = [];
          listDayOfSeason = [];
          listDayOfMonth = calendarPromoResponse.getListDayOfMonth();
        }
        if (calendarPromoResponse.getListDayOfSeason().isNotEmpty) {
          color = calendarPromoResponse.color!;
          listDayOfWeek = [];
          listDayOfMonth = [];
          listDayOfSeason = calendarPromoResponse.getListDayOfSeason();
        }
      } else {
        listDayOfWeek = [];
        listDayOfMonth = [];
        listDayOfSeason = [];
        color = "#fff";
      }
    } else {
      listDayOfWeek = [];
      listDayOfMonth = [];
      listDayOfSeason = [];
      color = "#fff";
      indexTitleSelected = -1;
    }
    notifyListeners();
  }

  Future<void> getPromoCalendar() async {
    try {
      List<CalendarPromoResponse> calendarPromoResponseTmp =
          await repo.getCalendarPromo("promotion_category");
      if (calendarPromoResponseTmp.isNotEmpty) {
        listCalendarPromoResponse = calendarPromoResponseTmp;
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getPromotionWidget(
      List<PromotionListModel> promotionListModel) async {
    listPromotionByDate.addAll(promotionListModel);
    notifyListeners();
  }
}
