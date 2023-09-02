import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? topPadding;

  const EmptyScreen({
    this.topPadding,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: topPadding ?? height * 0.1),
        Icon(
          icon,
          size: height * 0.18,
          color: Theme.of(context).dividerTheme.color,
        ),
        SizedBox(height: height * 0.07),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 22.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
