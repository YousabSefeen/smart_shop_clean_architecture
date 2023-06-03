import 'package:equatable/equatable.dart';

import 'data.dart';

class Auth extends Equatable {
  final bool status;
  final String? message;
  final Data? data;

  const Auth({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
