import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/notification_response.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/view/notification-screen/notification_detail.screen.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';

class NotificationScreen extends StateFullConsumer {
  const NotificationScreen(
      {Key? key, this.isBack = true, this.isRouteFromBottomBar = false})
      : super(key: key);
  static const String route = '/notification-screen';
  final bool? isRouteFromBottomBar;
  final bool? isBack;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends StateConsumer<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();

  @override
  void initStateWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationScreenViewModel>(context, listen: false)
          .getListNotification(0);
          //       locator.get<MixPanelTrackingService>().trackData(
          // name: "Xem thông báo",
          // properties: {
          //   "name": val.getUserName(),
          //   "level": val.membershipTypeName
          // });
    });

  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    // Provider.of<NotificationScreenViewModel>(context, listen: false)
    //     .getListNotification(0);
    List<Color> colorList = [Colors.white, Colors.black26];

    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorName.primary2,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: widget.isBack! ? null : 85,
          title: Padding(
            padding: widget.isBack!
                ? const EdgeInsets.only(top: 0.0)
                : const EdgeInsets.only(top: 35.0),
            child: const Text(
              'Notification',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          leading: widget.isBack!
              ? Padding(
                  padding: widget.isBack!
                      ? const EdgeInsets.only(top: 0.0)
                      : const EdgeInsets.only(top: 35.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        key: _scaffoldKey,
        body: Consumer<NotificationScreenViewModel>(
          builder: (BuildContext context, NotificationScreenViewModel model,
              Widget? child) {
            if (model.listNotification == null) {
              return const SizedBox();
            }
            print("list notification: ${model.listNotification!.length}");
            return Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: BaseSmartRefress(
                    refreshController: _refreshController,
                    onRefresh: () {
                      model.getListNotification(0);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () {
                      model.getListNotification(model.listNotification!.length);
                      _refreshController.loadComplete();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 6.0),
                      itemCount: model.listNotification!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // locator.get<CommonService>().navigatoToRoute(
                            //         Utils.createRouteRightToLeft(
                            //             NotificationDetailScreen(
                            //       notificationId:
                            //           model.listNotification?[index].id,
                            //       sourceId:
                            //           model.listNotification?[index].sourceId,
                            //       typeId: model
                            //           .listNotification?[index].notificationType,
                            //     )));
                          },
                          child: Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                Provider.of<NotificationScreenViewModel>(
                                        context,
                                        listen: false)
                                    .deleteNotification(
                                        model.listNotification![index].id!);
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (BuildContext context) {
                                    Provider.of<NotificationScreenViewModel>(
                                            context,
                                            listen: false)
                                        .deleteNotification(
                                            model.listNotification![index].id!);
                                  },
                                ),
                              ],
                            ),
                            child: itemNotification(
                                backgroundColors: (index % 2) == 0
                                    ? colorList[1]
                                    : colorList[0],
                                notificationResponse:
                                    model.listNotification![index],
                                index: index),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 8.0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemNotification(
      {Color? backgroundColors,
      required NotificationResponse notificationResponse,
      int? index}) {
    return InkWell(
      onTap: () {
        Provider.of<NotificationScreenViewModel>(context, listen: false)
            .setIsRead(index!);
        locator.get<CommonService>().navigatoToRoute(
                Utils.createRouteRightToLeft(NotificationDetailScreen(
              isRouteFromBottomBar: widget.isRouteFromBottomBar,
              statusType: notificationResponse.statusType,
              title: notificationResponse.notificationType == 1
                  ? ""
                  : notificationResponse.content,
              notificationId: notificationResponse.id,
              sourceId: notificationResponse.sourceId,
              typeId: notificationResponse.notificationType,
            )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                    image: AssetImage(getNotificationTypeImage(
                                        notificationResponse
                                            .notificationType!)))),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getNotificationTypeString(
                                      notificationResponse.notificationType!),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  notificationResponse.content ?? '',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  notificationResponse.createdAt!
                                      .toDateString(),
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          buttonView(
                            height: 30,
                            onPressed: () {
                              Provider.of<NotificationScreenViewModel>(context,
                                      listen: false)
                                  .setIsRead(index!);
                              locator.get<CommonService>().navigatoToRoute(
                                      Utils.createRouteRightToLeft(
                                          NotificationDetailScreen(
                                    isRouteFromBottomBar:
                                        widget.isRouteFromBottomBar,
                                    statusType: notificationResponse.statusType,
                                    title:
                                        notificationResponse.notificationType ==
                                                1
                                            ? ""
                                            : notificationResponse.content,
                                    notificationId: notificationResponse.id,
                                    sourceId: notificationResponse.sourceId,
                                    typeId:
                                        notificationResponse.notificationType,
                                  )));
                            },
                            text: "View",
                          )
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     // Container(
                          //     //   width: 10.0,
                          //     //   height: 10.0,
                          //     //   decoration: BoxDecoration(
                          //     //       color: ColorName.primary,
                          //     //       borderRadius: BorderRadius.circular(40.0)),
                          //     // ),
                          //     SizedBox(
                          //       height: 40.0,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.end,
                          //       children: [
                          //         Text(
                          //           Utils.checkDetailDate(
                          //               context, notificationResponse.createdAt!),
                          //           style: TextStyle(color: Colors.grey),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (notificationResponse.isRead == false)
              Positioned(
                right: 0,
                top: -3,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
