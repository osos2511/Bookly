import 'package:bookly/core/utils/styles_manager.dart';
import 'package:bookly/features/search/presentation/view_models/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          CustomSearchTextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                BlocProvider.of<SearchBooksCubit>(context)
                    .fetchSearchBooks(bookName: value);
              }
            },
          ),
          SizedBox(height: 24.h),
          Text(
            'Search Result',
            style: StylesManager.textStyle18,
          ),
          SizedBox(height: 16.h),
          const Expanded(child: SearchResultListView()),
        ],
      ),
    );
  }
}
