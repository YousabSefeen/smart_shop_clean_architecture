import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/controller/app_settings_cubit.dart';

import '../../utils/global_constants.dart';

class CustomAppAlerts {
  static void customSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..context
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor:
              message.contains('Add') || message.contains('الإضافة')
                  ? Colors.green
                  : Colors.red,
          duration: const Duration(milliseconds: 1200),
          animation: null,
        ),
      );
  }

  static customToast({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) =>
      showToast(
        message,

        textStyle: TextStyle(
          fontSize: 17.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        context: context,
        backgroundColor: backgroundColor,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        //const StyledToastPosition(align: Alignment.centerLeft, offset: 50)
        animDuration: const Duration(milliseconds: 900),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      );

  static void customDialog({
    required BuildContext context,
    required String message,
  }) {
    final bool isDark =
        AppSettingsCubit.object(context).theme == ThemeMode.dark;
    bool isEnglish = currentLocale == const Locale("en");
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: TextButton.icon(
                onPressed: null,
                icon: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                label: Text(
                  'connected'.translate(context),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: isDark ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: isEnglish ? 1 : 0,
                  ),
                  maxLines: 4,
                ),
              ),
              content: Text(
                'internetConnected'.translate(context),
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 17,
                  color: isDark ? Colors.grey : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  letterSpacing: isEnglish ? 0.5 : 0,
                  height: 1.2,
                )),
              ),
              actions: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () => Navigator.pop(context),
                  label: Text(
                    'retry'.translate(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ));
  }

//***

  static void logoutAlert({
    required BuildContext context,
    required void Function()? onLogout,
  }) {
    final bool isDark =
        AppSettingsCubit.object(context).theme == ThemeMode.dark;
    bool isEnglish = currentLocale == const Locale("en");
    double getLetterSpacing() {
      if (isEnglish) {
        return 1.0;
      } else {
        return 0.5;
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Column(
          children: [
            Text(
              'logoutAlert'.translate(context),
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.grey : Colors.black,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: onLogout,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  'logout'.translate(context),
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: getLetterSpacing(),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  'cancel'.translate(context),
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: getLetterSpacing(),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //***
  static void alertNoInternet({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..context
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          animation: null,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.only(bottom: 35, left: 22, right: 25),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(
                Icons.wifi_off,
                size: 22.sp,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                message,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
  }
}
