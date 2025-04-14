import 'package:bookly/core/errors/failure.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/models/book_model/BookResponse.dart';
import 'package:bookly/features/home/data/models/book_model/Items.dart';
import 'package:bookly/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo{
  final ApiService apiService;
  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<Items>>> fetchNewestBooks() async{
    try{
     var data=await apiService.get(endPoint: 'volumes?q=subject:Programming&Filtering=free-ebooks&Sorting=newest');

      var books= BookResponse.fromJson(data);
      return Right(books.items??[]);
    }
      catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookResponse>>> fetchFeaturedBooks() {
    // TODO: implement fetchFeaturedBooks
    throw UnimplementedError();
  }

}