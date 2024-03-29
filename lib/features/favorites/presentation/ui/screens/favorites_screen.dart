import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/screens/empty_screen.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../../core/common presentation/widgets/loading_widget.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../presentation/controller/cubit/favorites_cubit.dart';
import '../../../presentation/controller/states/favorites_state.dart';
import '../widgets/favorite_product.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'.translate(context)),
      ),
      body: SafeArea(
        child: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.favoritesState) {
              case RequestState.loading:
                return const LoadingWidgets();
              case RequestState.loaded:
                return state.favorites.isEmpty
                    ? EmptyScreen(
                        topPadding: 0,
                        text: 'emptyFavoriteDes'.translate(context),
                        icon: Icons.star_border_outlined,
                      )
                    : ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.favorites.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 30),
                        itemBuilder: (context, index) {
                          return FavoriteProduct(
                            productItemFavorite: state.favorites[index],
                            index: index,
                          );
                        },
                      );
              case RequestState.error:
                return Center(
                  child: CustomErrorWidget(
                    errorMessage: state.favoritesErrorMessage,
                    errorCategoryName: 'favorites'.translate(context),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
