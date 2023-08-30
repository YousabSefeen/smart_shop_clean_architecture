import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../../global widgets/loading_widget.dart';
import '../../controller/cubit/search_products_cubit.dart';
import '../../controller/states/search_products_states.dart';
import '../widgets/custom_search_field.dart';
import '../widgets/search_product_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _globalKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final searchCubit = SearchProductsCubit.object(context);
    return BlocConsumer<SearchProductsCubit, SearchProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('search'.translate(context)),
          ),
          body: SafeArea(
            child: Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    CustomSearchField(
                      onPressedSuffixIcon: () {
                        _controller.clear();
                        searchCubit.searchProducts.clear();
                        setState(() {});
                      },
                      onFieldSubmitted: (valueSearch) {
                        if (valueSearch == '') {
                          customSnackBar(
                            context: context,
                            message: 'Please enter the value to search for',
                          );
                        } else {
                          searchCubit.getSearchProducts(
                              nameProduct: valueSearch.trim());
                          FocusScope.of(context).unfocus();
                        }
                      },
                      controller: _controller,
                    ),
                    BlocConsumer<SearchProductsCubit, SearchProductsStates>(
                        listener: (context, state) {
                          if (state.searchProductsState == RequestState.error) {
                            return customDialog(
                              context: context,
                              message: state.searchProductsErrorMessage,
                            );
                          }
                        },
                        buildWhen: (previous, current) =>
                            previous.searchProductsState !=
                            current.searchProductsState,
                        builder: (context, state) {
                          switch (state.searchProductsState) {
                            case RequestState.loading:
                              return const LoadingWidgets();
                            case RequestState.loaded:
                              return GridView.builder(
                                shrinkWrap: true,

                                /// It is very important that someone else can get me an error
                                physics: const NeverScrollableScrollPhysics(),

                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.05,
                                ),

                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200.w,
                                  childAspectRatio: 3.w / 4.h,
                                  crossAxisSpacing: 15.w,
                                  mainAxisSpacing: 10.h,
                                ),
                                itemCount: searchCubit.searchProducts.length,
                                itemBuilder: (context, index) =>
                                    SearchProductWidget(
                                  product: searchCubit.searchProducts[index],
                                  index: index,
                                  columnCount:
                                      searchCubit.searchProducts.length,
                                ),
                              );
                            case RequestState.error:
                              return const SizedBox();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
