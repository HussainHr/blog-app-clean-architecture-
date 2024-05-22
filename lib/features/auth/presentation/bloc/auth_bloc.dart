// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/usecases/user_sign_up.dart';
// part 'auth_event.dart';
// part 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final UserSignUp _userSignUp;
//   AuthBloc({
//     required UserSignUp userSignUp,
//   })  : _userSignUp = userSignUp,
//         super(AuthInitial()) {
//     on<AuthSignUp>((event, emit) async {
//       final res = await _userSignUp(
//         UserSignUpParams(
//           email: event.email,
//           password: event.password,
//           name: event.name,
//         ),
//       );
//
//       res.fold(
//         (l) => emit(
//           AuthFailure(l.message),
//         ),
//         (r) => emit(
//           AuthSuccess(r),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/user_sign_up.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      // Validate email format
      if (!isValidEmail(event.email)) {
        emit(const AuthFailure('Invalid email format'));
        return;
      }

      final res = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      res.fold(
        (l) => emit(
          AuthFailure(l.message),
        ),
        (r) => emit(
          AuthSuccess(r),
        ),
      );
    });
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }
}
