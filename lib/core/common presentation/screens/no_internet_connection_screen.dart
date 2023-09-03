import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../features/categories/presentation/controller/cubit/categories_cubit.dart';
import '../../../features/home data/presentation/controller/cubit/home_cubit.dart';
import '../../../features/home data/presentation/ui/screens/bottom_nav_screen.dart';
import '../../utils/app settings/controller/app_settings_cubit.dart';
import '../../utils/app settings/controller/app_settings_states.dart';
import '../../utils/app_routers.dart';
import '../widgets/custom_app_alerts.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  static const route = 'NoInternetConnectionScreen';

  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppSettingsCubit, AppSettingsState>(
      listener: (context, state) {
        CustomAppAlerts.customDialog(
          context: context,
          message: 'connected'.translate(context),
        );
        AppRouters.goAndRemoveUntil(
          context: context,
          route: BottomNavigationScreen.route,
        );

        _reloadData(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.15),
                Container(
                  height: constraints.maxHeight * 0.50,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/no_internet.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                SizedBox(
                  height: constraints.maxHeight * 0.15,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'No connection\n',
                        style: TextStyle(
                            fontSize: 23.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            height: 1.5),
                        children: [
                          TextSpan(
                            text: 'please check your internet\n connectivity',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ]),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _reloadData(BuildContext context) {
    HomeCubit.object(context)
      ..getProducts()
      ..getBanners();
    CategoriesCubit.object(context).getCategories();
  }
}
