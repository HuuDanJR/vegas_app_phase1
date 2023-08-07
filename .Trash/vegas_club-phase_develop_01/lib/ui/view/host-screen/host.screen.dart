import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/officer_response.dart';
import 'package:vegas_club/ui/view/host-screen/history_call.screen.dart';
import 'package:vegas_club/ui/view/host-screen/host.widget.dart';
import 'package:vegas_club/view_model/host_screen.viewmodel.dart';

class HostScreen extends StateFullConsumer {
  const HostScreen({Key? key, this.isBack = false}) : super(key: key);
  static const String route = '/host-screen';
  final bool isBack;
  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends StateConsumer<HostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  @override
  void initStateWidget() {
    Provider.of<HostScreenViewModel>(context, listen: false).getOfficer();
    _timer = Timer.periodic(const Duration(seconds: 30), (time) {
      Provider.of<HostScreenViewModel>(context, listen: false).getOfficer();
    });
  }

  @override
  void disposeWidget() {
    if (_timer != null) {
      _timer?.cancel();
    }
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
          backgroundColor: ColorName.primary2,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: widget.isBack ? null : 85,
          title: Padding(
            padding: widget.isBack
                ? const EdgeInsets.only(top: 0.0)
                : const EdgeInsets.only(top: 35.0),
            child: const Text(
              'Host Hotline',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          leading: widget.isBack
              ? Padding(
                  padding: widget.isBack
                      ? const EdgeInsets.only(top: 0.0)
                      : const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
          actions: [
            Padding(
              padding: widget.isBack
                  ? const EdgeInsets.only(top: 0.0)
                  : const EdgeInsets.only(top: 30.0),
              child: InkWell(
                onTap: () {
                  pushNamed(HistoryCallScreen.route);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Consumer<HostScreenViewModel>(
                builder: (BuildContext context, HostScreenViewModel model,
                    Widget? child) {
                  List<OfficerResponse> listOfficer = model.listOfficer;
                  return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:
                              isSmallScreen(context) ? (1.4 / 2) : (1.5 / 2),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 10),
                      itemCount: listOfficer.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemHost(context, listOfficer[index], model);
                      });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              // bannelRouletteWheel(context),
            ],
          ),
        ),
      ),
    );
  }
}
