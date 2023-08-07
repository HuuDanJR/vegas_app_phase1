import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/message-screen/message.widget.dart';

class MessageScreen extends StateFullConsumer {
  const MessageScreen({Key? key}) : super(key: key);
  static const String route = '/message-screen';
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends StateConsumer<MessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  void initStateWidget() {
    // TODO: implement initStateWidget
  }
  @override
  Widget buildWidget(BuildContext context) {
    List<Color> colorList = [Colors.white, Colors.black26];

    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        appBar: appBarBottomBar(_scaffoldKey,
            context: context, title: "Message", onClose: () {
          Navigator.of(context).pop();
        }),
        body: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return itemMessage();
                  }),
            ),
          ],
        ),
      ),
    );
  }

}
