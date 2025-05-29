import 'package:injectable/injectable.dart';

import '../data_source/token_local_data_source.dart';
import 'token_repository.dart';

@LazySingleton(as: TokenRepository)
class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource _tokenLocalDataSource;

  TokenRepositoryImpl(this._tokenLocalDataSource);

  @override
  Future<void> clearTokens() async => await _tokenLocalDataSource.clearTokens();

  @override
  Future<String?> getAccessToken() async =>
      await _tokenLocalDataSource.getAccessToken();

  @override
  Future<String?> getRefreshToken() async =>
      await _tokenLocalDataSource.getRefreshToken();

  @override
  Future<void> setAccessToken(String accessToken) async =>
      await _tokenLocalDataSource.setAccessToken(accessToken);

  @override
  Future<void> setRefreshToken(String refreshToken) async =>
      await _tokenLocalDataSource.setRefreshToken(refreshToken);
}
