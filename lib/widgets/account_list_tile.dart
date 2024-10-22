import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/ui/accounts/bloc/accounts_bloc.dart';

class AccountListTile extends StatelessWidget {
  final int index;
  final AccountData account;

  const AccountListTile({
    super.key,
    required this.index,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      onTap: () => context.read<AccountsBloc>().add(
            AccountsEvent.viewAccount(index),
          ),
      leading: Icon(
        CommonIcons.account,
      ),
      title: Text(
        account.name,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      trailing: Icon(
        CommonIcons.next,
      ),
    );
  }
}
