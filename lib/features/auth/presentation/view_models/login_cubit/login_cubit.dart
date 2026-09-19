import 'package:bookly/features/auth/data/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(LoginFailure(failure.errorMessage)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(PasswordResetLoading());

    final result = await authRepo.sendPasswordResetEmail(email: email);

    result.fold(
      (failure) => emit(LoginFailure(failure.errorMessage)),
      (_) => emit(PasswordResetSent(email.trim())),
    );
  }
}
