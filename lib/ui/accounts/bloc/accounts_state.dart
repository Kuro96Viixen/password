part of 'accounts_bloc.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState({
    required List<AccountData> accountsList,
    required bool arePrivateAccounts,
    required AccountsScreenState screenState,
    AccountsNavigationState? navigationState,
  }) = _AccountsState;

  factory AccountsState.initial() => const AccountsState(
        accountsList: [],
        arePrivateAccounts: false,
        screenState: AccountsScreenState.loading(),
        navigationState: null,
      );
}

@freezed
class AccountsScreenState with _$AccountsScreenState {
  const factory AccountsScreenState.loading() = _Loading;

  const factory AccountsScreenState.loaded({required String searchText}) =
      _Loaded;
}

@freezed
class AccountsNavigationState with _$AccountsNavigationState {
  const factory AccountsNavigationState.goToAccountView({
    required int accountIndex,
  }) = _GoToAccountView;

  const factory AccountsNavigationState.goToAdd() = _GoToAdd;

  const factory AccountsNavigationState.showBottomMenu() = _ShowBottomMenu;

  const factory AccountsNavigationState.showSnackBar({
    required String snackBarMessage,
  }) = _ShowSnackBar;
}
