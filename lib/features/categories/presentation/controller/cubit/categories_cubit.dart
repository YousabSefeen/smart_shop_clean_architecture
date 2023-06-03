import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base  use case/base_use_case.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../categories/domain/use cases/get_categories_use_case.dart';
import '../../../domain/use cases/get_category_details_use_case.dart';
import '../states/categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryDetailsUseCase getCategoryDetailsUseCase;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.getCategoryDetailsUseCase,
  }) : super(const CategoriesState());

  static CategoriesCubit object(context) => BlocProvider.of(context);

  FutureOr<void> getCategories() async {
    final result = await getCategoriesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          categoriesState: RequestState.error,
          categoriesErrorMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          categories: r,
          categoriesState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getCategoryDetails({required int categoryId}) async {
    final result = await getCategoryDetailsUseCase(
      GetCategoryDetailsParameters(categoryId: categoryId),
    );

    result.fold(
        (l) => emit(state.copyWith(
              categoryDetailsState: RequestState.error,
              categoryDetailsErrorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
              categoryDetailsState: RequestState.loaded,
              categoryDetails: r,
            )));
  }
}
