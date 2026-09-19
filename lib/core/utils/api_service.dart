import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';

  final String _apiKey = 'AIzaSyDbmJbDLNGe4QPsLuXRW-V0hi96y5NR_ZI';

  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final String url = endPoint.contains('?')
        ? '$_baseUrl$endPoint&key=$_apiKey'
        : '$_baseUrl$endPoint?key=$_apiKey';

    var response = await dio.get(url);
    return response.data;
  }
}