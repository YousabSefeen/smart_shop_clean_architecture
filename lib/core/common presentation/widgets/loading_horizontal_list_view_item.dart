import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_shimmer.dart';

class LoadingHorizontalListView extends StatelessWidget {
  const LoadingHorizontalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(height: 50, width: 180),
            CustomShimmer(height: 30, width: 90),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 160,
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) => const Column(
                children: [
                   CustomShimmer(height: 80, width: 125),
                    SizedBox(height: 10),
                    CustomShimmer(height: 30, width: 125),
                ],
              ),
          ),
        ),
      ],
    );
  }
}
