import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatefulWidget {
  final String errorCategoryName;
  final String errorMessage;

  const CustomErrorWidget({
    required this.errorMessage,
    required this.errorCategoryName,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomErrorWidget> createState() => _CustomErrorWidgetState();
}

class _CustomErrorWidgetState extends State<CustomErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.ltr ,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xffE0B1AA),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.error,
                size: 35.sp,
                color: Colors.red,
              ),
              label: Text(
                'An error occurred while displaying ${widget.errorCategoryName}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(thickness: 2, color: Colors.black54),
            RichText(
              text: TextSpan(
                  text: 'Error Message: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: widget.errorMessage,
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
