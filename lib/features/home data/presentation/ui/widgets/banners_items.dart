import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_shimmer.dart';

import '../../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../controller/cubit/home_cubit.dart';
import '../../controller/states/home_states.dart';

class BannersItems extends StatelessWidget {
  const BannersItems({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.bannersState != current.bannersState,
      builder: (context, state) {
        switch (state.bannersState) {
          case RequestState.loading:
            return const CustomShimmer(
                height: double.infinity, width: double.infinity);
          case RequestState.loaded:
            return CarouselSlider.builder(
              itemCount: state.banners.length,
              options: CarouselOptions(
                height: double.infinity,
                autoPlay: true,
                enlargeCenterPage: true,
                scrollDirection: Axis.vertical,
              ),
              itemBuilder: (context, index, _) {
                return CustomCachedNetworkImage(
                  imageUrl: state.banners[index].imageUrl,
                  width: double.infinity,
                );
              },
            );

          case RequestState.error:
            return const AnErrorWidget();
        }
      },
    );
  }
}
