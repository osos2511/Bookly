import 'package:bookly/features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:bookly/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        AuthRepoImpl(FirebaseAuth.instance),
      ),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
