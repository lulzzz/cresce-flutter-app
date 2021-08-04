import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class BitText extends StatelessWidget {
  final String text;
  final BitTextStyleFactory style;

  const BitText(
    this.text, {
    Key key,
    this.style = BitTextStyles.body2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      overflow: TextOverflow.fade,
      softWrap: false,
      style: style.make(context),
    );
  }
}

abstract class BitTextStyleFactory {
  TextStyle make(BuildContext context);
}

class TextColorVariations implements BitTextStyleFactory {
  final BitTextStyleFactory style;

  const TextColorVariations(this.style);

  @override
  TextStyle make(BuildContext context) => style.make(context);

  BitTextStyleFactory asPrimary(BuildContext context) =>
      _PrimaryTextStyleFactory(this);

  BitTextStyleFactory asSecondary(BuildContext context) =>
      _SecondaryTextStyleFactory(this);

  BitTextStyleFactory asLabel(BuildContext context) =>
      _LabelTextStyleFactory(this);
}

class _PrimaryTextStyleFactory implements BitTextStyleFactory {
  final BitTextStyleFactory style;

  const _PrimaryTextStyleFactory(this.style);

  @override
  TextStyle make(BuildContext context) =>
      style.make(context).copyWith(color: context.theme.primaryColor);
}

class _SecondaryTextStyleFactory implements BitTextStyleFactory {
  final BitTextStyleFactory style;

  const _SecondaryTextStyleFactory(this.style);

  @override
  TextStyle make(BuildContext context) =>
      style.make(context).copyWith(color: context.theme.backgroundColor);
}

class _LabelTextStyleFactory implements BitTextStyleFactory {
  final BitTextStyleFactory style;

  const _LabelTextStyleFactory(this.style);

  @override
  TextStyle make(BuildContext context) =>
      style.make(context).copyWith(color: context.theme.hintColor);
}

class BitTextStyles {
  static const TextColorVariations subtitle1 =
      TextColorVariations(_Subtitle1TextStyleFactory());
  static const TextColorVariations subtitle2 =
      TextColorVariations(_Subtitle2TextStyleFactory());
  static const TextColorVariations caption =
      TextColorVariations(_CaptionTextStyleFactory());
  static const TextColorVariations body1 =
      TextColorVariations(_Body1TextStyleFactory());
  static const TextColorVariations body2 =
      TextColorVariations(_Body2TextStyleFactory());
  static const TextColorVariations h1 =
      TextColorVariations(_H1TextStyleFactory());
  static const TextColorVariations h2 =
      TextColorVariations(_H2TextStyleFactory());
  static const TextColorVariations h3 =
      TextColorVariations(_H3TextStyleFactory());
  static const TextColorVariations h4 =
      TextColorVariations(_H4TextStyleFactory());
  static const TextColorVariations h5 =
      TextColorVariations(_H5TextStyleFactory());
  static const TextColorVariations h6 =
      TextColorVariations(_H6TextStyleFactory());
}

class _Subtitle1TextStyleFactory implements BitTextStyleFactory {
  const _Subtitle1TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.subtitle1;
}

class _Subtitle2TextStyleFactory implements BitTextStyleFactory {
  const _Subtitle2TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.subtitle2;
}

class _CaptionTextStyleFactory implements BitTextStyleFactory {
  const _CaptionTextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.caption;
}

class _Body1TextStyleFactory implements BitTextStyleFactory {
  const _Body1TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.bodyText1;
}

class _Body2TextStyleFactory implements BitTextStyleFactory {
  const _Body2TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.bodyText2;
}

class _H1TextStyleFactory implements BitTextStyleFactory {
  const _H1TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline1;
}

class _H2TextStyleFactory implements BitTextStyleFactory {
  const _H2TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline2;
}

class _H3TextStyleFactory implements BitTextStyleFactory {
  const _H3TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline3;
}

class _H4TextStyleFactory implements BitTextStyleFactory {
  const _H4TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline4;
}

class _H5TextStyleFactory implements BitTextStyleFactory {
  const _H5TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline5;
}

class _H6TextStyleFactory implements BitTextStyleFactory {
  const _H6TextStyleFactory();
  @override
  TextStyle make(BuildContext context) => context.theme.textTheme.headline6;
}
