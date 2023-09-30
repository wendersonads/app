import 'dart:convert';

import 'package:auth_migration/core/auth/token_service.dart';
import 'package:auth_migration/domain/model/dto/login_dto.dart';
import 'package:auth_migration/domain/model/token_model.dart';
import 'package:auth_migration/base/service/base_service.dart';
import 'package:auth_migration/base/custom/custom_http.dart';
import 'package:http/http.dart';

class LoginService {
  TokenService tokenService = TokenService();

  final BaseService _abstractService = BaseService('');

  Future<bool> tryLogin(String username, String password) async {
    LoginDTO login = LoginDTO(username: username, password: password);
    Response response = await CustomHttp.post(
        await _abstractService.getUrl('login'),
        headers: login.toMap(),
        body: login.toJson(),
        secure: false);
        if (response.statusCode == 200) {
           tokenService.save(response.body);
           return true;
        }else{
          return false;
        }
  }
}
