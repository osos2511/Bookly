import 'package:bookly/core/utils/styles_manager.dart';
import 'package:bookly/features/search/presentation/view_models/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomSearchTextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                BlocProvider.of<SearchBooksCubit>(context)
                    .fetchSearchBooks(bookName: value);
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Search Result',
            style: StylesManager.textStyle18,
          ),
          const SizedBox(
            height: 16,
          ),
          const Expanded(child: SearchResultListView())
        ],
      ),
    );
  }
}


