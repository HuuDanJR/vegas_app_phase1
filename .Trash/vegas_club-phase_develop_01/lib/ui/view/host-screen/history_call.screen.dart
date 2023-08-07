import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/models/group_history_call.model.dart';
import 'package:vegas_club/models/response/history_call_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/view_model/host_screen.viewmodel.dart';

class HistoryCallScreen extends StateFullConsumer {
  const HistoryCallScreen({Key? key}) : super(key: key);
  static const String route = "/historyCallScreen";
  @override
  StateConsumer<HistoryCallScreen> createState() => _HistoryCallScreenState();
}

class _HistoryCallScreenState extends StateConsumer<HistoryCallScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initStateWidget() {
    Provider.of<HostScreenViewModel>(context, listen: false)
        .getHistoryCall(context, 0);
  }

  void _onRefresh(HostScreenViewModel model) {
    model.getHistoryCall(context, 0);
    _refreshController.refreshCompleted();
  }

  void _onLoadMore(HostScreenViewModel model) {
    model.getHistoryCall(context, model.listHistoryCall.length);
    _refreshController.loadComplete();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarBottomBar(_scaffoldKey,
          context: context, title: "history_call", actions: [], onClose: () {
        pop();
      }),
      body: Consumer<HostScreenViewModel>(
        builder: (context, model, _) {
          List<GroupHistoryCall> list =
              model.listGroupHistoryCall.reversed.toList();
          return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                _onRefresh(model);
              },
              onLoading: () {
                _onLoadMore(model);
              },
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(
                refresh: CupertinoActivityIndicator(),
                complete: SizedBox(),
              ),
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _itemHistory(
                      list[index].listHisCall, list[index].dateTime ?? '');
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
        },
      ),
    );
  }

  Widget _itemHistory(List<HistoryCallResponse>? listHisCall, String dateTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              dateTime,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listHisCall!.length,
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              return _itemHost(listHisCall[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 4.0,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _itemHost(HistoryCallResponse customerResponse) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(50)),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: Utils.getImageFromId(
                    customerResponse.officer?.attachmentId ?? -1),
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.grey.shade300,
                ),
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Assets.image_host_placeholder.path,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerResponse.officer?.phone ?? '',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0),
              ),
              Text(
                customerResponse.officer?.name ?? '',
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  if (!await launchUrl(Uri(
                      scheme: 'tel',
                      path: customerResponse.officer?.phone ?? ''))) {
                    throw 'Could not launch tel:${customerResponse.officer?.phone ?? ''}';
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(
                    Icons.call,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
