import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:doctorq/constant/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:doctorq/stores/user_store.dart';

class AkkEditScreen extends StatefulWidget {
  const AkkEditScreen({Key? key}) : super(key: key);

  @override
  State<AkkEditScreen> createState() => _AkkInfoScreenState();
}

class _AkkInfoScreenState extends State<AkkEditScreen> {
  bool isChecked = false;
  bool isLoading = false;
  
  // Controllers for editable fields
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late TextEditingController _emailController;
  late TextEditingController _snilsController;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with current user data
    final userData = context.userData;
    _firstNameController = TextEditingController(text: userData['first_name'] ?? '');
    _lastNameController = TextEditingController(text: userData['last_name'] ?? '');
    _phoneController = TextEditingController(text: userData['phone'] ?? '');
    _birthDateController = TextEditingController(text: userData['birth_date'] ?? '');
    _emailController = TextEditingController(text: userData['email'] ?? '');
    _snilsController = TextEditingController(text: userData['snils'] ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _snilsController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final mutation = '''
       mutation UpdateUserProfile(\$input: UpdateUserProfileInput!) {
            updateUserProfile(input: \$input) {
              user {
                id
                first_name
                last_name
                email
                contact
                dob
                snils
              }
              status
            }
          }
      ''';

      final variables = {
        'input': {
          'user_id': context.userData['user_id']?.toString() ?? '',
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
        //  'email': _emailController.text,
          'phone': _phoneController.text,
          'birth_date': _birthDateController.text,
          'snils': _snilsController.text,
        }
      };

      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );
      
      GraphQLClient graphqlClient = await graphqlAPI2.authClient();
      final QueryResult result = await graphqlClient.mutate(options);
      
      if (result.hasException) {
        throw result.exception!;
      }

      // Update local user data context
      final updatedData = Map<String, dynamic>.from(context.userData);
      updatedData.addAll(variables['input']!);
      
      // Update user data in store
      final userStore = GetIt.instance<UserStore>();
      userStore.setUserData(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Профиль успешно обновлен')),
      );

      Navigator.pop(context);
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при обновлении профиля: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text: "Редактирование профиля", context: context, icon: Icon(Icons.edit)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  // Profile header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: getVerticalSize(25),
                          backgroundImage: NetworkImage(context.userData['photo']),
                        ),
                        HorizontalSpace(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainProfileScreen()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: '${_firstNameController.text} ${_lastNameController.text}\n',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Редактирование профиля',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // First Name Field
                  _buildEditableField(
                    label: 'Имя',
                    controller: _firstNameController,
                    hintText: 'Введите ваше имя',
                  ),

                  // Last Name Field
                  _buildEditableField(
                    label: 'Фамилия',
                    controller: _lastNameController,
                    hintText: 'Введите вашу фамилию',
                  ),

                  // Phone Field
                  _buildEditableField(
                    label: 'Номер телефона',
                    controller: _phoneController,
                    hintText: 'Введите номер телефона',
                    keyboardType: TextInputType.phone,
                  ),

                  // Birth Date Field
                  _buildEditableField(
                    label: 'Дата рождения',
                    controller: _birthDateController,
                    hintText: 'ДД.ММ.ГГГГ',
                    keyboardType: TextInputType.datetime,
                  ),

                  // Email Field (readonly)
                  _buildEditableField(
                    label: 'Почта',
                    controller: _emailController,
                    hintText: 'Введите email',
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                  ),

                  // SNILS Field
                  _buildEditableField(
                    label: 'СНИЛС',
                    controller: _snilsController,
                    hintText: 'Введите номер СНИЛС',
                    keyboardType: TextInputType.text,
                  ),

                  // Privacy Agreement
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.transparent),
                            child: Checkbox(
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                              value: isChecked,
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 12,
                          height: 12,
                          child: const Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 8,
                          ),
                        ),
                        const Text(
                          'Согласен на обработку персональных данных',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Cancel Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            side: BorderSide(color: const Color.fromARGB(255, 96, 159, 222)),
                          ),
                          child: Text(
                            'Отменить',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ),
                      ),

                      // Save Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 96, 159, 222),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Сохранить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(height: getVerticalSize(100))
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 70, 70, 70),
              ),
            ),
          ),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F8FF),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: controller,
              keyboardType: keyboardType,
              readOnly: readOnly,
              enabled: !readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              style: TextStyle(
                fontSize: 14,
                color: readOnly ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
