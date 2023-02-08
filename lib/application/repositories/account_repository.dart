import 'package:flutter_clean_architecture/domain/core/result.dart';

abstract class AccountRepository {
  Future<Result<bool>>? loginAccount(String userName, String password);
}
