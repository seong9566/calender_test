import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// 라이트 모드: 텍스트 테마만 Manrope 폰트로 적용
  static ThemeData get lightTheme {
    final base = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme),
      primaryTextTheme: GoogleFonts.manropeTextTheme(base.primaryTextTheme),
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: GoogleFonts.manrope(textStyle: titleStyle),
      ),
    );
  }

  /// 다크 모드: 텍스트 테마만 Manrope 폰트로 적용
  static ThemeData get darkTheme {
    final base = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme),
      primaryTextTheme: GoogleFonts.manropeTextTheme(base.primaryTextTheme),
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: GoogleFonts.manrope(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

final TextStyle titleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
final double defaultHPadding = 16;
final Color unSelectColor = Color(0xff61758A);
final Color selectColor = Color(0xff121417);
final Color indicatorColor = Color(0xffc4cdd8);
final Color primaryColor = Color(0xff223377);
