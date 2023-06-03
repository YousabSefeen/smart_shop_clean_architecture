import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnErrorWidget extends StatelessWidget {
  const AnErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.white, size: 25.w),
            SizedBox(width: 10.w),
            Text(
              'An Error Occurred.\nplease try again later',
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
