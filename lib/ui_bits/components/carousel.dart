import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class BitCarousel extends StatefulWidget {
  final List<Widget> children;
  final BitAnimation animation;

  BitCarousel({
    this.children,
    this.animation = const BitNoAnimation(),
  });

  @override
  _BitCarouselState createState() => _BitCarouselState();
}

class _BitCarouselState extends State<BitCarousel> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (shouldSkipBuild()) {
      return Container();
    }

    return widget.animation.wrapWidget(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: buildChildren().toList(),
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }

  bool shouldSkipBuild() => widget.children == null || widget.children.isEmpty;

  Iterable<Widget> buildChildren() sync* {
    yield widget.children.first;
    for (var widget in widget.children.skip(1)) {
      yield SizedBox(width: context.sizes.small);
      yield widget;
    }
  }
}
