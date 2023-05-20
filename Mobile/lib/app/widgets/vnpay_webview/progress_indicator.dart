import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';

class InfiniteProgressIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final Color? color;
  const InfiniteProgressIndicator({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.w,
      width: 24.w,
      padding: padding,
      child: CupertinoActivityIndicator(
        radius: 14.r,
        color: color,
      ),
    );
  }
}
