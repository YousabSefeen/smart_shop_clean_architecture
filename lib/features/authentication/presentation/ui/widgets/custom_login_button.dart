import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/global_constants.dart';

class CustomLoginButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomLoginButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      splashColor: const Color.fromARGB(255, 128, 128, 255),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 3.5,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.r),
          gradient: const LinearGradient(
            colors: [
              Color(0xfffee440),
              Color(0xffdc2f02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: Text(text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: language == 'en' ? 2 : 0,
              ),
            )),
      ),
    );
  }
}
