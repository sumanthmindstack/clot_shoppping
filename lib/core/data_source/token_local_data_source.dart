import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/meta_strings.dart';

abstract class TokenLocalDataSource {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String accessToken);

  Future<String?> getRefreshToken();

  Future<void> setRefreshToken(String refreshToken);

  Future<void> clearTokens();
}

@LazySingleton(as: TokenLocalDataSource)
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  @override
  Future<void> clearTokens() async {
    final tokenBox = await Hive.openBox(HiveBoxStrings.tokenBox);
    tokenBox.clear();
  }

  @override
  Future<String?> getAccessToken() async {
    final tokenBox = await Hive.openBox(HiveBoxStrings.tokenBox);
    return tokenBox.get(HiveBoxStrings.accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    final tokenBox = await Hive.openBox(HiveBoxStrings.tokenBox);
    return tokenBox.get(HiveBoxStrings.refreshToken);
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    print("inside token local ${accessToken}");
    final tokenBox = await Hive.openBox(HiveBoxStrings.tokenBox);
    tokenBox.put(HiveBoxStrings.accessToken, accessToken);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    final tokenBox = await Hive.openBox(HiveBoxStrings.tokenBox);
    tokenBox.put(HiveBoxStrings.refreshToken, refreshToken);
  }
}
