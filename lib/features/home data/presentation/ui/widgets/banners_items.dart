import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../../../global widgets/loading_widget.dart';
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
            return const LoadingWidgets();
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
                return CachedNetworkImage(
                  imageUrl: state.banners[index].imageUrl,
                  errorWidget: (context, s, _) =>
                      Image.asset('assets/images/imageError.png'),
                  placeholder: (context, _) =>
                      Image.asset('assets/images/loading.gif'),
                  width: double.infinity,
                  fit: BoxFit.cover,
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
