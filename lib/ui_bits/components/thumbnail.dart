import 'dart:typed_data';

import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

class ThumbnailData {
  String title;
  String subTitle;
  Future<BitImage> image;

  ThumbnailData({
    this.title,
    this.subTitle,
    this.image,
  });
}

class BitThumbnail extends StatelessWidget {
  final double width;
  final Uint8List image;
  final ThumbnailData data;
  final VoidCallback onTap;

  const BitThumbnail({
    Key key,
    this.width,
    this.image,
    this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BitCard(
      onTap: onTap,
      padding: BitEdgeInsetsOptions.none,
      children: [
        BitSmallPadding(
          child: Center(
            child: CircleImageWidget(
              width: width,
              image: data.image,
            ),
          ),
        ),
        BitSmallPadding(
          options: BitEdgeInsetsOptions.combine([
            BitEdgeInsetsOptions.top,
            BitEdgeInsetsOptions.bottom,
            BitEdgeInsetsOptions.left,
            BitEdgeInsetsOptions.right,
          ]),
          child: Center(
            child: Column(
              children: [
                BitText(
                  data.title,
                  style: BitTextStyles.h5.asPrimary(context),
                ),
                BitText(
                  data.subTitle,
                  style: BitTextStyles.subtitle1,
                ),
              ],
            ),
          ),
        )
      ],
      width: width,
      height: width * 1.25,
    );
  }
}
