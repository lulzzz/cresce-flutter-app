import 'package:flutter/widgets.dart';

Widget safeBuild(
  Object possibleNullValue,
  Widget Function(BuildContext) build,
) {
  if (possibleNullValue != null) {
    return Builder(builder: build);
  }
  return Container();
}
