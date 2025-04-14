import 'package:bookly/features/home/data/models/book_model/BookResponse.dart';
import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class HomeRepo{
  Future<Either<Failure,List<Items>>>fetchNewestBooks();
  Future<Either<Failure,List<BookResponse>>>fetchFeaturedBooks();
}