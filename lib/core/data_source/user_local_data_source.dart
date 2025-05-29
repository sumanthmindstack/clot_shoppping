import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_local.dart';

abstract class UserLocalDataSource {
  Future<UserLocal?> getUserData();

  Future<void> storeUserData(UserLocal user);

  Future<void> logout();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> storeUserData(UserLocal user) async {
    var box = Hive.box<UserLocal>('userBox');
    await box.put('user', user);
  }

  @override
  Future<UserLocal?> getUserData() async {
    var box = Hive.box<UserLocal>('userBox');
    return box.get('user');
  }

  @override
  Future<void> logout() async {
    var box = Hive.box<UserLocal>('userBox');
    await box.clear();
  }
}
