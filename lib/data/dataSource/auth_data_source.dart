import 'package:dio/dio.dart';

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
    final response = await httpClient.post('v1/mobapp-login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {"mobile": "09901876797", "password": "Aref1380@"});

    validateResponse(response);

    return AuthInfoEntity(name: response.data['data']['first_name'], accessTocken: "Hi");
  }
}
