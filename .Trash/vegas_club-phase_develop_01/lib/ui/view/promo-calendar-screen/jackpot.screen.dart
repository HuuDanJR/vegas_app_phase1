// import 'package:flutter/material.dart';
// import 'package:vegas_club/base/base_state_widget.dart';
// import 'package:vegas_club/ui/view/promo-calendar-screen/jackpot_history.screen.dart';

// class JackpotScreen extends StateFullConsumer {
//   JackpotScreen({Key? key}) : super(key: key);
//   static const String route = '/jackpot-screen';
//   @override
//   _JackpotScreenState createState() => _JackpotScreenState();
// }

// class _JackpotScreenState extends StateConsumer<JackpotScreen>
//     with TickerProviderStateMixin {
//   late TabController tabController = TabController(length: 2, vsync: this);
//   List<String> listTitle = ["REALTIME MYSTERY JACKPOS", "HISTORY JACKPOT"];
//   String tabName = "Jackpot";
//   @override
//   void initState() {
//     tabController.addListener(() {
//       setState(() {
//         tabName = listTitle[tabController.index];
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget buildWidget(BuildContext context) {
//     List<Widget> listTab = [];
//     listTitle.map((e) {
//       listTab.add(
//         Tab(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.4,
//             height: 30,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.0),
//               color: Colors.transparent,
//             ),
//             child: Center(
//                 child: Text(
//               e,
//               style: TextStyle(fontSize: 12),
//             )),
//           ),
//         ),
//       );
//     }).toList();
//     Widget tabbar() {
//       return TabBar(
//         isScrollable: true,
//         controller: tabController,
//         indicatorPadding: EdgeInsets.symmetric(horizontal: 5.0),
//         indicatorColor: Colors.transparent,
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.black,
//         tabs: listTab,
//       );
//     }

//     return WillPopScope(
//       onWillPop: () async {
//         if (Navigator.of(context).userGestureInProgress) {
//           return false;
//         }
//         return true;
//       },
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//                 child: tabbar(),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: tabController,
//                   children: [
//                     SizedBox(),
//                     JackpotHistoryScreen(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
