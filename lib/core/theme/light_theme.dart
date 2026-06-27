import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0XFFF6F7F9),
  colorScheme: ColorScheme.light(primaryContainer: Color(0xFFFFFFFF)),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFFF6F7F9),
    foregroundColor: Color(0XFF161F1B),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF15B86C);
      }
      return Color(0XFF161F1B);
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF161F1B);
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0XFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0XFF161F1B)),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0XFF161F1B),
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 0.857,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0XFF161F1B),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 0.857,
    ),
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      color: Color(0XFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFF161F1B),
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    labelMedium: TextStyle(fontSize: 16, color: Color(0XFF161F1B)),
    titleLarge: TextStyle(
      color: Color(0xFFA6A6A6),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF494949),
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFF161F1B),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    focusColor: Color(0xFFD1DAD6),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    // 2. Border when validator returns an error and the field is focused
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFF6A4640)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0XFFF6F7F9),
    selectedItemColor: Color(0XFF15B86C),
    unselectedItemColor: Color(0XFF161F1B),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0XFFF6F7F9)),
);
