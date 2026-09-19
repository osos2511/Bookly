import 'package:bookly/core/errors/failure.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/models/book_model/BookResponse.dart';
import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/search/data/repos/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiService apiService;

  SearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<Items>>> fetchSearchBooks({required String bookName}) async {
    try {
      var data = await apiService.get(
          endPoint: 'volumes?Filtering=free-ebooks&q=$bookName');
      var bookResponse = BookResponse.fromJson(data);
      return Right(bookResponse.items ?? []);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
