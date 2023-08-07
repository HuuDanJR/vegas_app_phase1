import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/view/roulette-screen/roulette.widget.dart';
import 'package:vegas_club/ui/view/video_stream_screen/video_stream_2.screen.dart';
import 'package:vegas_club/view_model/routette.viewmodel.dart';

class RouletteScreen extends StateFullConsumer {
  const RouletteScreen({Key? key}) : super(key: key);
  static const String routeName = "./routelleScreen";
  @override
  _RouletteScreenState createState() => _RouletteScreenState();
}

class _RouletteScreenState extends StateConsumer<RouletteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initStateWidget() {
    Provider.of<RoutetteViewModel>(context, listen: false).getListRoutette(0);
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
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Routette",
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: ColorName.primary2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Consumer<RoutetteViewModel>(builder:
              (BuildContext context, RoutetteViewModel model, Widget? child) {
            return BaseSmartRefress(
              refreshController: _refreshController,
              onLoading: () {
                Provider.of<RoutetteViewModel>(context, listen: false)
                    .getListRoutette(model.listRoutett.length);
                _refreshController.loadComplete();
              },
              onRefresh: () {
                Provider.of<RoutetteViewModel>(context, listen: false)
                    .getListRoutette(0);
                _refreshController.refreshCompleted();
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 0),
                itemCount: model.listRoutett.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoStream2Screeen(
                                  url: model.listRoutett[index].streamingUrl,
                                )));
                      },
                      child: Hero(
                        tag: model.listRoutett[index].streamingUrl!,
                        child: RouletteVideo(
                          roulette: model.listRoutett[index],
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
