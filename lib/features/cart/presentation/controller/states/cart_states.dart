import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/cart.dart';
import '../../../domain/entities/change_cart.dart';
import '../../../domain/entities/update_cart.dart';

class CartStates extends Equatable {
  final Cart? cart;
  final RequestState cartRequestState;
  final String cartErrorMessage;

  // ******
  final ChangeCart? changeCart;
  final RequestState changeCartState;

  final String changeCartErrorMessage;

  // ****

  final UpdateCart? updateCart;
  final RequestState updateCartState;

  final String updateCartErrorMessage;

  //***
  const CartStates({
    this.cart,
    this.cartRequestState = RequestState.loading,
    this.cartErrorMessage = '',
    this.changeCart,
    this.changeCartState = RequestState.loading,
    this.changeCartErrorMessage = '',
    this.updateCart,
    this.updateCartState = RequestState.loading,
    this.updateCartErrorMessage = '',
  });

  CartStates copyWith({
    Cart? cart,
    RequestState? cartRequestState,
    String? cartErrorMessage,
    ChangeCart? changeCart,
    RequestState? changeCartState,
    String? changeCartErrorMessage,
    UpdateCart? updateCart,
    RequestState? updateCartState,
    String? updateCartErrorMessage,
  }) {
    return CartStates(
      cart: cart ?? this.cart,
      cartRequestState: cartRequestState ?? this.cartRequestState,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
      changeCart: changeCart ?? this.changeCart,
      changeCartState: changeCartState ?? this.changeCartState,
      changeCartErrorMessage:
          changeCartErrorMessage ?? this.changeCartErrorMessage,
      updateCart: updateCart ?? this.updateCart,
      updateCartState: updateCartState ?? this.updateCartState,
      updateCartErrorMessage:
          updateCartErrorMessage ?? this.updateCartErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        cart,
        cartRequestState,
        cartErrorMessage,
        changeCart,
        changeCartState,
        changeCartErrorMessage,
        updateCart,
        updateCartState,
        updateCartErrorMessage,
      ];
}
