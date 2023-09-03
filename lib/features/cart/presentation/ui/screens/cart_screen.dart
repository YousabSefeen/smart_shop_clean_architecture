import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_error_widget.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/common presentation/screens/empty_screen.dart';
import '../../../../../core/utils/app settings/controller/app_settings_cubit.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/common presentation/widgets/loading_widget.dart';
import '../../controller/cubit/cart_cubit.dart';
import '../../controller/states/cart_states.dart';
import '../widgets/cart_product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    TextTheme textContext = Theme.of(context).textTheme;
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.translate(context)),
      ),
      body: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.cartState) {
            case RequestState.loading:
              return const LoadingWidgets();
            case RequestState.loaded:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'total'.translate(context),
                              style: textContext.bodyLarge,
                              children: [
                                TextSpan(
                                  text:
                                      '${state.cart!.subTotal.toInt()} ${'eg'.translate(context)}',
                                  style: textContext.bodyMedium!.copyWith(
                                    fontSize: 15.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Text(
                          'checkOut'.translate(context),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      )
                    ],
                  ),
                  _customDivider(context, height, width),
                  state.cart!.cartItems!.isEmpty
                      ? EmptyScreen(
                          text: 'emptyCartDes'.translate(context),
                          icon: Icons.add_shopping_cart_outlined,
                        )
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.cart!.cartItems!.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              itemBuilder: (context, index) {
                                final int quantity =
                                    state.cart!.cartItems![index].quantity;

                                final int uniqueId =
                                    state.cart!.cartItems![index].id;
                                return CartProduct(
                                  cartItems: state.cart!.cartItems![index],
                                  quantity: quantity,
                                  uniqueId: uniqueId,
                                );
                              }),
                        ),
                ],
              );
            case RequestState.error:
              return Center(
                child: CustomErrorWidget(
                  errorMessage: state.cartErrorMessage,
                  errorCategoryName: 'cart'.translate(context),
                ),
              );
          }
        },
      ),
    );
  }

  Container _customDivider(BuildContext context, double height, double width) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerTheme.color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.2,
      ),
      height: 3.h,
      width: double.infinity,
    );
  }
}
