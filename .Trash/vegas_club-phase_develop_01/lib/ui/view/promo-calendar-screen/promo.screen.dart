import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promo_calendar.screen.dart';

class PromoScreen extends StateFullConsumer {
  const PromoScreen({Key? key, this.isShowBack = true}) : super(key: key);
  final bool? isShowBack;
  static const String routeName = "./promoScreen";
  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends StateConsumer<PromoScreen> with BaseFunction {
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
        // drawer: DrawableWidget(
        //   onRouteToScreen: (widgetChild) {
        //     // _scaffoldKey.currentState!.openEndDrawer();
        //     locator
        //         .get<CommonService>()
        //         .navigatoToRoute(Utils.createRouteBottomToTop(widgetChild));
        //   },
        // ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorName.primary2,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: widget.isShowBack! ? null : 85,
          title: Padding(
            padding: widget.isShowBack!
                ? const EdgeInsets.only(top: 0.0)
                : const EdgeInsets.only(top: 30.0),
            child: const Text(
              'Promo',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          leading: widget.isShowBack!
              ? Padding(
                  padding: widget.isShowBack!
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
        ),
        body: const PromoCalendarScreen(),
      ),
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
