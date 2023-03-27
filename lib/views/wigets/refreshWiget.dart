import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../static/color.dart';

class RefreshWidget extends StatefulWidget {

  final Widget widget;
  final Future<List<dynamic>> Function() refresh;
  const RefreshWidget({Key? key,required this.widget,  required this.refresh}) : super(key: key);

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
  Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }


  // Future<void> _handleRefresh() {
  //   final Completer<void> completer = Completer<void>();
  //   Timer(const Duration(seconds: 3), () {
  //     completer.complete();
  //   });
  //   setState(() {
  //     refreshNum = Random().nextInt(100);
  //   });
  //   return completer.future.then<void>((_) {
  //     ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
  //       SnackBar(
  //         content: const Text('Refresh complete'),
  //         action: SnackBarAction(
  //           label: 'RETRY',
  //           onPressed: () {
  //             _refreshIndicatorKey.currentState!.show();
  //           },
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: widget.refresh,
      backgroundColor: Colors.lightGreenAccent,
      color: CustomColors.barColor,
      showChildOpacityTransition: false,
      child: StreamBuilder<int>(
        stream: counterStream,
        builder: (context, snapshot) {
          return widget.widget;
        },
      ),
    );
  }
}
