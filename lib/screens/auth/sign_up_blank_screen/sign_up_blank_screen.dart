import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/forgot/password_otp_active_screen/password_otp_active_screen.dart';
import 'package:doctorq/screens/auth/sign_up_blank_screen/password_dialog.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/services/city_catalog_service.dart';
import 'package:doctorq/services/fcm_service.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_checkbox.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:doctorq/widgets/loading_overlay.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

import 'fields.dart';

class SignUpBlankScreen extends StatefulWidget {
  const SignUpBlankScreen({super.key});

  @override
  State<SignUpBlankScreen> createState() => _SignUpBlankScreenState();
}

class _SignUpBlankScreenState extends State<SignUpBlankScreen> {
  bool checkbox = false;
  bool obscure = true;
  bool _showValidationErrors = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late final Future<List<CityOption>> _citiesFuture;
  CityOption? _selectedCity;

  @override
  void initState() {
    super.initState();
    _citiesFuture = CityCatalogService.loadCities().then((cities) {
      final cityController =
          RegFields.getAll()['city']['controller'] as TextEditingController;
      _selectedCity = CityCatalogService.findExactMatch(
        cities,
        cityController.text,
      );
      if (_selectedCity != null) {
        cityController.text = _selectedCity!.name;
      }
      return cities;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: size.width,
                    margin: getMargin(top: 36, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          "Регистрация",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(26),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ..._orderedFields().map((entry) {
                  final field = entry.value;

                  if (entry.key == "email") {
                    emailController = field['controller'];
                  }
                  if (entry.key == 'phone') {
                    phoneController = field['controller'];
                  }
                  if (entry.key == "password") {
                    passwordController = field['controller'];
                  }

                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        margin: getMargin(
                          left: 24,
                          top: 30,
                          right: 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(left: 24, right: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: getPadding(),
                                            child: Text(
                                              field['label'],
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : ColorConstant
                                                        .bluegray800A2,
                                                fontSize: getFontSize(16),
                                                fontFamily: 'Source Sans Pro',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          if (field['*'] != null)
                                            Padding(
                                              padding: getPadding(bottom: 5),
                                              child: Text(
                                                "*",
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.redA700A2,
                                                  fontSize: getFontSize(14),
                                                  fontFamily: 'Source Sans Pro',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    entry.key == 'city'
                                        ? _buildCityField(field, isDark)
                                        : CustomTextFormField(
                                            controller: field['controller'],
                                            isDark: _showValidationErrors &&
                                                    field['validator'] !=
                                                        null &&
                                                    field['validator'](
                                                            field['controller']
                                                                .text) !=
                                                        null
                                                ? true
                                                : false,
                                            width: size.width,
                                            hintText: field['hint'],
                                            margin: getMargin(top: 11),
                                            alignment: Alignment.centerLeft,
                                            isObscureText: field['obscure'],
                                            validator: field['validator'],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomCheckbox(
                    fontStyle: CheckboxFontStyle.ser,
                    alignment: Alignment.centerLeft,
                    text: "Согласен на обработку персональных данных",
                    iconSize: 10,
                    value: checkbox,
                    padding: getPadding(
                      left: 48,
                      top: 22,
                      right: 48,
                    ),
                    onChange: (value) {
                      checkbox = value;
                      setState(() {});
                    },
                  ),
                ),
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Продолжить",
                  margin: getMargin(
                    left: 24,
                    top: 22,
                    right: 24,
                  ),
                  onTap: () async {
                    MyOverlay.show(context);
                    setState(() {
                      _showValidationErrors = true;
                    });

                    if (!validateForm()) {
                      MyOverlay.hide();
                      return;
                    }

                    if (!checkbox) {
                      MyOverlay.hide();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Необходимо согласие на обработку персональных данных",
                          ),
                        ),
                      );
                      return;
                    }

                    MyOverlay.show(context);
                    final emailExists =
                        await checkEmailExists(emailController.text);
                    MyOverlay.hide();

                    if (!mounted) return;

                    if (emailExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Этот email уже зарегистрирован. Пожалуйста, используйте другой email или войдите в систему.",
                          ),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      return;
                    }

                    final password = await showDialog<String>(
                      context: context,
                      builder: (context) => PasswordDialog(
                        email: emailController.text,
                        phone: phoneController.text,
                        onPasswordEntered: (password) =>
                            Navigator.pop(context, password),
                      ),
                    );

                    if (password == null) return;

                    MyOverlay.show(context);
                    try {
                      final tokenSaved =
                          await FcmService().saveTokenForRegistration(
                        emailController.text,
                      );
                      if (!tokenSaved) {
                        MyOverlay.hide();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Не удалось подготовить push-уведомление. Проверьте разрешение на уведомления и попробуйте ещё раз.',
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      await RegFields.saveFields();

                      final regRes = await regUser(
                        context,
                        emailController.text,
                        password,
                        "patient",
                        RegFields.getAll()['full_name']['controller'].text,
                        RegFields.getAll()['snils']['controller'].text,
                        phone: RegFields.getAll()['phone']['controller'].text,
                        city: RegFields.getAll()['city']['controller'].text,
                        timeZone: _selectedCity?.timeZone,
                        birthDate:
                            RegFields.getAll()['birthday']['controller'].text,
                      );

                      if (!mounted) return;

                      if (regRes) {
                        await sendRegistrationPushCode(emailController.text);
                        MyOverlay.hide();
                        showDialog(
                          barrierColor: Colors.black.withValues(alpha: 0.5),
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 600),
                                () {
                              Navigator.of(context).pop(true);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordOtpActiveScreen(
                                    response: {
                                      'email': emailController.text,
                                    },
                                    password: password,
                                  ),
                                ),
                              );
                            });
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              elevation: 0.0,
                              child: Center(
                                child: Container(
                                  width: getHorizontalSize(124),
                                  height: getVerticalSize(124),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isDark
                                        ? ColorConstant.darkBg
                                        : ColorConstant.whiteA700,
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ColorConstant.blueA400,
                                      backgroundColor:
                                          ColorConstant.blueA400.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        MyOverlay.hide();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Ошибка регистрации. Пожалуйста, попробуйте снова.",
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      MyOverlay.hide();
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString().replaceFirst('Exception: ', ''),
                          ),
                        ),
                      );
                    }
                  },
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    var isValid = true;
    var lastError = '';

    for (final entry in RegFields.getAll().entries) {
      final field = entry.value;
      final controller = field['controller'] as TextEditingController;
      final validator = field['validator'];

      if (validator != null) {
        final error = validator(controller.text);
        if (error != null) {
          isValid = false;
          lastError = error;
        }
      }
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lastError)),
      );
    }
    if (isValid && _selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Выберите город из списка")),
      );
      return false;
    }
    return isValid;
  }

  List<MapEntry<String, dynamic>> _orderedFields() {
    final entries = RegFields.getAll().entries.toList();
    const order = <String, int>{
      'city': 0,
      'full_name': 1,
      'phone': 2,
      'birthday': 3,
      'email': 4,
      'snils': 5,
    };

    entries.sort((a, b) {
      final aOrder = order[a.key] ?? 100;
      final bOrder = order[b.key] ?? 100;
      if (aOrder != bOrder) {
        return aOrder.compareTo(bOrder);
      }
      return 0;
    });
    return entries;
  }

  Widget _buildCityField(Map<String, dynamic> field, bool isDark) {
    final controller = field['controller'] as TextEditingController;
    final hasError = _showValidationErrors &&
        ((field['validator'] != null &&
                field['validator'](controller.text) != null) ||
            _selectedCity == null);

    return FutureBuilder<List<CityOption>>(
      future: _citiesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomTextFormField(
            controller: controller,
            isDark: hasError,
            width: size.width,
            hintText: field['hint'],
            margin: getMargin(top: 11),
            alignment: Alignment.centerLeft,
            isObscureText: field['obscure'],
            validator: field['validator'],
          );
        }

        final cities = snapshot.data!;
        return Container(
          margin: getMargin(top: 11),
          child: TextFormField(
            controller: controller,
            readOnly: true,
            onTap: () async {
              final selected = await _showCityPicker(cities, isDark);
              if (selected != null) {
                setState(() {
                  _selectedCity = selected;
                  controller.text = selected.name;
                });
              }
            },
            style: TextStyle(
              fontSize: getFontSize(16),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: field['hint'] ?? "",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: getFontSize(16),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getHorizontalSize(24)),
                borderSide: BorderSide(
                  color: hasError
                      ? ColorConstant.redA400
                      : ColorConstant.bluegray50,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getHorizontalSize(24)),
                borderSide: BorderSide(
                  color: hasError
                      ? ColorConstant.redA400
                      : ColorConstant.bluegray50,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getHorizontalSize(24)),
                borderSide: BorderSide(
                  color: ColorConstant.blueA400,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: hasError
                  ? ColorConstant.fromHex("FFEDED")
                  : ColorConstant.whiteA700,
              isDense: true,
              contentPadding: getPadding(
                left: 15,
                top: 16,
                right: 15,
                bottom: 15,
              ),
              suffixIcon:
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 24),
            ),
          ),
        );
      },
    );
  }

  Future<CityOption?> _showCityPicker(
    List<CityOption> cities,
    bool isDark,
  ) async {
    final searchController =
        TextEditingController(text: _selectedCity?.name ?? '');
    List<CityOption> filtered = searchController.text.trim().isEmpty
        ? cities.take(20).toList()
        : cities
            .where(
              (city) => CityCatalogService.matches(
                  city, searchController.text.trim()),
            )
            .take(30)
            .toList();

    return showModalBottomSheet<CityOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.72,
                decoration: BoxDecoration(
                  color: isDark ? ColorConstant.darkBg : Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 5,
                      margin: const EdgeInsets.only(top: 12, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        onChanged: (value) {
                          setSheetState(() {
                            final query = value.trim();
                            filtered = (query.isEmpty
                                    ? cities.take(20)
                                    : cities
                                        .where(
                                          (city) => CityCatalogService.matches(
                                            city,
                                            query,
                                          ),
                                        )
                                        .take(30))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Начните вводить город',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searchController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    setSheetState(() {
                                      filtered = cities.take(20).toList();
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: ColorConstant.bluegray50),
                        itemBuilder: (context, index) {
                          final option = filtered[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            title: Text(
                              option.displayLabel,
                              style: TextStyle(
                                fontSize: getFontSize(16),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: option.subtitle == null
                                ? Text(option.timeZone)
                                : Text(
                                    '${option.subtitle} · ${option.timeZone}',
                                  ),
                            onTap: () => Navigator.of(context).pop(option),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
