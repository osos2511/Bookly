import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';
part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());
  final HomeRepo homeRepo;

  Future<void>fetchFeaturedBooks()async{
    emit(FeaturedBooksLoading());
    var result=await homeRepo.fetchFeaturedBooks();
    result.fold((failure){
      emit(FeaturedBooksFailure(failure.errorMessage));
    }, (books){
      emit(FeaturedBooksSuccess(books));
    });

  }




}
