import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reqres/constants/constants.dart';
import 'package:reqres/networks/dio/endpoints.dart';

class DioClient {
  DioClient(this._dio) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    );
  }
  Future<dynamic> mainReqRes({
    required EndPoints endPoints,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    try {
      switch (endPoints.type()) {
        case ReqType.GEt:
          response = await _dio.get(
            "$baseUrl/${endPoints.path()}",
            queryParameters: data,
          );
          break;
        case ReqType.POST:
          response = await _dio.post(
            "$baseUrl/${endPoints.path()}",
            data: data,
          );
          break;
        case ReqType.PUT:
          response = await _dio.get(
            "$baseUrl/${endPoints.path()}",
            data: data,
          );
          break;
      }
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response!;
      } else {
        switch (e.type) {
          case DioExceptionType.receiveTimeout:
            response = Response(
              requestOptions: e.requestOptions,
              statusMessage: "Received time out",
              statusCode: 700,
            );
            break;

          default:
            response = Response(
              requestOptions: e.requestOptions,
              statusMessage: "Some error happened",
              statusCode: 800,
            );
        }
      }
    }
  }

  final Dio _dio;
}

enum ReqType {
  GEt,
  POST,
  PUT,
}
