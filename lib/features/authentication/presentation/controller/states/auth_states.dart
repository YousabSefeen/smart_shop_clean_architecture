import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/auth.dart';

class AuthStates extends Equatable {
  final Auth? login;
  final RequestState loginState;
  final String loginErrorMessage;
  final Auth? register;
  final RequestState registerState;
  final String registerErrorMessage;

  final Auth? profile;
  final RequestState profileState;
  final String profileErrorMessage;
  final Auth? updateProfile;
  final RequestState updateProfileState;
  final String updateProfileErrorMessage;

  const AuthStates({
    this.login,
    this.loginState = RequestState.loading,
    this.loginErrorMessage = '',
    this.register,
    this.registerState = RequestState.loading,
    this.registerErrorMessage = '',
    this.profile,
    this.profileState = RequestState.loading,
    this.profileErrorMessage = '',
    this.updateProfile,
    this.updateProfileState = RequestState.loading,
    this.updateProfileErrorMessage = '',
  });

  AuthStates copyWith({
    Auth? login,
    RequestState? loginState,
    String? loginErrorMessage,
    Auth? register,
    RequestState? registerState,
    String? registerErrorMessage,
    Auth? profile,
    RequestState? profileState,
    String? profileErrorMessage,
    Auth? updateProfile,
    RequestState? updateProfileState,
    String? updateProfileErrorMessage,
  }) {
    return AuthStates(
      login: login ?? this.login,
      loginState: loginState ?? this.loginState,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      register: register ?? this.register,
      registerState: registerState ?? this.registerState,
      registerErrorMessage: registerErrorMessage ?? this.registerErrorMessage,
      profile: profile ?? this.profile,
      profileState: profileState ?? this.profileState,
      profileErrorMessage: profileErrorMessage ?? this.profileErrorMessage,
      updateProfile: updateProfile ?? this.updateProfile,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      updateProfileErrorMessage:
          updateProfileErrorMessage ?? this.updateProfileErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        login,
        loginState,
        loginErrorMessage,
        register,
        registerState,
        registerErrorMessage,
        profile,
        profileState,
        profileErrorMessage,
        updateProfile,
        updateProfileState,
        updateProfileErrorMessage,
      ];
}
