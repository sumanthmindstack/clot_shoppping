abstract class TokenRepository {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String accessToken);

  Future<String?> getRefreshToken();

  Future<void> setRefreshToken(String refreshToken);

  Future<void> clearTokens();
}
