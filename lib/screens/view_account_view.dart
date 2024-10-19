import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/widgets.dart';

class ViewAccountViewArguments {
  int index;
  Account account;

  ViewAccountViewArguments(
    this.index,
    this.account,
  );
}

class ViewAccountView extends StatefulWidget {
  final ViewAccountViewArguments arguments;

  const ViewAccountView(
    this.arguments, {
    super.key,
  });

  @override
  State<ViewAccountView> createState() => _ViewAccountViewState();
}

class _ViewAccountViewState extends State<ViewAccountView> {
  bool revealedPassword = false;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => setState(
        () => revealedPassword = false,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: CustomWidgets.backButton(
              context,
            ),
            title: Text(
              Texts.viewAccountViewTitle,
            ),
            actions: [
              IconButton(
                onPressed: () async =>
                    await Utils.deleteAccount(widget.arguments.account).then(
                  (_) => Navigator.of(context).pop(),
                ),
                icon: Icon(
                  CommonIcons.delete,
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgets.viewAccountLabel(
                  Texts.viewAccountNameLabel,
                ),
                CustomWidgets.viewAccountField(
                  widget.arguments.account.name,
                ),
                CustomWidgets.viewAccountLabel(
                  Texts.viewAccountUsernameLabel,
                ),
                CustomWidgets.viewAccountField(
                  widget.arguments.account.username,
                ),
                CustomWidgets.viewAccountLabel(
                  Texts.viewAccountPasswordLabel,
                ),
                GestureDetector(
                  onLongPress: () {
                    if (revealedPassword) {
                      Clipboard.setData(
                        ClipboardData(
                          text: Encryption.decryptPassword(
                            widget.arguments.account.password,
                          ),
                        ),
                      ).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          Utils.snackbarBuilder(
                            Texts.copiedToClipboard,
                          ),
                        ),
                      );
                    }
                  },
                  child: CustomWidgets.viewAccountField(
                    revealedPassword
                        ? Encryption.decryptPassword(
                            widget.arguments.account.password,
                          )
                        : Texts.hiddenPasswordText,
                  ),
                ),
                CustomWidgets.spacer(),
                Visibility(
                  visible: !revealedPassword,
                  child: CustomWidgets.button(
                    Texts.viewAccountViewPassword,
                    () => Utils.authenticate(
                      Texts.fingerprintPasswordAuthTitle,
                    ).then(
                      (verified) => (verified)
                          ? setState(
                              () => revealedPassword = true,
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Utils.navigateToEdit(
              context,
              widget.arguments.index,
              widget.arguments.account,
            ),
            tooltip: Texts.viewAccountViewEditTooltip,
            child: Icon(
              CommonIcons.edit,
            ),
          ),
        ),
      ),
    );
  }
}
