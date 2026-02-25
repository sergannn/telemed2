import 'package:flutter/material.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';

class PasswordDialog extends StatefulWidget {
  final String email;
  final String phone;
  final Function(String) onPasswordEntered;

  const PasswordDialog({
    Key? key,
    required this.email,
    required this.phone,
    required this.onPasswordEntered,
  }) : super(key: key);

  @override
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Придумайте пароль',
              style: TextStyle(
                fontSize: getFontSize(20),
                fontWeight: FontWeight.w600,
              ),
            ),
            VerticalSpace(height: 16),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: getFontSize(14)),
            ),
            if (widget.phone.isNotEmpty) ...[
              VerticalSpace(height: 8),
              Text(
                'Телефон: ${widget.phone}',
                style: TextStyle(fontSize: getFontSize(14)),
              ),
            ],
            VerticalSpace(height: 16),
            TextFormField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            VerticalSpace(height: 16),
            TextFormField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: 'Подтвердите пароль',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                    });
                  },
                ),
              ),
            ),
            if (_errorText != null) ...[
              VerticalSpace(height: 8),
              Text(
                _errorText!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: getFontSize(12),
                ),
              ),
            ],
            VerticalSpace(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isDark: isDark,
                    text: 'Отмена',
                    variant: ButtonVariant.OutlineGray100,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                HorizontalSpace(width: 16),
                Expanded(
                  child: CustomButton(
                    isDark: isDark,
                    text: 'Продолжить',
                    onTap: _validateAndSubmit,
                    variant: ButtonVariant.FillBlueA400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    if (_passwordController.text.isEmpty || 
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorText = 'Пожалуйста, введите пароль';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorText = 'Пароли не совпадают';
      });
      return;
    }

    if (_passwordController.text.length < 6) {
      setState(() {
        _errorText = 'Пароль должен быть не менее 6 символов';
      });
      return;
    }

    widget.onPasswordEntered(_passwordController.text);
    //Navigator.pop(context);
  }
}