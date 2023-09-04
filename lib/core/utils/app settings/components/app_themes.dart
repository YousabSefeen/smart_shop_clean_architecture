import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData light(Locale currentLocale) {
    bool isEnglish = currentLocale == const Locale("en");

    getLetterSpacing(double num) {
      if (isEnglish) {
        return num;
      } else {
        return 0.5;
      }
    }

    return ThemeData(
      primarySwatch: Colors.amber,
      unselectedWidgetColor: Colors.red,
      scaffoldBackgroundColor: Colors.grey[100],
      secondaryHeaderColor: const Color(0xffe85d04),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xffe85d04),
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: getLetterSpacing(2),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 20.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color(0xffe85d04),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: 7.h,
            horizontal: 10.w,
          )),
        ),
      ),

      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xfff48c06),
        elevation: 8,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xfff48c06),
        thickness: 2,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.raleway(
          // Used in home(title Collection And Best Selling)
          // Used in Product detailsScree(Description )
          textStyle: TextStyle(
            fontSize: 27.sp,
            color: Colors.black,
            fontWeight: FontWeight.w800,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
        titleMedium: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
        titleSmall: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: 15.sp,
            color: const Color(0xff0d1b2a),
            fontWeight: FontWeight.w600,
            letterSpacing: getLetterSpacing(0.5),
            height: 1.2,
          ),
        ),
        bodyMedium: TextStyle(
          /// use in All number
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          /// old price number

          fontSize: 13.sp,
          fontWeight: FontWeight.w900,
          color: Colors.black54,
          decoration: TextDecoration.lineThrough,
        ),
        bodyLarge: GoogleFonts.raleway(
          fontSize: 22.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: getLetterSpacing(1.5),
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        labelSmall: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
      ),
    );
  }

  static ThemeData dark(Locale currentLocale) {
    bool isEnglish = currentLocale == const Locale("en");

    getLetterSpacing(double num) {
      if (isEnglish) {
        return num;
      } else {
        return 0.5;
      }
    }

    return ThemeData(
      primarySwatch: Colors.grey,
      unselectedWidgetColor: Colors.grey,
      secondaryHeaderColor: Colors.blue,
      scaffoldBackgroundColor: const Color(0xff0d1b2a),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xff0d1b2a),
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: getLetterSpacing(2),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 20.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w)),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xff4a4e69),
        elevation: 8,
      ),
      cardTheme: CardTheme(
        elevation: 8,
        color: const Color(0xff1b263b),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.blue,
        thickness: 2,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.raleway(
          // Used in home(title Collection And Best Selling)
          // Used in Product detailsScree(Description )
          textStyle: TextStyle(
            fontSize: 27.sp,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
        titleMedium: GoogleFonts.poppins(
          ///  (used Name product details)
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w700,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
        titleSmall: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 15.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: getLetterSpacing(0.5),
        )),
        bodyMedium: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          /// old price number
          fontSize: 13.sp,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          decoration: TextDecoration.lineThrough,
        ),
        bodyLarge: GoogleFonts.raleway(
          fontSize: 22.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: getLetterSpacing(1.5),
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        labelSmall: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            letterSpacing: getLetterSpacing(1),
          ),
        ),
      ),
    );
  }
}
