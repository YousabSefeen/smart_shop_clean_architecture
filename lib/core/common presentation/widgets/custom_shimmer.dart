import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  const CustomShimmer({required this.height,required this.width  ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade200,
      enabled: true,
      child: Container(
        height:height,
        width: width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
