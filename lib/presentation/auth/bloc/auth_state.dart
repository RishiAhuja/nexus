import 'package:blog/domain/entities/auth/user_entity.dart';

sealed class AuthState {
  AuthState();
  factory AuthState.fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'AuthInitial':
        return AuthInitial();
      case 'AuthLoading':
        return AuthInitial(); // If restarts at AuthLoading, should not show AuthLoading after restart.
      case 'AuthError':
        return AuthError(errorMessage: map['errorMessage']);
      case 'AuthSuccess':
        return AuthSuccess(userEntity: UserEntity.fromMap(map['userEntity']));
      default:
        return AuthInitial();
    }
  }
  Map<String, dynamic> toMap();
}

class AuthInitial extends AuthState {
  @override
  Map<String, dynamic> toMap() {
    return {'type': 'AuthInitial'};
  }
}

class AuthLoading extends AuthState {
  @override
  Map<String, dynamic> toMap() {
    return {'type': 'AuthLoading'};
  }
}

class AuthSuccess extends AuthState {
  final UserEntity userEntity;
  AuthSuccess({required this.userEntity});

  @override
  Map<String, dynamic> toMap() {
    return {'type': 'AuthSuccess', 'userEntity': userEntity.toMap()};
  }
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError({required this.errorMessage});

  @override
  Map<String, dynamic> toMap() {
    return {'type': 'AuthError', 'errorMessage': errorMessage};
  }
}
