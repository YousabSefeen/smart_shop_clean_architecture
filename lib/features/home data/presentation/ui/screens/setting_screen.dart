import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';

import '../../../../../core/common presentation/widgets/custom_app_alerts.dart';
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ThemeChangeButton(),
              const LanguageChangeButton(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                child: const Divider(
                    thickness: 2.5, color: Colors.blueGrey, height: 30),
              ),
              customListTile(
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
              customListTile(
                context: context,
                leadingIcon: Icons.login,
                title: 'logout'.translate(context),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: theme.secondaryHeaderColor,
                  ),
                  onPressed: () {
                    return CustomAppAlerts.logoutAlert(
                      context: context,
                      onLogout: () => AuthCubit.object(context).logout(context),
                    );
                  },
                ),
              ),
            ],
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
