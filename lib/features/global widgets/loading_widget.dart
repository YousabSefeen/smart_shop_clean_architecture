import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidgets extends StatelessWidget {
  const LoadingWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
