import 'package:meta/meta.dart' show immutable, required;
import 'package:hive/hive.dart';

part 'login_form_hive.g.dart';

@immutable
@HiveType(typeId: 201)
class LoginFormHive {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final bool save;

  LoginFormHive({
    @required this.username,
    @required this.password,
    @required this.save,
  });

  static LoginFormHive clean() =>
      LoginFormHive(username: '', password: '', save: false);
}
