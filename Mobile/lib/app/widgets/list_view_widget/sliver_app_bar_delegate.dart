import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double extentSize;

  SliverAppBarDelegate({
    required this.child,
    required this.extentSize,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => extentSize;

  @override
  double get minExtent => extentSize;
}
