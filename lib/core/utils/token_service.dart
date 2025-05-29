import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../config/routes/app_router.dart';
import '../../get_it/get_it.dart';
import '../repository/token_repository.dart';
import 'logger.dart';
import '../entities/unauthorised_exception.dart';

const String _h = 'token_service';

@lazySingleton
class TokenService {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  TokenService(this._dio, this._tokenRepository);

  Future<String> getToken() async {
    final String? accessToken = await _tokenRepository.getAccessToken();
    print("here is the access tokem ${accessToken}");
    if (accessToken == null) {
      getIt<AppRouter>().navigate(const LoginRoute());
      Fluttertoast.showToast(msg: 'Session expired. Please login again');
      throw UnauthorisedException();
    } else if (JwtDecoder.isExpired(accessToken)) {
      logFatal(_h, null, 'Access token is expired');
      getIt<AppRouter>().navigate(const LoginRoute());
      Fluttertoast.showToast(msg: 'Session expired. Please login again');
      throw UnauthorisedException();
    } else {
      logDebugFine(_h, accessToken);
      return accessToken;
    }
  }
}
