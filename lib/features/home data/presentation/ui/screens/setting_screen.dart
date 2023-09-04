import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';

import '../../../../../core/utils/app settings/components/language_change_button.dart';
import '../../../../../core/utils/app settings/components/theme_change_button.dart';
import '../../../../authentication/presentation/controller/cubit/auth_cubit.dart';
import '../../../../authentication/presentation/ui/screens/profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.translate(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.17,
                  child: customListTile(
                    context: context,
                    leadingIcon: Icons.person,
                    title: 'account'.translate(context),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.secondaryHeaderColor,
                      ),
                      onPressed: () => AppRouters.go(
                          context: context, route: ProfileScreen.route),
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  child: const LanguageChangeButton(),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  child: const ThemeChangeButton(),
                ),
                SizedBox(height: constraints.maxHeight * 0.2),
                ElevatedButton(
                  onPressed: () => AuthCubit.object(context).logout(context),
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    'logout'.translate(context),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile customListTile({
    required IconData leadingIcon,
    required String title,
    required BuildContext context,
    Widget? trailing,
  }) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.sizeOf(context).height;
    return ListTile(
      contentPadding: EdgeInsets.only(top: height * 0.05),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: theme.secondaryHeaderColor,
        child: Icon(leadingIcon, color: theme.scaffoldBackgroundColor),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
            ),
      ),
      trailing: trailing,
    );
  }
}
