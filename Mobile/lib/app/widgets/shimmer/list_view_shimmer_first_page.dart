import 'package:flutter/material.dart';

class ListViewShimmerFirstPage extends StatelessWidget {
  final Widget item;
  final Widget separatorItem;
  final int itemCount;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final double? paddingWidth;
  final double? paddingHeight;

  const ListViewShimmerFirstPage({
    Key? key,
    required this.item,
    required this.itemCount,
    required this.separatorItem,
    this.physics,
    this.scrollDirection,
    this.paddingWidth,
    this.paddingHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: paddingWidth ?? 0, vertical: paddingHeight ?? 0),
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (context, index) => item,
      separatorBuilder: (context, index) => separatorItem,
    );
  }
}