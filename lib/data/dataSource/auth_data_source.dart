import 'package:dio/dio.dart';

import '../../common/exception.dart';
import '../../common/http_response_validator.dart';
import '../model/AuthInfo.dart';

abstract class IAuthDataSource {
  Future<AuthInfoEntity> login(String mobile, String password);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfoEntity> login(String mobile, String password) async {
    try {
      final response = await httpClient.post('v1/mobapp-login',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {"mobile": mobile, "password": password});
      
        validateResponse(response);
      
      return AuthInfoEntity(
          name: response.data['data']['first_name'],
          accessTocken: response.data['data']['token']);
    } on DioException catch (e) { // catch 422 invalid username or password and throw custom exception
      if (e.response?.statusCode == 422) {
        String message = e.response!.data['message'];
        throw AppException(message: message);
      }
    }
    return AuthInfoEntity(name: "", accessTocken: "");
  }
}
