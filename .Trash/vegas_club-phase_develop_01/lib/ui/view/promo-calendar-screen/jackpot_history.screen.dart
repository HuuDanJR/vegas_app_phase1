import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/models/baseModel.dart';
import 'package:vegas_club/models/response/jackpot_history_response.dart';
import 'package:vegas_club/models/response/jackpot_response.dart';
import 'package:vegas_club/view_model/jackpot_history.viewmodel.dart';

class JackpotHistoryScreen extends StatefulWidget {
  const JackpotHistoryScreen({Key? key}) : super(key: key);

  @override
  _JackpotHistoryScreenState createState() => _JackpotHistoryScreenState();
}

class _JackpotHistoryScreenState extends State<JackpotHistoryScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    Provider.of<JackpotHistoryViewmodel>(context, listen: false)
        .getJackpotHistory();
    Provider.of<JackpotHistoryViewmodel>(context, listen: false).getJackpot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              TableJackpotHistoryWidget(),
              SizedBox(
                height: 8.0,
              ),
              TableJackpotMachineWidget(),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableJackpotHistoryWidget<T> extends StatefulWidget {
  const TableJackpotHistoryWidget({Key? key}) : super(key: key);
  @override
  _TableJackpotHistoryWidgetState createState() =>
      _TableJackpotHistoryWidgetState<T>();
}

class _TableJackpotHistoryWidgetState<T>
    extends State<TableJackpotHistoryWidget<T>> {
  late BaseModel<T> base;
  List<JackpotHistoryResponse> listData = [];
  @override
  void initState() {
    base = BaseModel<T>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<JackpotHistoryViewmodel>(
        builder: (BuildContext context, JackpotHistoryViewmodel model,
            Widget? child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Mystery Jackpot',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                model.listJacpotHistory.isEmpty
                    ? const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            Text("No data!"),
                            SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black45,
                            )),
                        child: Table(
                          // border: TableBorder.all(color: Colors.black26),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: itemRow(model.listJacpotHistory),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<TableRow> itemRow(List<JackpotHistoryResponse> listJacpotHistory) {
    List<TableRow> listRow = [
      const TableRow(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black38))),
        children: <Widget>[
          TableCell(
            // verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'DATE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          // TableCell(
          //   child: SizedBox(
          //     height: 32,
          //     child: Center(
          //       child: Text(
          //         'MC NO.',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, color: Colors.black),
          //       ),
          //     ),
          //   ),
          // ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'MC NAME',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'TYPE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'AMOUNT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    for (int i = 0; i < listJacpotHistory.length; i++) {
      listRow.add(
        TableRow(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.black38),
                  left: BorderSide(color: Colors.black38),
                  right: BorderSide(color: Colors.black38))),
          children: <Widget>[
            TableCell(
              child: SizedBox(
                  height: 50.0,
                  child: Center(
                      child: Text(
                    listJacpotHistory[i].date!.parseDate("MMM dd"),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ))),
            ),
            // TableCell(
            //   child: Center(
            //       child: Text(
            //     listJacpotHistory[i].machineNumber.toString(),
            //     style: TextStyle(fontSize: 12, color: Colors.black),
            //   )),
            // ),
            TableCell(
              child: Center(
                  child: Text(
                listJacpotHistory[i].name.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              )),
            ),
            TableCell(
              child: Text(
                listJacpotHistory[i].machineName.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
              child: Center(
                  child: Text(
                '\$${double.parse(listJacpotHistory[i].amount!.toString()).toDecimal()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      );
    }
    return listRow;
  }
}

class TableJackpotMachineWidget<T> extends StatefulWidget {
  const TableJackpotMachineWidget({Key? key}) : super(key: key);
  @override
  _TableJackpotMachineWidgetState createState() =>
      _TableJackpotMachineWidgetState<T>();
}

class _TableJackpotMachineWidgetState<T>
    extends State<TableJackpotMachineWidget<T>> {
  late BaseModel<T> base;
  List<JackpotHistoryResponse> listData = [];
  @override
  void initState() {
    base = BaseModel<T>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<JackpotHistoryViewmodel>(
        builder: (BuildContext context, JackpotHistoryViewmodel model,
            Widget? child) {
          return Column(
            children: [
              const Text(
                'Machine Jackpot',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              model.listJackpot.isEmpty
                  ? const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.0,
                          ),
                          Text("No data!"),
                          SizedBox(
                            height: 40.0,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black45,
                          )),
                      child: Table(
                        // border: TableBorder.all(color: Colors.black26),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          3: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: itemRow(model.listJackpot),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  List<TableRow> itemRow(List<JackpotResponse> listJacpotHistory) {
    List<TableRow> listRow = [
      const TableRow(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black38))),
        children: <Widget>[
          TableCell(
            // verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'DATE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          // TableCell(
          //   child: SizedBox(
          //     height: 32,
          //     child: Center(
          //       child: Text(
          //         'MC NO.',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, color: Colors.black),
          //       ),
          //     ),
          //   ),
          // ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'JACKPOT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'MC NAME',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  'AMOUNT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    for (int i = 0; i < listJacpotHistory.length; i++) {
      listRow.add(
        TableRow(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.black38),
                  left: BorderSide(color: Colors.black38),
                  right: BorderSide(color: Colors.black38))),
          children: <Widget>[
            TableCell(
              child: SizedBox(
                  height: 50.0,
                  child: Center(
                      child: Text(
                    listJacpotHistory[i].jpDate!.toLocal().parseDate("MMM dd"),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ))),
            ),
            // TableCell(
            //   child: Center(
            //       child: Text(
            //     listJacpotHistory[i].mcNumber.toString(),
            //     style: TextStyle(fontSize: 12, color: Colors.black),
            //   )),
            // ),
            TableCell(
              child: Center(
                  child: Text(
                listJacpotHistory[i].jackpotGameType == null
                    ? ""
                    : listJacpotHistory[i].jackpotGameType!.name.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              )),
            ),
            TableCell(
              child: Text(
                listJacpotHistory[i].mcName.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
              child: Center(
                  child: Text(
                '\$${double.parse((listJacpotHistory[i].jpValue != null ? (listJacpotHistory[i].jpValue is double ? double.parse(listJacpotHistory[i].jpValue.toString()) : int.parse(listJacpotHistory[i].jpValue.toString())) : 0).toString()).toDecimal()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      );
    }
    return listRow;
  }
}
