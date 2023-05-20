import 'package:flutter/material.dart';

extension ListWidgetExtension on Iterable<Widget> {
  Iterable<Widget> divideTiles({
    BuildContext? context,
    Color? color,
    EdgeInsets? padding,
  }) {
    assert(color != null || context != null);
    final tiles = toList();

    if (tiles.isEmpty || tiles.length == 1) {
      return tiles;
    }

    Widget wrapTile(Widget tile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tile,
          Container(
            margin: padding,
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, color: color),
              ),
            ),
          ),
        ],
      );
    }

    return <Widget>[
      ...tiles.take(tiles.length - 1).map(wrapTile),
      tiles.last,
    ];
  }
}
