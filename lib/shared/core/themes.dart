import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appThemeData = ThemeData(
  // -----------------------------------------------
  //                  Colors
  // -----------------------------------------------
  primaryColor: CustomColors.primary, // Black
  primaryColorLight: CustomColors.primaryLight,
  hintColor: CustomColors.hint,
  disabledColor: CustomColors.disabled,

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.primary, // Black
    onPrimary: Colors.white, // White text on black
    secondary: CustomColors.hint, // Medium grey
    onSecondary: Colors.black, // Black text on grey
    error: CustomColors.error,
    onError: Colors.white,
    background: CustomColors.backgroundLight, // White
    onBackground: CustomColors.textLight, // Dark grey text on white
    surface: CustomColors.backgroundLight, // White
    onSurface: CustomColors.textLight, // Dark grey text on white
  ),

  // -----------------------------------------------
  //                  Widget Styles
  // -----------------------------------------------
  scaffoldBackgroundColor: CustomColors.backgroundLight,

  appBarTheme: AppBarTheme(
    color: CustomColors.backgroundLight,
    elevation: 0.0,
    actionsIconTheme: IconThemeData(
      color: CustomColors.textLight,
    ),
    shape: Border(
      bottom: BorderSide(
        color: CustomColors.hint.withOpacity(0.1), // Changed to use hint color instead of dark background
        width: 1.0,
      ),
    ),
  ),

  tabBarTheme: TabBarThemeData(
    labelColor: CustomColors.primary, // Black for selected tab
    tabAlignment: TabAlignment.start,
    unselectedLabelColor: CustomColors.hint, // Medium grey for unselected tab
    indicatorSize: TabBarIndicatorSize.label,
    indicator: UnderlineTabIndicator(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: CustomColors.primary, // Black indicator
        width: 4.0,
      ),
    ),
  ),

  sliderTheme: SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    activeTrackColor: CustomColors.primary, // Black active track
    inactiveTrackColor: CustomColors.hint, // Grey inactive track
    thumbColor: CustomColors.primary, // Black thumb
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.primary, // Black FAB
    foregroundColor: Colors.white, // White icon
    iconSize: 30.0,
  ),

  // -----------------------------------------------
  //                  Text Styles
  // -----------------------------------------------
  fontFamily: 'Century Gothic',
  textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textLight, // Dark grey
      ),
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textLight, // Dark grey
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textLight, // Dark grey
      ),
      bodyMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textLight, // Dark grey
      ),
      bodySmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textLight, // Dark grey
      ),
      labelSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textLight, // Dark grey
      )),
);

final ThemeData appThemeDataDark = ThemeData(
  // -----------------------------------------------
  //                  Colors
  // -----------------------------------------------
  primaryColor: CustomColors.primaryDark, // White for dark theme
  primaryColorLight: CustomColors.primaryLightDark,
  hintColor: CustomColors.hint,
  disabledColor: CustomColors.disabled,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.primaryDark, // White
    onPrimary: Colors.black, // Black text on white
    secondary: CustomColors.hint, // Medium grey
    onSecondary: Colors.white, // White text on grey
    error: CustomColors.error,
    onError: Colors.white,
    background: CustomColors.backgroundDark, // Black
    onBackground: CustomColors.textDark, // White text on black
    surface: CustomColors.backgroundDark, // Black
    onSurface: CustomColors.textDark, // White text on black
  ),

  // -----------------------------------------------
  //                  Widget Styles
  // -----------------------------------------------
  scaffoldBackgroundColor: CustomColors.backgroundDark,

  appBarTheme: AppBarTheme(
    color: CustomColors.backgroundDark,
    elevation: 0.0,
    actionsIconTheme: IconThemeData(
      color: CustomColors.textDark, // Changed to textDark (white) for dark theme
    ),
    shape: Border(
      bottom: BorderSide(
        color: CustomColors.textDark.withOpacity(0.1), // White with opacity
        width: 1.0,
      ),
    ),
  ),

  tabBarTheme: TabBarThemeData(
    labelColor: CustomColors.primaryDark, // White for selected tab in dark theme
    tabAlignment: TabAlignment.start,
    unselectedLabelColor: CustomColors.hint, // Medium grey for unselected tab
    indicatorSize: TabBarIndicatorSize.label,
    indicator: UnderlineTabIndicator(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: CustomColors.primaryDark, // White indicator in dark theme
        width: 4.0,
      ),
    ),
  ),

  sliderTheme: SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    activeTrackColor: CustomColors.primaryDark, // White active track in dark theme
    inactiveTrackColor: CustomColors.hint, // Grey inactive track
    thumbColor: CustomColors.primaryDark, // White thumb in dark theme
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.primaryDark, // White FAB in dark theme
    foregroundColor: Colors.black, // Black icon in dark theme
    iconSize: 30.0,
  ),

  // -----------------------------------------------
  //                  Text Styles
  // -----------------------------------------------
  fontFamily: 'Century Gothic',
  textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textDark, // White
      ),
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textDark, // White
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.textDark, // White
      ),
      bodyMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textDark, // White
      ),
      bodySmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textDark, // White
      ),
      labelSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.textDark, // White
      )),
);
