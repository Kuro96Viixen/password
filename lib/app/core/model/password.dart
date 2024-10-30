import 'package:freezed_annotation/freezed_annotation.dart';

part 'password.freezed.dart';

@freezed
class Password with _$Password {
  const factory Password({
    required String password,
    required String iv,
  }) = _Password;
}
