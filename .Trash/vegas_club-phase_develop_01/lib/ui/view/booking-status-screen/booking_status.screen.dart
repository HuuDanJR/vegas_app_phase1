import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/booking-status-screen/booking_status.widget.dart';
import 'package:vegas_club/ui/view/host-screen/history_call.screen.dart';

/**
 * - đặt xe 
- show lịch sử đặt xe 
- thông báo cho người dùng xe đã được đặt thành công hay chưa 
- 3 trạng thái ( waiting , success, fail) 
- Giới hạn chức năng theo level (chỉ được đặt 1 xe) 
 */
class BookingStatusScreen extends StateFullConsumer {
  const BookingStatusScreen({Key? key}) : super(key: key);
  static const String route = '/booking-status';
  @override
  _BookingStatusScreenState createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends StateConsumer<BookingStatusScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          // extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: appBarBottomBar(_scaffoldKey,
              context: context,
              title: "Booking car",
              actions: [
                InkWell(
                  onTap: () {
                    pushNamed(HistoryCallScreen.route);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.history,
                      color: Colors.grey,
                    ),
                  ),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  decoration:
                      const BoxDecoration(color: Color.fromRGBO(253, 245, 226, 1)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Colors.black26))),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10.0),
                                hintText: "Where to..",
                                hintStyle: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.watch_later,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.quicksand),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(child: historyBooking()),
              ],
            ),
          )),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  void initStateWidget() {
    // TODO: implement initStateWidget
  }
}
