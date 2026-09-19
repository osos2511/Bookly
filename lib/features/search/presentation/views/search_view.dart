import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/search/data/repos/search_repo_impl.dart';
import 'package:bookly/features/search/presentation/view_models/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBooksCubit(
        SearchRepoImpl(
          ApiService(
            Dio(),
          ),
        ),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
