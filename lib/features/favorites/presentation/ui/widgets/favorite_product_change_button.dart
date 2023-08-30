import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../controller/cubit/favorites_cubit.dart';
import '../../controller/states/favorites_state.dart';

class FavoriteProductChangeButton extends StatelessWidget {
  final int productId;

  const FavoriteProductChangeButton({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return IconButton(
          onPressed: () async => await FavoritesCubit.object(context)
              .changeFavorite(id: productId, context: context),
          icon: Icon(
            favorites[productId] ?? false
                ? Icons.star
                : Icons.star_border_outlined,
            size: 23.sp,
            color: isDark ? Colors.amber : const Color(0xfff48c06),
          ),
        );
      },
    );
  }
}
