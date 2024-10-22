import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/repository/repository.dart';

class SetAccountsDataUseCase {
  final Repository _repository;

  SetAccountsDataUseCase(this._repository);

  Future<void> call(AccountsData accountsData) async {
    return _repository.setAccountsData(accountsData);
  }
}
