import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  BitSizes get sizes => BitTheme.of(this).size;

  BitBorders get borders => BitTheme.of(this).borders;

  BitAnimationDurations get animation => BitTheme.of(this)?.animations;

  double calculateCardWidth() => CardSize.of(this)?.calculateWidth(this);
}

class ThemeFactory {
  Widget makeHome({Widget child}) {
    return BitTheme(
      child: child,
      borders: BitBorders(),
    );
  }

  ThemeData makeBlueTheme() {
    var primaryColor = Colors.blue;
    var secondaryColor = Colors.grey;
    var backgroundColor = Colors.white;
    var labelColor = Colors.black87.withOpacity(0.4);

    return _makeTheme(
      primaryColor,
      backgroundColor,
      secondaryColor,
      labelColor,
    );
  }

  ThemeData makePurpleTheme() {
    var primaryColor = Colors.deepPurple;
    var secondaryColor = Colors.grey;
    var backgroundColor = Colors.white;
    var labelColor = Colors.black87.withOpacity(0.4);

    return _makeTheme(
      primaryColor,
      backgroundColor,
      secondaryColor,
      labelColor,
    );
  }

  ThemeData _makeTheme(
    Color primaryColor,
    Color backgroundColor,
    Color secondaryColor,
    Color labelColor,
  ) {
    var theme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
      ),
      accentColor: primaryColor,
      primaryColor: primaryColor,
      primarySwatch: primaryColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
      ),
      backgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: Color.alphaBlend(
        backgroundColor.withOpacity(0.7),
        secondaryColor.withOpacity(0.4),
      ),
      // context: Copy | Cut | Paste
      hintColor: labelColor,
      //highlightColor: secondaryColor,
      //focusColor: Colors.amberAccent,
      //buttonColor: Colors.amberAccent,
      //indicatorColor: Colors.amberAccent,
      //splashColor: Colors.amberAccent,
      //hoverColor: Colors.amberAccent,
      //dividerColor: Colors.amberAccent,
      //toggleableActiveColor: Colors.amberAccent,
      //bottomAppBarColor: Colors.amberAccent,
      //dialogBackgroundColor: Colors.amberAccent,
      //disabledColor: Colors.amberAccent,
      //errorColor: Colors.amberAccent,
      //secondaryHeaderColor: Colors.amberAccent,
      //selectedRowColor: Colors.amberAccent,
      //unselectedWidgetColor: Colors.amberAccent,
      //primaryColorDark: Colors.amberAccent,
      //primaryColorLight: Colors.amberAccent,
    );

    return theme.copyWith(
      // chipTheme: buildChipThemeData(),
      inputDecorationTheme: _buildInputDecorationTheme(theme),
      textTheme: _buildTextTheme(theme),
      floatingActionButtonTheme: _buildFloatingActionButtonThemeData(theme),
    );
  }

  static FloatingActionButtonThemeData _buildFloatingActionButtonThemeData(
    ThemeData theme,
  ) {
    return FloatingActionButtonThemeData(
      backgroundColor: theme.primaryColor,
      elevation: 4.0,
      highlightElevation: 2.0,
      shape: StadiumBorder(),
    );
  }

  static TextTheme _buildTextTheme(ThemeData theme) {
    return theme.textTheme.copyWith(
      button: TextStyle(
        color: theme.backgroundColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      subtitle1: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      subtitle2: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      caption: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
      ),
      headline1: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w200,
        fontSize: 60.0,
      ),
      headline2: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
        fontSize: 40.0,
      ),
      headline3: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
        fontSize: 34.0,
      ),
      headline4: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
        fontSize: 26.0,
      ),
      headline5: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
        fontSize: 22.0,
      ),
      headline6: TextStyle(
        color: theme.hintColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(ThemeData theme) {
    final roundBorderRadius = BorderRadius.circular(100);
    final primaryColor = theme.primaryColor;

    return theme.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: primaryColor.withOpacity(0.1),
      focusedBorder: OutlineInputBorder(
        borderRadius: roundBorderRadius,
        borderSide: BorderSide(
          color: theme.primaryColor,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: roundBorderRadius,
        borderSide: BorderSide(
          width: 0.0,
          style: BorderStyle.none,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: roundBorderRadius,
      ),
    );
  }
}

class BitTheme extends InheritedWidget {
  final BitSizes size;
  final BitBorders borders;
  final BitAnimationDurations animations;

  const BitTheme({
    Key key,
    this.size = const BitSizes(),
    this.animations = const BitAnimationDurations(),
    this.borders,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget as BitTheme != this;
  }

  static BitTheme of(BuildContext context) {
    var bitTheme = context.dependOnInheritedWidgetOfExactType<BitTheme>() ??
        BitTheme(
          borders: BitBorders(),
        );
    bitTheme._setContext(context);
    return bitTheme;
  }

  void _setContext(BuildContext context) {
    borders._setContext(context);
  }
}

class BitAnimationDurations {
  final Duration extraShort;
  final Duration short;
  final Duration medium;
  final Duration long;

  const BitAnimationDurations({
    this.extraShort = const Duration(milliseconds: 150),
    this.short = const Duration(milliseconds: 250),
    this.medium = const Duration(milliseconds: 700),
    this.long = const Duration(milliseconds: 1150),
  });
}

class BitSizes {
  final double none;
  final double small;
  final double medium;
  final double mediumSmall;
  final double large;
  final double extraLarge;

  const BitSizes({
    this.none = 0.0,
    this.small = 10.0,
    this.mediumSmall = 16.0,
    this.medium = 20.0,
    this.large = 30.0,
    this.extraLarge = 40.0,
  });
}

class BitBorders {
  BuildContext context;

  BorderRadius get circular => BorderRadius.circular(context.sizes.medium);

  Border get round {
    return Border.all(
      width: 1.2,
      color: context.theme.primaryColor,
    );
  }

  void _setContext(BuildContext buildContext) {
    context = buildContext;
  }
}
