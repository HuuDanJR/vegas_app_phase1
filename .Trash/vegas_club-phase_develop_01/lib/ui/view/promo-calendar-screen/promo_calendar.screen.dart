import 'dart:async';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/promo_request.dart';
import 'package:vegas_club/models/response/calendar_promo_response.dart';
import 'package:vegas_club/models/response/date_of_season_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/detail_promotion_v2.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promotion_list.screen.dart';
import 'package:vegas_club/view_model/promo_calendart_screen.viewmodel.dart';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class PromoCalendarScreen extends StateFullConsumer {
  const PromoCalendarScreen({Key? key}) : super(key: key);
  static const String routeName = '/promo-calendar-screen';
  @override
  _PromoCalendarScreenState createState() => _PromoCalendarScreenState();
}

class _PromoCalendarScreenState extends StateConsumer<PromoCalendarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DateTime> _listCurrentDateInWeek = [];
  List<Widget> _listDateWidget = [];
  List<PromotionListModel> _listPromotionWidget = [];
  Timer? _timer;
  @override
  void initStateWidget() {
    _listDateWidget = [];
    _listPromotionWidget = [];
    _listCurrentDateInWeek = Utils.getListDayOfCurrentWeek(DateTime.now());
    Provider.of<PromoCalendarViewModel>(context, listen: false).initData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer(const Duration(milliseconds: 1000), () {
        Provider.of<PromoCalendarViewModel>(context, listen: false)
            .getPromoCalendar();
      });
    });

  }

  @override
  void disposeWidget() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  List<PromoRequest> _getPromotion(
      List<CalendarPromoResponse> listCalendarPromoResponse) {
    List<PromoRequest> listPromo = [];
    listCalendarPromoResponse.map((e) {
      // get list day of week
      e.getListDayOfWeek().map((itemDate) {
        if (Utils.getDateOfWeek(itemDate) != -1) {
          listPromo.addAll(_insertWidgetPromotion(
              color: e.color ?? '',
              term: e.terms,
              prize: e.prize,
              name: e.name ?? '',
              dayOfWeek: Utils.getDateOfWeek(itemDate),
              attachmentId: e.attachmentId!));
        }
      }).toList();
      listPromo.addAll(_insertWidgetPromotion(
          color: e.color ?? '',
          term: e.terms,
          prize: e.prize,
          name: e.name ?? '',
          dayOfMonth: e.getListDayOfMonth(),
          attachmentId: e.attachmentId!));

      if (e.getListDayOfSeason().isNotEmpty) {
        listPromo.addAll(_insertWidgetPromotion(
            color: e.color ?? '',
            term: e.terms,
            prize: e.prize,
            name: e.name ?? '',
            dayOfSeason: e.getListDayOfSeason(),
            attachmentId: e.attachmentId!));
      }
    }).toList();
    return listPromo;
  }

  List<PromoRequest> _insertWidgetPromotion(
      {int? dayOfWeek,
      String? name,
      List<int>? dayOfMonth,
      String? term,
      String? prize,
      List<DateOfSeasonResponse>? dayOfSeason,
      String? color,
      int? attachmentId}) {
    List<PromoRequest> listPromo = [];
    if (dayOfWeek == 0) {
      int numDate = Utils.getNumberDateOfMonth();
      for (int i = 1; i <= numDate; i++) {
        listPromo.add(PromoRequest(
          day: [i],
          widgetColor: _promotionWidgetColor(color ?? ''),
          widget: _promotionWidget(attachmentId!),
          promotionDetailModel: PromotionDetailModel(
              attachmentId: attachmentId,
              name: name ?? '',
              term: term ?? '',
              prize: prize ?? '',
              color: color ?? ''),
        ));
      }
    } else if (dayOfWeek != null && dayOfWeek != 0) {
      listPromo.add(PromoRequest(
        dateOfWeek: dayOfWeek,
        widgetColor: _promotionWidgetColor(color ?? ''),
        widget: _promotionWidget(attachmentId!),
        promotionDetailModel: PromotionDetailModel(
            attachmentId: attachmentId,
            color: color ?? '',
            name: name ?? '',
            term: term ?? '',
            prize: prize ?? ''),
      ));
    }
    if (dayOfMonth != null && dayOfMonth.isNotEmpty) {
      if (dayOfMonth.isNotEmpty) {
        dayOfMonth.map((e) {
          listPromo.add(PromoRequest(
            dayOfMonth: [e],
            widgetColor: _promotionWidgetColor(color ?? ''),
            widget: _promotionWidget(attachmentId!),
            promotionDetailModel: PromotionDetailModel(
                color: color ?? '',
                attachmentId: attachmentId,
                name: name ?? '',
                term: term ?? '',
                prize: prize ?? ''),
          ));
        }).toList();
      }
    }
    if (dayOfSeason != null && dayOfSeason.isNotEmpty) {
      if (dayOfSeason.isNotEmpty) {
        dayOfSeason.map((e) {
          listPromo.add(PromoRequest(
            dayOfMonth: e.day,
            month: e.month,
            widgetColor: _promotionWidgetColor(color ?? ''),
            widget: _promotionWidget(attachmentId!),
            promotionDetailModel: PromotionDetailModel(
                color: color ?? '',
                attachmentId: attachmentId,
                name: name ?? '',
                term: term ?? '',
                prize: prize ?? ''),
          ));
        }).toList();
      }
    }

    return listPromo;
  }

  Widget _promotionWidget(int attachmentId) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        child: Image.network(
          Utils.getImageFromId(attachmentId),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget? _promotionWidgetColor(String? color) {
    if (color == null) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: fromCssColor(
              color,
            )),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<PromoCalendarViewModel>(builder: (context, model, _) {
            return SingleChildScrollView(
              child: Consumer<PromoCalendarViewModel>(
                  builder: (BuildContext context, PromoCalendarViewModel model,
                      Widget? child) {
                    List<PromoRequest> listWidget =
                        _getPromotion(model.listCalendarPromoResponse);
                    if (listWidget.isEmpty) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: loadingWidget()));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height *
                              (model.weekSelected == 1
                                  ? 0.17
                                  : (model.weekSelected == 2 ? 0.25 : 0.4)),
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                          child: Stack(
                            children: [
                              SfCalendar(
                                cellBorderColor: Colors.grey,
                                blackoutDatesTextStyle:
                                    const TextStyle(color: ColorName.iconColor),
                                selectionDecoration: const BoxDecoration(
                                    borderRadius: BorderRadius.zero,
                                    // border: Border.all(
                                    //     color: ColorName.primary2, width: 1),
                                    color: Colors.white10),
                                allowViewNavigation: false,
                                allowDragAndDrop: false,
                                view: CalendarView.month,
                                // dataSource: MeetingDataSource(_getDataSource()),
                                showCurrentTimeIndicator: true,
                                allowAppointmentResize: true,
                                todayHighlightColor: ColorName.primary2,
                                // headerHeight: 0.0,

                                onTap: (calendarTapDetails) {
                                  List<PromoRequest> listPromoDayOfMonth =
                                      listWidget
                                          .where((element) =>
                                              (element.dayOfMonth ?? [])
                                                  .where((ele) =>
                                                      ele ==
                                                      calendarTapDetails
                                                          .date!.day)
                                                  .toList()
                                                  .isNotEmpty &&
                                              element.month == null)
                                          .toList();

                                  List<PromoRequest> listDay = listWidget
                                      .where((element) =>
                                          (element.day != null
                                              ? element.day![0]
                                              : -1) ==
                                          calendarTapDetails.date!.day)
                                      .toList();
                                  List<PromoRequest> listDateOfWeek = listWidget
                                      .where((element) =>
                                          element.dateOfWeek ==
                                          calendarTapDetails.date!.weekday)
                                      .toList();
                                  List<PromoRequest> listDateOfSeasion =
                                      listWidget
                                          .where((element) =>
                                              element.month ==
                                              calendarTapDetails.date!.month)
                                          .toList();

                                  List<PromotionDetailModel>
                                      listWidgetPromotion = [];
                                  if (listDay.isNotEmpty) {
                                    listDay.map((e) {
                                      listWidgetPromotion
                                          .add(e.promotionDetailModel!);
                                    }).toList();
                                  }
                                  if (listDateOfWeek.isNotEmpty) {
                                    listDateOfWeek.map((e) {
                                      listWidgetPromotion
                                          .add(e.promotionDetailModel!);
                                    }).toList();
                                  }
                                  if (listPromoDayOfMonth.isNotEmpty) {
                                    listPromoDayOfMonth.map((e) {
                                      listWidgetPromotion
                                          .add(e.promotionDetailModel!);
                                    }).toList();
                                  }
                                  if (listDateOfSeasion.isNotEmpty) {
                                    listDateOfSeasion.map((e) {
                                      e.dayOfMonth!.map((itemDays) {
                                        if (itemDays ==
                                            calendarTapDetails.date!.day) {
                                          listWidgetPromotion
                                              .add(e.promotionDetailModel!);
                                        }
                                      }).toList();
                                    }).toList();
                                  }
                                  if (calendarTapDetails.date!.month ==
                                          DateTime.now().month &&
                                      calendarTapDetails.date!.year ==
                                          DateTime.now().year) {
                                    // pushNamed(ListPromotionDetial.routeName,
                                    //     arguments: listWidgetPromotion);
                                    pushNamed(PromotionListScreen.routeName,
                                        arguments: listWidgetPromotion);
                                  }
                                },
                                headerStyle: const CalendarHeaderStyle(
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        // letterSpacing: 5,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                // showWeekNumber: true,
                                monthCellBuilder: (context, builder) {
                                  List<PromotionDetailModel> promotionWidget =
                                      [];
                                  List<DateTime> dateInCurrentWeek =
                                      _listCurrentDateInWeek
                                          .where(
                                            (element) => (DateTime(
                                                    element.year,
                                                    element.month,
                                                    element.day) ==
                                                DateTime(
                                                    builder.date.year,
                                                    builder.date.month,
                                                    builder.date.day)),
                                          )
                                          .toList();
                                  if (dateInCurrentWeek.isNotEmpty) {
                                    print("asdas");
                                  }

                                  List<PromoRequest> listPromoDayOfMonth =
                                      listWidget
                                          .where((element) =>
                                              (element.dayOfMonth ?? [])
                                                  .where((ele) =>
                                                      ele == builder.date.day)
                                                  .toList()
                                                  .isNotEmpty &&
                                              element.month == null)
                                          .toList();

                                  List<PromoRequest> listDay = listWidget
                                      .where((element) =>
                                          (element.day != null
                                              ? element.day![0]
                                              : -1) ==
                                          builder.date.day)
                                      .toList();
                                  List<PromoRequest> listDateOfWeek = listWidget
                                      .where((element) =>
                                          element.dateOfWeek ==
                                          builder.date.weekday)
                                      .toList();
                                  List<PromoRequest> listDateOfSeason =
                                      listWidget
                                          .where((element) =>
                                              element.month ==
                                              builder.date.month)
                                          .toList();

                                  List<Widget> listWidgetPromotion = [];
                                  if (listDay.isNotEmpty) {
                                    listDay.map((e) {
                                      // listWidgetPromotion.add(e.widget!);
                                      _listDateWidget.add(e.widget!);
                                      promotionWidget
                                          .add(e.promotionDetailModel!);
                                      listWidgetPromotion.add(e.widgetColor!);
                                    }).toList();
                                  }
                                  if (listDateOfWeek.isNotEmpty) {
                                    listDateOfWeek.map((e) {
                                      // listWidgetPromotion.add(e.widget!);
                                      _listDateWidget.add(e.widget!);
                                      promotionWidget
                                          .add(e.promotionDetailModel!);
                                      listWidgetPromotion.add(e.widgetColor!);
                                    }).toList();
                                  }
                                  if (listPromoDayOfMonth.isNotEmpty) {
                                    listPromoDayOfMonth.map((e) {
                                      // listWidgetPromotion.add(e.widget!);
                                      _listDateWidget.add(e.widget!);
                                      promotionWidget
                                          .add(e.promotionDetailModel!);
                                      listWidgetPromotion.add(e.widgetColor!);
                                    }).toList();
                                  }
                                  if (listDateOfSeason.isNotEmpty) {
                                    listDateOfSeason.map((e) {
                                      e.dayOfMonth!.map((itemDays) {
                                        if (itemDays == builder.date.day) {
                                          // listWidgetPromotion.add(e.widget!);
                                          _listDateWidget.add(e.widget!);
                                          promotionWidget
                                              .add(e.promotionDetailModel!);
                                          listWidgetPromotion
                                              .add(e.widgetColor!);
                                        }
                                      }).toList();
                                    }).toList();
                                  }
                                  if (dateInCurrentWeek.isNotEmpty &&
                                      _listPromotionWidget.length < 7) {
                                    _listPromotionWidget.add(PromotionListModel(
                                        date: dateInCurrentWeek.first,
                                        promotion: promotionWidget));
                                    if (_listPromotionWidget.length == 7) {
                                      Future.delayed(Duration.zero, () {
                                        List<PromotionListModel> listPromo =
                                            _listPromotionWidget;
                                        Provider.of<PromoCalendarViewModel>(
                                                context,
                                                listen: false)
                                            .getPromotionWidget(listPromo);
                                      });
                                    }
                                  }

                                  return _itemDayWithColorDot(
                                      builder,
                                      listWidgetPromotion,
                                      model.listDayOfWeek,
                                      model.listDayOfMonth,
                                      model.listDayOfSeason,
                                      model.color);
                                },
                                monthViewSettings: MonthViewSettings(
                                    dayFormat: "EEE",
                                    numberOfWeeksInView: model.weekSelected == 0
                                        ? 6
                                        : (model.weekSelected == 1 ? 1 : 2),
                                    monthCellStyle: const MonthCellStyle(
                                      // trailingDatesBackgroundColor: Colors.black,
                                      todayBackgroundColor: Colors.red,

                                      backgroundColor: Colors.red,
                                      leadingDatesBackgroundColor: Colors.red,
                                      trailingDatesBackgroundColor: Colors.red,
                                    ),
                                    showTrailingAndLeadingDates: true,
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 6.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<PromoCalendarViewModel>(
                                              context,
                                              listen: false)
                                          .setListWeek();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        child: Text(model.weekSelected == 0
                                            ? "Week"
                                            : (model.weekSelected == 1)
                                                ? "1 Week"
                                                : "2 Week")),
                                  )),
                            ],
                          ),
                        ),
                        _listNote(model.listCalendarPromoResponse, model),
                      ],
                    );
                  },
                  child: const SizedBox()),
            );
          })),
    );
  }

  Widget _listNote(List<CalendarPromoResponse> listCalendarPromoResponse,
      PromoCalendarViewModel model) {
    List<Widget> listNote = [];

    for (int i = 0; i < listCalendarPromoResponse.length; i++) {
      Widget itemNote = SizedBox(
        width: 100.0,
        child: GestureDetector(
          onTap: () {
            Provider.of<PromoCalendarViewModel>(context, listen: false)
                .setItemCalendarSelected(listCalendarPromoResponse[i], i);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => DetailPromotionScreen(
            //           data: {
            //             "term": e.terms,
            //             "prize": e.prize,
            //           },
            //         )));
          },
          child: Container(
            decoration: BoxDecoration(
                color: model.indexTitleSelected == i
                    ? Colors.black12
                    : Colors.white,
                border: Border(
                    top: i > 1
                        ? BorderSide.none
                        : const BorderSide(width: 0.5, color: Colors.grey),
                    left: i % 2 != 0
                        ? BorderSide.none
                        : const BorderSide(width: 0.5, color: Colors.grey),
                    right: const BorderSide(width: 0.5, color: Colors.grey),
                    bottom: const BorderSide(width: 0.5, color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color:
                            fromCssColor(listCalendarPromoResponse[i].color!),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      (listCalendarPromoResponse[i].name ?? '').toUpperCase(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 8.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pushNamed(DetailPromotionV2Screen.routeName,
                          arguments: PromotionDetailModel(
                              attachmentId:
                                  listCalendarPromoResponse[i].attachmentId,
                              name: listCalendarPromoResponse[i].name,
                              term: listCalendarPromoResponse[i].terms,
                              prize: listCalendarPromoResponse[i].prize,
                              color: listCalendarPromoResponse[i].color));
                    },
                    child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "detail",
                          style: TextStyle(fontSize: 10),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      listNote.add(itemNote);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer<PromoCalendarViewModel>(builder: (context, model, _) {
        return Column(
          children: [
            Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.grey),
                    left: BorderSide(width: 0.5, color: Colors.grey),
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Promo title"),
                    SizedBox(
                        width: 70,
                        height: 20,
                        child: buttonView2(
                            color: ColorName.primary2,
                            context: context,
                            onPressed: () {
                              Provider.of<PromoCalendarViewModel>(context,
                                      listen: false)
                                  .showAllTitle();
                            },
                            text: "Show all")),
                  ],
                )),
            GridView.builder(
                padding: const EdgeInsets.only(bottom: 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5,
                ),
                itemCount: model.isShowAllTitle
                    ? listNote.length
                    : (listNote.length > 6
                        ? listNote.getRange(0, 6).length
                        : listNote.length),
                itemBuilder: (BuildContext context, int index) {
                  return listNote[index];
                }),
            if (model.listPromotionByDate.isNotEmpty)
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  itemCount: model.listPromotionByDate.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _itemDayInWeek(model.listPromotionByDate[index]);
                  }),
          ],
        );
      }),
    );
  }

  Widget _itemDayInWeek(PromotionListModel promotionListModel) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(232, 225, 214, 1),
              width: 162,
              height: 70,
              child: Center(
                child: Text(
                  Utils.toDateAndTime(promotionListModel.date!,
                      format: "EEE dd"),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 70.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: promotionListModel.promotion!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 70,
                    height: 70,
                    child: Column(
                      children: [
                        Expanded(
                            child: _promotionWidget(promotionListModel
                                .promotion![index].attachmentId!)),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          // height:2 0.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Text(
                                promotionListModel.promotion![index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 7.0, color: Colors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 0.5,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(PromotionListScreen.routeName,
                    arguments: promotionListModel.promotion!);
              },
              child: Container(
                color: Colors.transparent,
                height: 70,
                child: const Center(
                  child: Icon(Icons.chevron_right),
                ),
              ))
        ],
      ),
    );
  }

  Widget _itemDay(MonthCellDetails builder, List<Widget> listPromo) {
    List<Widget> listWidgetHorizontal = [];
    if (listPromo.isNotEmpty && listPromo.length > 1) {
      for (int i = 0; i < listPromo.length; i++) {
        if (listWidgetHorizontal.length == 2) {
          break;
        }
        listWidgetHorizontal.add(Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: listPromo[i],
        ));
      }
    }
    if (builder.date.month == DateTime.now().month &&
        builder.date.day == DateTime.now().day &&
        builder.date.year == DateTime.now().year) {
      return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.red),
          left: BorderSide(color: Colors.red),
          right: BorderSide(color: Colors.red, width: 1),
          bottom: BorderSide(width: 0.5, color: Colors.red),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // listPromo.isNotEmpty
                  //     ? Expanded(child: listPromo[0])
                  //     : SizedBox(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Center(
                child: Wrap(
                  children: listPromo
                      .getRange(0, listPromo.length > 4 ? 5 : listPromo.length)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    }
    if (builder.date.month == DateTime.now().month) {
      return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black12),
          left: BorderSide(color: Colors.black12),
          right: BorderSide(color: Colors.black12, width: 1),
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // listPromo.isNotEmpty
                  //     ? Expanded(child: listPromo[0])
                  //     : SizedBox(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Wrap(
                children: listPromo
                    .getRange(0, listPromo.length > 3 ? 2 : listPromo.length)
                    .toList(),
              )
            ],
          ),
        ),
      );
    }
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.black12),
        left: BorderSide(color: Colors.black12),
        right: BorderSide(color: Colors.black12, width: 1),
        bottom: BorderSide(width: 0.5, color: Colors.black12),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // listPromo.isNotEmpty
                //     ? Expanded(child: listPromo[0])
                //     : SizedBox(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        builder.date.day.toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemDayWithColorDot(
      MonthCellDetails builder,
      List<Widget> listPromo,
      List<String> listDayOfWeek,
      List<int> listDayOfMonth,
      List<DateOfSeasonResponse> listDayOfSeason,
      String color) {
    List<Widget> listWidgetHorizontal = [];
    if (listDayOfWeek.isNotEmpty &&
        listDayOfWeek
            .where((element) =>
                Utils.getDateOfWeek(element) == builder.date.weekday ||
                Utils.getDateOfWeek(element) == 0)
            .toList()
            .isNotEmpty &&
        builder.date.month == DateTime.now().month &&
        builder.date.year == DateTime.now().year) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: fromCssColor(color)),
          left: BorderSide(color: fromCssColor(color)),
          right: BorderSide(color: fromCssColor(color), width: 1),
          bottom: BorderSide(width: 0.5, color: fromCssColor(color)),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Center(
                child: Wrap(
                  children: listPromo
                      .getRange(0, listPromo.length > 4 ? 5 : listPromo.length)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    } else if (listDayOfMonth.isNotEmpty &&
        listDayOfMonth
            .where((element) => element == builder.date.day)
            .toList()
            .isNotEmpty &&
        builder.date.year == DateTime.now().year) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: fromCssColor(color)),
          left: BorderSide(color: fromCssColor(color)),
          right: BorderSide(color: fromCssColor(color), width: 1),
          bottom: BorderSide(width: 0.5, color: fromCssColor(color)),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Center(
                child: Wrap(
                  children: listPromo
                      .getRange(0, listPromo.length > 4 ? 5 : listPromo.length)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    } else if (listDayOfSeason.isNotEmpty &&
        listDayOfSeason
            .where((element) =>
                element.day!
                    .where((e) => e == builder.date.day)
                    .toList()
                    .isNotEmpty &&
                element.month == builder.date.month)
            .toList()
            .isNotEmpty &&
        builder.date.year == DateTime.now().year) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: fromCssColor(color)),
          left: BorderSide(color: fromCssColor(color)),
          right: BorderSide(color: fromCssColor(color), width: 1),
          bottom: BorderSide(width: 0.5, color: fromCssColor(color)),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Center(
                child: Wrap(
                  children: listPromo
                      .getRange(0, listPromo.length > 4 ? 5 : listPromo.length)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      if (listPromo.isNotEmpty && listPromo.length > 1) {
        for (int i = 0; i < listPromo.length; i++) {
          if (listWidgetHorizontal.length == 2) {
            break;
          }
          listWidgetHorizontal.add(Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: listPromo[i],
          ));
        }
      }
      if (builder.date.month == DateTime.now().month &&
          builder.date.day == DateTime.now().day &&
          builder.date.year == DateTime.now().year) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.red),
            left: BorderSide(color: Colors.red),
            right: BorderSide(color: Colors.red, width: 1),
            bottom: BorderSide(width: 0.5, color: Colors.red),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            builder.date.day.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Center(
                  child: Wrap(
                    children: listPromo
                        .getRange(
                            0, listPromo.length > 4 ? 5 : listPromo.length)
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        );
      }
      if (builder.date.month == DateTime.now().month) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.black12),
            left: BorderSide(color: Colors.black12),
            right: BorderSide(color: Colors.black12, width: 1),
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // listPromo.isNotEmpty
                    //     ? Expanded(child: listPromo[0])
                    //     : SizedBox(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            builder.date.day.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Center(
                  child: Wrap(
                    children: listPromo
                        .getRange(
                            0, listPromo.length > 4 ? 5 : listPromo.length)
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        );
      }
      return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black12),
          left: BorderSide(color: Colors.black12),
          right: BorderSide(color: Colors.black12, width: 1),
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // listPromo.isNotEmpty
                  //     ? Expanded(child: listPromo[0])
                  //     : SizedBox(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          builder.date.day.toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
            ],
          ),
        ),
      );
    }
  }

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
