import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_shimmer.dart';

class LoadingGridView extends StatelessWidget {
  const LoadingGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,

      /// It is very important that someone else can get me an error
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 20),

      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: 40,

      itemBuilder: (context, index) => const CustomShimmer(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
