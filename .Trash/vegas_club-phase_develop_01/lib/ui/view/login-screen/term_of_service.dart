import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/view_model/term_of_service.viewmodel.dart';

class TermOfService extends StatefulWidget {
  const TermOfService({super.key});

  @override
  _TermOfServiceState createState() => _TermOfServiceState();
}

class _TermOfServiceState extends State<TermOfService>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TermOfServiceViewModel>(context, listen: false)
          .getTermOfService();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<TermOfServiceViewModel>(builder: (context, model, _) {
      return SingleChildScrollView(
        child: Column(
          children: [
            HtmlWidget(
              model.termOfUser ?? '',
            ),
          ],
        ),
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
