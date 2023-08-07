import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/jackpot_history.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/jackpot_realtime.screen.dart';

class Jackpotpage extends StateFullConsumer {
  const Jackpotpage({Key? key}) : super(key: key);
  static const String route = '/jackpot-page';
  @override
  _JackpotpageState createState() => _JackpotpageState();
}

class _JackpotpageState extends StateConsumer<Jackpotpage>
    with TickerProviderStateMixin, BaseFunction {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<String> listTitle = ["MYSTERY JACKPOT", "HISTORY "];
  String tabName = "Jackpot";
  @override
  void initStateWidget() {
    tabController.addListener(() {
      setState(() {
        tabName = listTitle[tabController.index];
      });
    });

  }
  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    List<Widget> listTab = [];
    // listTitle.map((e) {
    //   listTab.add(
    //     Tab(
    //       child: Container(
    //         width: MediaQuery.of(context).size.width * 0.4,
    //         height: 30,
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.grey),
    //           borderRadius: BorderRadius.circular(20.0),
    //           color: tabController.index  Colors.amber.shade300,
    //         ),
    //         child: Center(
    //             child: Text(
    //           e,
    //           style: TextStyle(fontSize: 12),
    //         )),
    //       ),
    //     ),
    //   );
    // }).toList();

    for (int i = 0; i < listTitle.length; i++) {
      listTab.add(
        Tab(
          child: Container(
            height: 30,
            // width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: tabController.index == i ? Colors.white : Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
              color: tabController.index == i
                  ? ColorName.primary
                  : Colors.transparent,
            ),
            child: Center(
                child: Text(
              listTitle[i],
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      );
    }
    Widget tabbar() {
      return TabBar(
        isScrollable: false,
        controller: tabController,
        // indicatorPadding: EdgeInsets.symmetric(horizontal: 5.0),
        indicatorColor: Colors.transparent,
        indicator: ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99.0))),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        // indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
        tabs: listTab,
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.primary2,
        title: const Text(
          'Jackpot',
          style: TextStyle(fontSize: 18.0),
        ),
        leading: GestureDetector(
          onTap: () {
            pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: tabbar(),
              ),
              const SizedBox(
                height: 2.5,
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    JacpotRealtimePage(),
                    JackpotHistoryScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
