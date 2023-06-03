import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../categories/domain/entities/categories.dart';
import '../../../domain/entities/category_details.dart';

class CategoriesState extends Equatable {
  final List<Categories> categories;
  final RequestState categoriesState;
  final String categoriesErrorMessage;
  final List<CategoryDetails> categoryDetails;
  final RequestState categoryDetailsState;
  final String categoryDetailsErrorMessage;

  const CategoriesState({
    this.categories = const [],
    this.categoriesState = RequestState.loading,
    this.categoriesErrorMessage = '',
    this.categoryDetails = const [],
    this.categoryDetailsState = RequestState.loading,
    this.categoryDetailsErrorMessage = '',
  });

  CategoriesState copyWith({
    List<Categories>? categories,
    RequestState? categoriesState,
    String? categoriesErrorMessage,
    List<CategoryDetails>? categoryDetails,
    RequestState? categoryDetailsState,
    String? categoryDetailsErrorMessage,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
      categoryDetails: categoryDetails ?? this.categoryDetails,
      categoryDetailsState: categoryDetailsState ?? this.categoryDetailsState,
      categoryDetailsErrorMessage:
          categoryDetailsErrorMessage ?? this.categoryDetailsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        categories,
        categoriesState,
        categoriesErrorMessage,
        categoryDetails,
        categoryDetailsState,
        categoryDetailsErrorMessage,
      ];
}
