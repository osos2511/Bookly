import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<Items>>> fetchSearchBooks({required String bookName});
}
