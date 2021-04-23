import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

extension BitContextExtension on BuildContext {
  double getTextWidth(String label, TextStyle textStyle) {
    final renderParagraph = RenderParagraph(
      TextSpan(
        text: label,
        style: TextStyle(
          fontSize: textStyle.fontSize,
          color: textStyle.color,
          fontWeight: textStyle.fontWeight,
          letterSpacing: textStyle.letterSpacing,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    renderParagraph.layout(BoxConstraints(minWidth: 120.0));

    return renderParagraph
            .getMinIntrinsicWidth(textStyle.fontSize)
            .ceilToDouble() +
        45.0;
  }
}
