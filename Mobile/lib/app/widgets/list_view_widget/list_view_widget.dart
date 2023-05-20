import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/constants/data_constants.dart';
import '../empty_data_widget.dart';

class ListViewWidget extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ScrollController? scrollController;
  final Widget? separator;
  final EdgeInsets? padding;
  final bool? showEmptyWidget;
  final Widget? emptyWidget;
  final Function(bool)? loadMoreCallback;
  final Function(bool)? refreshCallback;
  final Axis? scrollDirection;
  final BaseStateStatus state;

  ListViewWidget({
    Key? key,
    required this.itemBuilder,
    this.itemCount = 0,
    this.scrollController,
    this.separator,
    this.padding,
    this.showEmptyWidget = false,
    this.emptyWidget,
    this.refreshCallback,
    this.scrollDirection = Axis.vertical,
    this.state = BaseStateStatus.none,
    this.loadMoreCallback,
  }) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final _refreshController = RefreshController(initialRefresh: false);
  bool _isBeginLoadingMore = false;

  bool _disableScroll() => widget.state == BaseStateStatus.refreshing;

  @override
  void didUpdateWidget(covariant ListViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != BaseStateStatus.refreshing) {
      _refreshController.refreshCompleted();
    }
    if ((widget.state == BaseStateStatus.loadingMore ||
            widget.state == BaseStateStatus.refreshing) &&
        _isBeginLoadingMore == true) {
      _isBeginLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.showEmptyWidget!
            ? (widget.emptyWidget ?? EmptyDataWidget())
            : Container(),
        NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.axis == widget.scrollDirection) {
              if (widget.state == BaseStateStatus.success &&
                  _isBeginLoadingMore == false) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent) {
                  _isBeginLoadingMore = true;
                  widget.loadMoreCallback?.call(true);
                }
              }
            }
            return false;
          },
          child: SmartRefresher(
            onRefresh: () {
              _refreshController.refreshCompleted();
              if (widget.refreshCallback != null) {
                widget.refreshCallback?.call(true);
                _refreshController.refreshCompleted();
              } else {
                _refreshController.refreshCompleted();
              }
            },
            enablePullDown: true,
            controller: _refreshController,
            header: MaterialClassicHeader(),
            child: ListView.separated(
              scrollDirection: widget.scrollDirection!,
              controller: widget.scrollController,
              shrinkWrap: true,
              padding: widget.padding ??
                  const EdgeInsets.only(
                    left: 0,
                    right: 0,
                    bottom: 40,
                    top: 0,
                  ),
              physics: _disableScroll()
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemBuilder: widget.itemBuilder,
              itemCount: widget.itemCount,
              separatorBuilder: (context, index) {
                return widget.separator ?? Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
