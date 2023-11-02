import 'package:dio/dio.dart';
import 'package:reqres/networks/dio/dio_client.dart';
import 'package:reqres/networks/dio/endpoints.dart';
import 'package:reqres/networks/models/user_model.dart';
import 'package:reqres/networks/models/user_token_error.dart';

class AuthRepo {
  final DioClient dioClient = DioClient(Dio());
  Future<UserTokenError?> loginRequest(UserModel userModel) async {
    try {
      final response = await dioClient.mainReqRes(
        endPoints: EndPoints.login,
        data: userModel.toJson(),
      );
      print(response);
      if (response.statusCode == 200) {
        final loginResponse = UserTokenError.fromJson(response.data);
        if (loginResponse.token != null) {
          return loginResponse;
        } else {
          return null;
        }
      } else {
        final loginResponse = UserTokenError.fromJson(response.data);
        if (response.statusCode == 400) {
          return loginResponse;
        }
      }
    } on DioException catch (e) {
      if (e.response!.data != null) {
        final loginErrorResponse = UserTokenError.fromJson(e.response!.data);
        return loginErrorResponse;
      }
    }
    return null;
  }
}
