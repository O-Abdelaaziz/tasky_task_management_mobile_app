import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0XFF181818),
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xFF282828)),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFF181818),
    foregroundColor: Color(0XFFFFFFFF),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
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
      foregroundColor: WidgetStateProperty.all(Color(0XFFFFFCFC)),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0XFFFFFCFC),
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0XFFFFFFFF),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 0.857,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 0.857,
    ),
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      color: Color(0XFFFFFFFF),
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFFFFFCFC),
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    labelMedium: TextStyle(fontSize: 16, color: Color(0XFFFFFCFC)),
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Color(0XFFFFFFFF),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
    filled: true,
    fillColor: Color(0XFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
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
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFFC6C6C6)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0XFF181818),
    selectedItemColor: Color(0XFF15B86C),
    unselectedItemColor: Color(0XFFC6C6C6),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFF181818),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  ),
);
