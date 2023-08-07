import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/view/voucher-list-screen/voucher_list.widget.dart';
import 'package:vegas_club/view_model/voucher_list_screen.viewmodel.dart';

class VoucherListScreen extends StateFullConsumer {
  const VoucherListScreen({Key? key}) : super(key: key);
  static const String route = '/voucher-list-screen';
  @override
  _VoucherListScreenState createState() => _VoucherListScreenState();
}

class _VoucherListScreenState extends StateConsumer<VoucherListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initStateWidget() {
    Provider.of<VoucherListScreenViewModel>(context, listen: false)
        .getMyVoucher(0);
  }

  void _onLoading(VoucherListScreenViewModel model) {
    model.getMyVoucher(model.listMyVoucher!.length);

    _refreshController.loadComplete();
  }

  void _onRefresh(VoucherListScreenViewModel model) {
    model.getMyVoucher(0);

    _refreshController.refreshCompleted();
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
          leading: GestureDetector(
              onTap: () {
                pop();
              },
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: ColorName.primary2,
          title: const Text(
            "Voucher",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer<VoucherListScreenViewModel>(
            builder: (BuildContext context, VoucherListScreenViewModel model,
                Widget? child) {
              if (model.isLoading == true) {
                return const SizedBox();
              }
              // return Center(
              //   child: Text('asdasd'),
              // );
              if (model.listMyVoucher!.isEmpty) {
                return const Center(
                  child: Text(
                    "No data!",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: BaseSmartRefress(
                      refreshController: _refreshController,
                      onRefresh: () => _onRefresh(model),
                      child: ListView.builder(
                          itemCount: model.listMyVoucher!.length,
                          itemBuilder: (context, index) {
                            return itemVoucher(
                                context, model.listMyVoucher![index]);
                          }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
