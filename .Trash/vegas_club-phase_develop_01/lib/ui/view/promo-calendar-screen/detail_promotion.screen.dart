import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

class DetailPromotionScreen extends StateFullConsumer {
  const DetailPromotionScreen({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  static const String routeName = "./detail-promotion";
  @override
  StateConsumer<DetailPromotionScreen> createState() =>
      _DetailPromotionScreenState();
}

class _DetailPromotionScreenState extends StateConsumer<DetailPromotionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _term;
  String? _prize;
  @override
  void initStateWidget() {
    _term = widget.data!["term"];
    _prize = widget.data!["prize"];
  }


  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              pop();
            },
            child: const Icon(Icons.clear)),
        backgroundColor: ColorName.primary2,
        centerTitle: true,
        elevation: 0,
        title: const Text("Promotion Detail",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            )),
        // toolbarHeight: 80,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            "Term",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
              width: width(context),
              child:
                  //  Html(
                  //   // customRenders: {tableMatcher(): tableRender()},
                  //   shrinkWrap: true,
                  //   data: _term,
                  //   style: {
                  //     "body": Style(color: Colors.black),
                  //     "td": Style(border: Border.all(color: Colors.black))
                  //   },
                  // ),
                  HtmlWidget(
                _term ?? '',
                customStylesBuilder: (element) {
                  return {'color': 'black'};
                },
              )),
          const SizedBox(
            height: 20.0,
          ),
          const Text("Prize",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
              width: width(context),
              child:
                  // Html(
                  //     onImageError: (exception, stackTrace) {},
                  //     // customRenders: {tableMatcher(): tableRender()},
                  //     shrinkWrap: true,
                  //     style: {
                  //       "body": Style(color: Colors.black),
                  //       "td": Style(border: Border.all(color: Colors.black))
                  //     },
                  //     data: _prize ?? ""),
                  HtmlWidget(
                _prize ?? '',
                customStylesBuilder: (element) {
                  return {'color': 'black'};
                },
              )),
        ],
      ),
    );
  }
}
