import 'package:flutter/material.dart';
import 'package:vegas_club/models/response/pyramid_point_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';

class TableCustomWidget extends StatelessWidget {
  final List<PyramidPointResponse> listData;
  final int? range;
  const TableCustomWidget({Key? key, required this.listData, this.range})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> itemRow() {
      List<TableRow> listRow = [
        TableRow(
          children: <Widget>[
            TableCell(
              // verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(236, 239, 253, 1)),
                height: 32,
                child: const Center(
                  child: Text(
                    'PRICE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(236, 239, 253, 1)),
                height: 32,
                child: const Center(
                  child: Text(
                    'POINT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ];
      for (int i = 0; i < listData.length; i++) {
        listRow.add(
          TableRow(
            children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.fill,
                child: Container(
                  color: (listData[i].minPoint! < range! &&
                          listData[i].maxPoint! > range!)
                      ? Colors.yellow
                      : Colors.transparent,
                  child: Center(
                      child: Text(
                    listData[i].prize.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  )),
                ),
              ),
              TableCell(
                child: Container(
                  color: (listData[i].minPoint! < range! &&
                          listData[i].maxPoint! > range!)
                      ? Colors.yellow
                      : Colors.transparent,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextCountNumber(
                        numberPoint: listData[i].minPoint!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.trending_flat),
                      TextCountNumber(
                        numberPoint: listData[i].maxPoint!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
      return listRow;
    }

    return Table(
      border: TableBorder.all(color: Colors.black26),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: itemRow(),
    );
  }
}
