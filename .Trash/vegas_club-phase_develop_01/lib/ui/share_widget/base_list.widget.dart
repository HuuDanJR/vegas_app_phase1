import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseSmartRefress extends StatefulWidget {
  const BaseSmartRefress(
      {Key? key,
      required this.refreshController,
      this.onLoading,
      this.onRefresh,
      this.child})
      : super(key: key);
  final RefreshController refreshController;
  final void Function()? onLoading;
  final void Function()? onRefresh;
  final Widget? child;
  @override
  State<BaseSmartRefress> createState() => _BaseSmartRefressState();
}

class _BaseSmartRefressState extends State<BaseSmartRefress> {
  late RefreshController? _refreshController;

  @override
  void initState() {
    _refreshController = widget.refreshController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController!,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      enablePullDown: widget.onRefresh != null ? true : false,
      enablePullUp: widget.onLoading != null ? true : false,
      header: WaterDropHeader(
        complete: const Center(
          child: Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ),
        ),
        waterDropColor: Colors.grey.shade400,
      ),
      footer: const ClassicFooter(
        loadingText: "",
        canLoadingText: "",
        idleText: "",
        idleIcon: SizedBox(),
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      child: widget.child,
    );
  }
}
