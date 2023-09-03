import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/common presentation/widgets/loading_widget.dart';
import '../../controller/cubit/auth_cubit.dart';
import '../../controller/states/auth_states.dart';
import '../widgets/custom_profile_field.dart';

class ProfileScreen extends StatefulWidget {
  static const route = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    AuthCubit authCubit = AuthCubit.object(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.translate(context)),
      ),
      body: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          switch (state.profileState) {
            case RequestState.loading:
              return const LoadingWidgets();
            case RequestState.loaded:
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.1),
                        CustomProfileField(
                          keyValue: 'name',
                          title: 'name'.translate(context),
                          controller: authCubit.nameController,
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name user can\'t be blank';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomProfileField(
                          keyValue: 'email',
                          title: 'emailAddress'.translate(context),
                          controller: authCubit.emailController,
                          prefixIcon: Icons.email,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be blank';
                            } else if (!value.contains('@')) {
                              return 'The email format is incorrect';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomProfileField(
                          keyValue: 'phone',
                          title: 'phoneNumber'.translate(context),
                          controller: authCubit.phoneController,
                          prefixIcon: Icons.phone_android_outlined,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be blank';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: _isUpdating
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () => _updateData(context),
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  child: Text(
                                    'updateData'.translate(context),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                  ),
                ),
              );
            case RequestState.error:
              return Center(
                child: CustomErrorWidget(
                  errorMessage: state.profileErrorMessage,
                  errorCategoryName: 'profile'.translate(context),
                ),
              );
          }
        },
      ),
    );
  }

  _updateData(BuildContext context) async {
    AuthCubit authCubit = AuthCubit.object(context);
    setState(() => _isUpdating = true);
    if (_formKey.currentState!.validate()) {
      await authCubit.updateProfileData(
        context: context,
        name: authCubit.nameController.text,
        email: authCubit.emailController.text,
        phone: authCubit.phoneController.text,
      );
    }
    setState(() => _isUpdating = false);
  }
}
