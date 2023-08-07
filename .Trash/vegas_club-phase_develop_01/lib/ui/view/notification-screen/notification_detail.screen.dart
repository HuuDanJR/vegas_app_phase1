import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';

class NotiContent {
  final String? status;
  final String? dateTime;
  final String? content;
  final String? driverName;
  final String? carName;
  final String? carNumber;
  final String? timeRequest;
  final String? timeArrive;
  final String? dateRequest;
  final String? dateArrive;
  final String? startTime;
  final String? endTime;
  final String? gameTheme;
  final String? gameNumber;
  final bool? isError;
  final String? internalNote;
  final int? idStatus;
  final String? foodName;
  final String? title;

  NotiContent(
      {this.driverName,
      this.carName,
      this.carNumber,
      this.timeRequest,
      this.timeArrive,
      this.dateArrive,
      this.dateRequest,
      this.status,
      this.dateTime,
      this.content,
      this.gameTheme,
      this.gameNumber,
      this.internalNote,
      this.idStatus,
      this.foodName,
      this.startTime,
      this.endTime,
      this.title,
      this.isError = false});
}

class NotificationDetailScreen extends StateFullConsumer {
  const NotificationDetailScreen(
      {Key? key,
      required this.notificationId,
      this.sourceId,
      this.typeId,
      this.title = "",
      this.isRouteFromBottomBar = true,
      this.notificationType,
      required this.statusType})
      : super(key: key);
  final int? notificationId;
  final int? sourceId;
  final int? typeId;
  final String? title;
  final int? statusType;
  final bool? isRouteFromBottomBar;
  final String? notificationType;

  static const String route = '/notification-detail-screen';
  @override
  _NotificationDetailScreenState createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState
    extends StateConsumer<NotificationDetailScreen> {
  int? _notificationId = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initStateWidget() {
    _notificationId = widget.notificationId!;
    Provider.of<NotificationScreenViewModel>(context, listen: false)
        .getDetailNotificationBySourceId(widget.sourceId!, widget.typeId!,
            widget.statusType!, widget.notificationId!);
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
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
          appBar: appBarBottomBar(_scaffoldKey,
              context: context, title: "Notification Detail", onClose: () {
            pop();
          }, actions: [
            InkWell(
              onTap: () {
                if (widget.isRouteFromBottomBar!) {
                  pop();
                } else {
                  pop();
                  pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.home),
              ),
            ),
          ]),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Consumer<NotificationScreenViewModel>(
              builder: (BuildContext context, NotificationScreenViewModel model,
                  Widget? child) {
                if (model.notiContent?.isError == true) {
                  return const Center(
                    child: Text("Data not found!"),
                  );
                }
                log("status : ${model.notiContent!.idStatus}");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Status : ",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                (model.notiContent?.status!.toLowerCase() ==
                                            "system"
                                        ? "Vegas Club"
                                        : model.notiContent?.status!) ??
                                    "",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: model.notiContent!.idStatus == 0
                                        ? Colors.red
                                        : (model.notiContent!.idStatus == 1
                                            ? Colors.blue
                                            : (model.notiContent!.idStatus == 2
                                                ? Colors.green
                                                : (model.notiContent!
                                                            .idStatus ==
                                                        3
                                                    ? Colors.black
                                                    : Colors.black)))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),

                          if (model.notiContent != null &&
                              model.notiContent!.dateTime != null)
                            Text(
                              "Date Time: ${model.notiContent!.dateTime}",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (model.notiContent!.startTime != null &&
                              model.notiContent!.startTime!.isNotEmpty)
                            Column(
                              children: [
                                Text(
                                    "Start Time : ${model.notiContent!.startTime ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          if (model.notiContent!.endTime != null &&
                              model.notiContent!.endTime!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                    "End Time : ${model.notiContent!.endTime ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          if (widget.title!.isNotEmpty)
                            Text(
                              widget.title ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          if (model.notiContent?.driverName != null &&
                              model.notiContent!.driverName!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                    "Driver Name : ${model.notiContent?.driverName}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          if (model.notiContent?.carName != null &&
                              model.notiContent!.carName!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text("Car Name : ${model.notiContent?.carName}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          if (model.notiContent?.carNumber != null &&
                              model.notiContent!.carNumber!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                    "Car Number : ${model.notiContent?.carNumber}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),

                          if (model.notiContent!.timeRequest != null &&
                              model.notiContent!.timeRequest!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                    "Time Request : ${model.notiContent!.timeRequest ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          if (model.notiContent!.timeArrive != null &&
                              model.notiContent!.timeArrive!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                    "Time Arrived : ${model.notiContent!.timeArrive ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          // if (model.notiContent?.timeRequest != null &&
                          //     model.notiContent!.timeRequest!.isNotEmpty)
                          //   Column(
                          //     children: [
                          //       SizedBox(
                          //         height: 10.0,
                          //       ),
                          //       Text(
                          //           "Time Request : ${model.notiContent?.timeRequest}",
                          //           style: TextStyle(
                          //               color: Colors.black, fontSize: 16)),
                          //     ],
                          //   ),
                          // if (model.notiContent?.timeArrive != null &&
                          //     model.notiContent!.timeArrive!.isNotEmpty)
                          //   Column(
                          //     children: [
                          //       SizedBox(
                          //         height: 10.0,
                          //       ),
                          //       Text(
                          //           "Time Arrived : ${model.notiContent?.timeArrive}",
                          //           style: TextStyle(
                          //               color: Colors.black, fontSize: 16)),
                          //     ],
                          //   ),

                          if (model.notiContent?.gameTheme != null &&
                              model.notiContent!.gameTheme!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                    "Game Theme : ${model.notiContent?.gameTheme}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (model.notiContent?.gameNumber != null &&
                              model.notiContent!.gameNumber!.isNotEmpty)
                            Text(
                                "Game Number : ${model.notiContent?.gameNumber}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          if (model.notiContent?.content != null &&
                              model.notiContent!.content!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                HtmlWidget(
                                  model.notiContent?.content ?? '',
                                  textStyle: const TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              ],
                            ),
                          if (model.notiContent?.foodName != null &&
                              model.notiContent!.foodName!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text("Food Name : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${model.notiContent!.foodName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          if (model.notiContent?.internalNote != null &&
                              model.notiContent!.internalNote!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  "Staff Note :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  model.notiContent!.internalNote ?? '',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
