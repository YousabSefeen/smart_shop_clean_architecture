import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/global_constants.dart';

class CustomSearchField extends StatelessWidget {
  final void Function()? onPressedSuffixIcon;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController controller;

  const CustomSearchField({
    Key? key,
    required this.onPressedSuffixIcon,
    required this.onFieldSubmitted,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.1,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'hintSearch'.translate(context),
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15.sp, color: Colors.black54),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          fillColor: Theme.of(context).chipTheme.backgroundColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.black, width: 0),
          ),
          suffixIcon: IconButton(
              onPressed: onPressedSuffixIcon,
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
                size: 25.w,
              )),
        ),
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodySmall,
        cursorColor: Colors.amber,
      ),
    );
  }
}
