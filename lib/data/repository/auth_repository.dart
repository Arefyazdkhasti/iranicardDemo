import 'package:flutter/material.dart';
import 'package:iranicard_demo/data/model/AuthInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/http_client.dart';
import '../dataSource/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<AuthInfoEntity> login(String mobile, String password);
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfoEntity?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<AuthInfoEntity> login(String mobile, String password) async {
    final AuthInfoEntity authInfo = await dataSource.login(mobile, password);
    _persistAuthTocken(authInfo);

    return authInfo;
  }

  // why cant we set it to Futue<Void>?
  Future<String> _persistAuthTocken(AuthInfoEntity authInfoEntity) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_tocken", authInfoEntity.accessTocken);
    return "";
  }

  Future<String> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("access_tocken") ?? '';
    if (accessToken.isNotEmpty) {
      authChangeNotifier.value =
          AuthInfoEntity(name: "", accessTocken: accessToken);
    }
    return accessToken;
  }

  Future<void> logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
