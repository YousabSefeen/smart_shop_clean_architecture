import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base  use case/base_use_case.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../domain/use cases/change_cart_use_case.dart';
import '../../../domain/use cases/get_cart_use_case.dart';
import '../../../domain/use cases/update_cart_use_case.dart';
import '../states/cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  final GetCartUseCase getCartUseCase;
  final ChangeCartUseCase changeCartUseCase;
  final UpdateCartUseCase updateCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.changeCartUseCase,
    required this.updateCartUseCase,
  }) : super(const CartStates());

  static CartCubit object(context) => BlocProvider.of(context);

  FutureOr<void> getCart() async {
    final result = await getCartUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
              cartErrorMessage: l.errorMessage,
              cartState: RequestState.error,
            )),
        (r) => emit(state.copyWith(
              cart: r,
              cartState: RequestState.loaded,
            )));
  }

  FutureOr<void> changeCart({
    required BuildContext context,
    required int productId,
  }) async {
    carts[productId] = !carts[productId]!;
    final result = await changeCartUseCase(
      ChangeCartParameters(productId: productId),
    );
    result.fold(
      (l) => emit(state.copyWith(
        changeCartState: RequestState.error,
        changeCartErrorMessage: l.errorMessage,
      )),
      (r) {
        emit(
          state.copyWith(
            changeCart: r,
            changeCartState: RequestState.loaded,
          ),
        );
        customSnackBar(
          context: context,
          message: state.changeCart!.message,
        );
      },
    );
    getCart();
  }

  FutureOr<void> updateCart({
    required BuildContext context,
    required int quantity,
    required int productId,
  }) async {
    final result = await updateCartUseCase(
      UpdateCartParameters(productId: productId, quantity: quantity),
    );
    result.fold(
      (l) => emit(state.copyWith(
        updateCartState: RequestState.error,
        updateCartErrorMessage: l.errorMessage,
      )),
      (r) {
        emit(
          state.copyWith(
            updateCart: r,
            updateCartState: RequestState.loaded,
          ),
        );
      },
    );
    getCart();
  }
}
