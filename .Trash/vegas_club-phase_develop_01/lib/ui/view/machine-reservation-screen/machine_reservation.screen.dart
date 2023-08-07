import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/models/response/machine_response.dart';
import 'package:vegas_club/models/response/setting_model.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/view_model/machine_reservation.viewmodel.dart';

class MachineReservationScreen extends StateFullConsumer {
  const MachineReservationScreen({Key? key}) : super(key: key);
  static const String routeName = "./machineReservation";
  @override
  StateConsumer<MachineReservationScreen> createState() =>
      _MachineReservationScreenState();
}

class _MachineReservationScreenState
    extends StateConsumer<MachineReservationScreen> {
  final RefreshController _refreshController = RefreshController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late SettingModel? settingModel;
  @override
  void initStateWidget() {
    // TODO: implement initState
    settingModel = boxSetting!.get(settingMachineBooking);
    Provider.of<MachineReservationViewmodel>(context, listen: false)
        .getListMachine(0);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarBottomBar(
        _scaffoldKey,
        context: context,
        title: "Machine Reservation Information",
        actions: [],
        onClose: () {
          pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<MachineReservationViewmodel>(
              builder: (BuildContext context, MachineReservationViewmodel model,
                  Widget? child) {
                if (model.listMachine == null) {
                  return loadingWidget();
                }

                return Expanded(
                  child: BaseSmartRefress(
                    refreshController: _refreshController,
                    onRefresh: () {
                      model.getListMachine(0);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () {
                      model.getListMachine(model.listMachine!.length);
                      _refreshController.loadComplete();
                    },
                    child: model.listMachine!.isEmpty
                        ? const Center(
                            child: Text(
                              "No data!",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        : ListView.separated(
                            itemCount: model.listMachine!.length,
                            itemBuilder: (context, index) {
                              return _itemSlotMachine(
                                  model.listMachine![index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                          ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            // SizedBox(
            //   width: width(context),
            //   child: buttonView(
            //     text: "Request",
            //     onPressed: () {
            //       pushNamed(MachineRequestScreen.routeName);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 20.0,
            // )
          ],
        ),
      ),
    );
  }

  Widget _itemSlotMachine(MachineResponse machine) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              children: [
                const Icon(
                  Icons.extension,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "Machine Number",
                  style: TextStyle(color: Colors.black),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      machine.machineNumber.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    if (machine.machineName != null &&
                        machine.machineName!.isNotEmpty)
                      Text(
                        machine.machineName ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              children: [
                const Icon(
                  Icons.timelapse,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "Time Start",
                  style: TextStyle(color: Colors.black),
                ),
                const Expanded(child: SizedBox()),
                if (machine.startedAt != null)
                  Text(
                    Utils.toDateAndTime(machine.startedAt!),
                    style: const TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              children: [
                const Icon(
                  Icons.timelapse,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "Time End",
                  style: TextStyle(color: Colors.black),
                ),
                const Expanded(child: SizedBox()),
                if (machine.startedAt != null)
                  Text(
                    Utils.toDateAndTime(machine.endedAt!),
                    style: const TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.email,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Note",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          machine.internalNote ?? '',
                          style: const TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
