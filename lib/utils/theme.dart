import 'package:dockcheck_web/utils/colors.dart';
import 'package:flutter/material.dart';

const double _kBorderRadius = 2.0;
const double _kDefaultElevation = 4.0;

class DockTheme {
  DockTheme._();

  static ThemeData theme = ThemeData(
    fontFamily: defaultFontName,
    useMaterial3: true,
    textTheme: defaultTextTheme,
    appBarTheme: defaultAppBarTheme,
    tabBarTheme: defaultTabBarTheme,
    cardTheme: defaultCardTheme,
    bottomAppBarTheme: defaultBottomAppBarTheme,
    scaffoldBackgroundColor: DockColors.background,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: DockColors.iron100,
        onPrimary: DockColors.white,
        secondary: DockColors.slate100,
        onSecondary: DockColors.white,
        error: DockColors.danger100,
        onError: DockColors.danger100,
        background: DockColors.background,
        onBackground: DockColors.background,
        surface: DockColors.white,
        onSurface: DockColors.slate100),
  );

  static const String defaultFontName = 'ProximaNova';

  static const TextTheme defaultTextTheme = TextTheme(
    labelLarge: buttonTextStyle,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle h1 = TextStyle(
    color: DockColors.iron100,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
  );

  static const TextStyle h2 = TextStyle(
    color: DockColors.iron100,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'ProximaNova',
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  );

  static const TextStyle caption1 = TextStyle(
    color: DockColors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption2 = TextStyle(
    color: DockColors.iron60,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyIron100 = TextStyle(
    color: DockColors.iron100,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle selectedLabelTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: DockColors.iron100,
    fontFamily: 'ProximaNova',
  );

  static const TextStyle unselectLabelTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: DockColors.iron60,
    fontFamily: 'ProximaNova',
  );

  static const TextStyle headLineForange120 = TextStyle(
    color: DockColors.forange120,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const subhead1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const subhead2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle headLine = TextStyle(
    color: DockColors.iron100,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextStyle bodyGrey = TextStyle(
    color: DockColors.iron80,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle largeText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
  );

  static const TextStyle tabStyle = TextStyle(
    color: DockColors.iron80,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle tabStyleRed = TextStyle(
    color: DockColors.danger100,
    fontWeight: FontWeight.w600,
  );

  static const TextHeightBehavior textHeightBehavior = TextHeightBehavior(
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TabBarTheme defaultTabBarTheme = TabBarTheme(
    labelColor: DockColors.iron100,
    labelStyle: selectedLabelTextStyle,
    unselectedLabelColor: DockColors.iron60,
    unselectedLabelStyle: unselectLabelTextStyle,
    indicator: const BoxDecoration(
      border: Border(top: BorderSide(width: 2.0, color: DockColors.iron100)),
    ),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
  );

  static final AppBarTheme defaultAppBarTheme = AppBarTheme(
    backgroundColor: DockColors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: DockColors.slate110.withOpacity(0.18),
    titleTextStyle: title,
    elevation: _kDefaultElevation,
    scrolledUnderElevation: _kDefaultElevation,
  );

  static final AppBarTheme timesheetAppBarTheme = defaultAppBarTheme.copyWith(
    scrolledUnderElevation: 1.0,
    elevation: _kDefaultElevation,
  );

  static const BottomAppBarTheme defaultBottomAppBarTheme = BottomAppBarTheme(
    elevation: 1.0,
  );

  static final ButtonStyle buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 11.5,
      ),
    ),
  );

  static final ButtonStyle cancelButtonStyle = buttonStyle.copyWith(
    side: MaterialStateProperty.all(
      const BorderSide(color: DockColors.iron100),
    ),
  );

  static ButtonStyle animatedLoadingButtonStyle = buttonStyle.copyWith(
    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return DockColors.iron100.withOpacity(0.3);
        }
        return DockColors.slate100;
      },
    ),
  );

  static final ButtonStyle confirmationButtonStyle = buttonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(DockColors.iron100),
  );

  static final ButtonStyle destructiveButtonStyle = buttonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(DockColors.danger110),
  );

  static final ButtonStyle forangeCTAButtonStyle = buttonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(DockColors.forange20),
    side: MaterialStateProperty.all(
      const BorderSide(color: DockColors.forange110),
    ),
  );

  static final ButtonStyle clockButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(DockColors.iron100),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ),
  );

  static final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: DockColors.slate100,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    side: const BorderSide(width: 1, color: DockColors.slate100),
  );

  static final ButtonStyle textLinkOutlineButtonStyle =
      OutlinedButton.styleFrom(
    side: const BorderSide(color: DockColors.iron30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2.0),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 9,
    ),
  );

  static final ButtonStyle phoneCallButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: DockColors.iron30,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    side: const BorderSide(width: 1, color: DockColors.iron30),
  );

  static final BoxShadow defaultShadow = BoxShadow(
    color: DockColors.slate100.withOpacity(0.18),
    spreadRadius: 0,
    blurRadius: 12,
    offset: const Offset(2, 0),
  );

  static final BoxShadow elevatedShadow = BoxShadow(
    color: DockColors.slate100.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 12,
    offset: const Offset(0, 2),
  );

  static final BoxShadow noteInputFieldShadow = BoxShadow(
    color: DockColors.slate100.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 12,
    offset: const Offset(2, 0),
  );

  static const BoxShadow expandDescriptionButtonShadow = BoxShadow(
    color: DockColors.white,
    spreadRadius: 0,
    blurRadius: 13,
    offset: Offset(0, -5),
  );

  static const viewOnlyTagDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
  );

  static final timesheetTimestampBadgeDecoration = BoxDecoration(
    color: DockColors.forange20,
    border: Border.all(color: DockColors.forange40),
    borderRadius: const BorderRadius.all(Radius.circular(_kBorderRadius)),
  );

  static const scheduleTentativeBadgeDecoration = BoxDecoration(
    color: DockColors.iron20,
    borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
  );

  static final cardDecoration = BoxDecoration(
    color: DockColors.white,
    borderRadius: const BorderRadius.all(Radius.circular(_kBorderRadius)),
    boxShadow: [DockTheme.defaultShadow],
  );

  static final defaultCardTheme = CardTheme(
      elevation: 4.0,
      surfaceTintColor: DockColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      shadowColor: DockColors.slate100.withOpacity(0.1));

  static final outlinedCardDecoration = BoxDecoration(
    color: DockColors.white,
    border: Border.all(color: DockColors.iron20, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(_kBorderRadius)),
    boxShadow: [DockTheme.defaultShadow],
  );

  static final outlinedErrorCardDecoration = BoxDecoration(
    border: Border.all(color: DockColors.danger100, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(2)),
  );

  static const timesheetPinnedHeaderDecoration = BoxDecoration(
    color: DockColors.white,
    border: Border(
      bottom: BorderSide(
        color: DockColors.iron10,
        width: 1.0,
      ),
    ),
  );

  static final inputDecoration = InputDecoration(
    hintStyle: DockTheme.body.copyWith(
      color: DockColors.iron60,
      height: 1.4,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: DockColors.iron30,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  );

  static const inputFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
    hintText: ' ',
    border: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
  );

  static final inputCardDecoration = BoxDecoration(
    border: Border.all(color: DockColors.iron20),
    borderRadius: const BorderRadius.all(Radius.circular(2)),
  );

  static final kebabMenuStyle = MenuStyle(
    elevation: const MaterialStatePropertyAll(8),
    shadowColor: MaterialStatePropertyAll(
      DockColors.slate100.withOpacity(0.3),
    ),
    surfaceTintColor: MaterialStatePropertyAll(
      DockColors.slate100.withOpacity(0.3),
    ),
    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
    minimumSize: const MaterialStatePropertyAll(Size.zero),
    shape: const MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
      ),
    ),
  );
}
