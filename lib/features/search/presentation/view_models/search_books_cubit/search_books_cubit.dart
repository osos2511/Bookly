import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/search/data/repos/search_repo.dart';
import 'package:equatable/equatable.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.searchRepo) : super(SearchBooksInitial());

  final SearchRepo searchRepo;

  Future<void> fetchSearchBooks({required String bookName}) async {
    emit(SearchBooksLoading());
    var result = await searchRepo.fetchSearchBooks(bookName: bookName);
    result.fold((failure) {
      emit(SearchBooksFailure(failure.errorMessage));
    }, (books) {
      emit(SearchBooksSuccess(books));
    });
  }
}
