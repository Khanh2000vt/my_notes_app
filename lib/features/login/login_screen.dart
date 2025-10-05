import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_notes_app/routing/router.dart';
import 'package:my_notes_app/services/login.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _onLogin() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      final username = formData?['username'];
      final password = formData?['password'];

      final idUser = await LoginService().checkUserOtp(username, password);

      if (idUser != null) {
        await setUserId(idUser);
        authToken.value = idUser.toString();
      } else {
        if (context.mounted) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Lỗi'),
              content: const Text('Tài khoản hoặc mật khẩu không đúng.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Đăng nhập')),
      child: SafeArea(
        child: Center(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                CupertinoFormSection.insetGrouped(
                  children: [
                    FormBuilderField<String>(
                      name: 'username',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      builder: (field) {
                        return CupertinoTextFormFieldRow(
                          placeholder: 'Tài khoản',
                          onChanged: (value) => field.didChange(value),
                        );
                      },
                    ),
                    FormBuilderField<String>(
                      name: 'password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      builder: (field) {
                        return CupertinoTextFormFieldRow(
                          placeholder: 'Mật khẩu',
                          obscureText: true,
                          onChanged: (value) => field.didChange(value),
                        );
                      },
                    ),
                  ],
                ),
                CupertinoButton.filled(
                  onPressed: _onLogin,
                  child: const Text('Đăng nhập'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
