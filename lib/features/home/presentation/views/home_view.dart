import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/features/home/presentation/view_models/featured_books/featured_books_cubit.dart';
import 'package:bookly/features/home/presentation/view_models/newest_books/newest_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            HomeRepoImpl(
              ApiService(
                Dio(),
              ),
            ),
          )..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            HomeRepoImpl(
              ApiService(
                Dio(),
              ),
            ),
          )..fetchNewestBooks(),
        ),
      ],
      child: const SafeArea(
        child: Scaffold(
          body: HomeViewBody(),
        ),
      ),
    );
  }
}
