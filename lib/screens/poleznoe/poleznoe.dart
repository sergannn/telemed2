import 'dart:math' as math;
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Классы для хранения состояний
class BloodTypeSelection {
  String selectedValue;
  BloodTypeSelection({this.selectedValue = ''});
}

class RhFactorSelection {
  String selectedValue;
  RhFactorSelection({this.selectedValue = ''});
}

class DisabilityStatus {
  String selectedValue;
  DisabilityStatus({this.selectedValue = ''});
}

class PhysicalLimitations {
  String selectedValue;
  PhysicalLimitations({this.selectedValue = ''});
}

class MedicalHistorySelection {
  List<String> selectedDiseases;
  String selectedTraumas;
  String selectedOperations;
  String selectedMedications;
  String selectedCycleLength; // Длина цикла
  String selectedCycleVariation; // Отличия длины циклов
  String selectedFlowIntensity; // Обильность выделений
  String selectedPainLevel; // Ощущение боли
  String selectedBirthType; // Тип родов
  String selectedAbortionType; // Тип абортов
  String selectedPregnancyComplications; // Сложности беременности

  MedicalHistorySelection({
    this.selectedDiseases = const [],
    this.selectedTraumas = '',
    this.selectedOperations = '',
    this.selectedMedications = '',
    this.selectedCycleLength = '',
    this.selectedCycleVariation = '',
    this.selectedFlowIntensity = '',
    this.selectedPainLevel = '',
    this.selectedBirthType = '',
    this.selectedAbortionType = '',
    this.selectedPregnancyComplications = '',
  });
}

// Класс для хранения параметров тела
class BodyParameters {
  String weight;
  String height;
  String circumference;

  BodyParameters({this.weight = '', this.height = '', this.circumference = ''});
}

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SurveyState();
}

class SurveyState extends State<SurveyScreen> {
  List<bool> _expansionStates = List<bool>.filled(8, false);

  // Расширенные состояния для каждого типа данных
  Map<int, BloodTypeSelection> bloodTypes = {};
  Map<int, RhFactorSelection> rhFactors = {};
  Map<int, DisabilityStatus> disabilities = {};
  Map<int, PhysicalLimitations> physicalLimitations = {};
  Map<int, BodyParameters> bodyParams = {};
  Map<int, MedicalHistorySelection> medicalHistories = {};

  @override
  void initState() {
    super.initState();
    _loadSavedValues().then((_) {
      setState(() {}); // Дополнительное обновление UI
    });
    // Инициализируем пустые значения
    for (int i = 0; i < 8; i++) {
      bloodTypes[i] = BloodTypeSelection();
      rhFactors[i] = RhFactorSelection();
      disabilities[i] = DisabilityStatus();
      physicalLimitations[i] = PhysicalLimitations();
      bodyParams[i] = BodyParameters();
      medicalHistories[i] =
          MedicalHistorySelection(); // Добавляем для всех индексов
    }
  }

  // Метод для загрузки сохраненных значений
  Future<void> _loadSavedValues() async {
    final prefs = await SharedPreferences.getInstance();

    // Загружаем значения группы крови
    bloodTypes[0]?.selectedValue = prefs.getString('bloodType_0') ?? '';

    // Загружаем значение резус-фактора
    rhFactors[0]?.selectedValue = prefs.getString('rhFactor_0') ?? '';

    // Загружаем значение инвалидности
    disabilities[0]?.selectedValue = prefs.getString('disability_0') ?? '';

    // Загружаем значение физических ограничений
    physicalLimitations[0]?.selectedValue = prefs.getString('physical_0') ?? '';

    // Загружаем значения параметров тела
    bodyParams[1]?.weight = prefs.getString('weight_1') ?? '';
    bodyParams[1]?.height = prefs.getString('height_1') ?? '';
    bodyParams[1]?.circumference = prefs.getString('circumference_1') ?? '';

// Загружаем список заболеваний
    List<String>? savedDiseases = prefs.getStringList('medical_disease_2');
    medicalHistories[2]?.selectedDiseases = savedDiseases ?? [];

    // Загружаем остальные значения
    medicalHistories[2]?.selectedTraumas =
        prefs.getString('medical_trauma_2') ?? '';
    medicalHistories[2]?.selectedOperations =
        prefs.getString('medical_operation_2') ?? '';
    medicalHistories[2]?.selectedMedications =
        prefs.getString('medical_medication_2') ?? '';

    medicalHistories[6]?.selectedCycleLength =
        prefs.getString('cycle_length_6') ?? '';
    medicalHistories[6]?.selectedCycleVariation =
        prefs.getString('cycle_variation_6') ?? '';
    medicalHistories[6]?.selectedFlowIntensity =
        prefs.getString('flow_intensity_6') ?? '';
    medicalHistories[6]?.selectedPainLevel =
        prefs.getString('pain_level_6') ?? '';

    medicalHistories[7]?.selectedBirthType =
        prefs.getString('birth_type_7') ?? '';
    medicalHistories[7]?.selectedAbortionType =
        prefs.getString('abortion_type_7') ?? '';
    medicalHistories[7]?.selectedPregnancyComplications =
        prefs.getString('pregnancy_complications_7') ?? '';

    for (int i = 0; i < 8; i++) {
      List<String>? savedDiseases = prefs.getStringList('chronic_diseases_$i');
      medicalHistories[i]?.selectedDiseases = savedDiseases ?? [];
      medicalHistories[i]?.selectedCycleLength =
          prefs.getString('cycle_length_$i') ?? '';
      medicalHistories[i]?.selectedCycleVariation =
          prefs.getString('cycle_variation_$i') ?? '';
      medicalHistories[i]?.selectedFlowIntensity =
          prefs.getString('flow_intensity_$i') ?? '';
      medicalHistories[i]?.selectedPainLevel =
          prefs.getString('pain_level_$i') ?? '';
    }

    // Обновляем UI после загрузки всех значений
    setState(() {
        _expansionStates[1] = false;
      //  _expansionStates[1] = true;
    });
  }

  // Метод для сохранения всех значений
  Future<void> _saveAllValues() async {
    final prefs = await SharedPreferences.getInstance();

    // Сохраняем значение группы крови
    await prefs.setString('bloodType_0', bloodTypes[0]?.selectedValue ?? '');

    // Сохраняем значение резус-фактора
    await prefs.setString('rhFactor_0', rhFactors[0]?.selectedValue ?? '');

    // Сохраняем значение инвалидности
    await prefs.setString('disability_0', disabilities[0]?.selectedValue ?? '');

    // Сохраняем значение физических ограничений
    await prefs.setString(
        'physical_0', physicalLimitations[0]?.selectedValue ?? '');

    // Сохраняем значения параметров тела
    await prefs.setString('weight_1', bodyParams[1]?.weight ?? '');
    await prefs.setString('height_1', bodyParams[1]?.height ?? '');
    await prefs.setString(
        'circumference_1', bodyParams[1]?.circumference ?? '');
// Сохраняем список заболеваний
    await prefs.setStringList(
        'medical_disease_2', medicalHistories[2]?.selectedDiseases ?? []);

    // Сохраняем остальные значения
    await prefs.setString(
        'medical_trauma_2', medicalHistories[2]?.selectedTraumas ?? '');
    await prefs.setString(
        'medical_operation_2', medicalHistories[2]?.selectedOperations ?? '');
    await prefs.setString(
        'medical_medication_2', medicalHistories[2]?.selectedMedications ?? '');

    await prefs.setString(
        'cycle_length_6', medicalHistories[6]?.selectedCycleLength ?? '');
    await prefs.setString(
        'cycle_variation_6', medicalHistories[6]?.selectedCycleVariation ?? '');
    await prefs.setString(
        'flow_intensity_6', medicalHistories[6]?.selectedFlowIntensity ?? '');
    await prefs.setString(
        'pain_level_6', medicalHistories[6]?.selectedPainLevel ?? '');

    await prefs.setString(
        'birth_type_7', medicalHistories[7]?.selectedBirthType ?? '');
    await prefs.setString(
        'abortion_type_7', medicalHistories[7]?.selectedAbortionType ?? '');
    await prefs.setString('pregnancy_complications_7',
        medicalHistories[7]?.selectedPregnancyComplications ?? '');

    for (int i = 0; i < 8; i++) {
      if (medicalHistories[i]?.selectedDiseases?.isNotEmpty ?? false) {
        await prefs.setStringList(
            'chronic_diseases_$i', medicalHistories[i]?.selectedDiseases ?? []);
        await prefs.setString(
            'cycle_length_$i', medicalHistories[i]?.selectedCycleLength ?? '');
        await prefs.setString('cycle_variation_$i',
            medicalHistories[i]?.selectedCycleVariation ?? '');
        await prefs.setString('flow_intensity_$i',
            medicalHistories[i]?.selectedFlowIntensity ?? '');
        await prefs.setString(
            'pain_level_$i', medicalHistories[i]?.selectedPainLevel ?? '');
      }
    }
  }

  Widget _buildBloodTypeButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['I', 'II', 'III', 'IV', 'Не знаю'].map((value) => GestureDetector(
              onTap: () => setState(() {
                bloodTypes[index]?.selectedValue = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: bloodTypes[index]?.selectedValue == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: bloodTypes[index]?.selectedValue == value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildRhFactorButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['Положительный', 'Отрицательный', 'Не знаю']
            .map((value) => GestureDetector(
                  onTap: () => setState(() {
                    rhFactors[index]?.selectedValue = value;
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: rhFactors[index]?.selectedValue == value
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                      border: Border.all(
                        color: rhFactors[index]?.selectedValue == value
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(value),
                  ),
                )),
      ],
    );
  }

  Widget _buildDisabilityButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['1 группа', '2 группа', '3 группа', 'нет']
            .map((value) => GestureDetector(
                  onTap: () => setState(() {
                    disabilities[index]?.selectedValue = value;
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: disabilities[index]?.selectedValue == value
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                      border: Border.all(
                        color: disabilities[index]?.selectedValue == value
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(value),
                  ),
                )),
      ],
    );
  }

  Widget _buildPhysicalLimitationsButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['Да', 'Нет'].map((value) => GestureDetector(
              onTap: () => setState(() {
                physicalLimitations[index]?.selectedValue = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: physicalLimitations[index]?.selectedValue == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: physicalLimitations[index]?.selectedValue == value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildBodyParameters(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller:
              TextEditingController(text: bodyParams[index]?.weight ?? ''),
          decoration: InputDecoration(
            hintText: 'Вес',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: (value) => setState(() {
            bodyParams[index]?.weight = value;
          }),
        ),
        SizedBox(height: 12),
        TextField(
          controller:
              TextEditingController(text: bodyParams[index]?.height ?? ''),
          decoration: InputDecoration(
            hintText: 'Рост',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: (value) => setState(() {
            bodyParams[index]?.height = value;
          }),
        ),
        SizedBox(height: 12),
        TextField(
          controller: TextEditingController(
              text: bodyParams[index]?.circumference ?? ''),
          decoration: InputDecoration(
            hintText: 'Окружность',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: (value) => setState(() {
            bodyParams[index]?.circumference = value;
          }),
        ),
        SizedBox(height: 28),
      ],
    );
  }

// В методе _buildDiseasesButtons
  Widget _buildDiseasesButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          'Ветрянка',
          'Краснуха',
          'Корь',
          'Инсульт',
          'Инфаркт',
          'Онкология',
          'Менингит',
          'Панкреатит',
          'Ревматизм'
        ].map((value) => InkWell(
              onTap: () => setState(() {
                List<String> currentDiseases =
                    medicalHistories[index]?.selectedDiseases ?? [];
                if (currentDiseases.contains(value)) {
                  currentDiseases.remove(value);
                } else {
                  currentDiseases.add(value);
                }
                medicalHistories[index]?.selectedDiseases = currentDiseases;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]
                              ?.selectedDiseases
                              .contains(value) ??
                          false
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: medicalHistories[index]
                                ?.selectedDiseases
                                .contains(value) ??
                            false
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildMedicalHistoryButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['Да', 'Нет'].map((value) => GestureDetector(
              onTap: () => setState(() {
                switch (index) {
                  case 0: // травмы
                    medicalHistories[2]?.selectedTraumas = value;
                    break;
                  case 1: // операции
                    medicalHistories[2]?.selectedOperations = value;
                    break;
                  case 2: // лекарства
                    medicalHistories[2]?.selectedMedications = value;
                    break;
                }
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: index == 0 &&
                              medicalHistories[2]?.selectedTraumas == value ||
                          index == 1 &&
                              medicalHistories[2]?.selectedOperations ==
                                  value ||
                          index == 2 &&
                              medicalHistories[2]?.selectedMedications == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: index == 0 &&
                                medicalHistories[2]?.selectedTraumas == value ||
                            index == 1 &&
                                medicalHistories[2]?.selectedOperations ==
                                    value ||
                            index == 2 &&
                                medicalHistories[2]?.selectedMedications ==
                                    value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  void _showDiseaseDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите заболевание'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...[
                  'Ветрянка',
                  'Краснуха',
                  'Корь',
                  'Инсульт',
                  'Инфаркт',
                  'Онкология',
                  'Менингит',
                  'Острый миокардит',
                  'Панкреатит',
                  'Ревматизм',
                  'Тромбоз',
                  'Туберкулез',
                  'Другое'
                ]
                    .map((disease) => ListTile(
                          title: Text(disease),
                          onTap: () => setState(() {
                            List<String> currentDiseases =
                                medicalHistories[index]?.selectedDiseases ?? [];
                            if (!currentDiseases.contains(disease)) {
                              currentDiseases.add(disease);
                            }
                            medicalHistories[index]?.selectedDiseases =
                                currentDiseases;
                            Navigator.pop(context);
                          }),
                        ))
                    .toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCycleLengthButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          '24 дня',
          '24-38 дня',
          'Более 38 дней',
          'месячных нет'
        ].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedCycleLength = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]?.selectedCycleLength == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: medicalHistories[index]?.selectedCycleLength == value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildCycleVariationButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          'Нет',
          '1-9 дней',
          'Более 9 дней',
          'Не знаю'
        ].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedCycleVariation = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      medicalHistories[index]?.selectedCycleVariation == value
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  border: Border.all(
                    color:
                        medicalHistories[index]?.selectedCycleVariation == value
                            ? Colors.blue
                            : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildFlowIntensityButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['Скудные', 'Умеренные', 'Обильные'].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedFlowIntensity = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]?.selectedFlowIntensity == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color:
                        medicalHistories[index]?.selectedFlowIntensity == value
                            ? Colors.blue
                            : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildPainLevelButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          'Нет',
          'Почти не ощущаю',
          'Средняя',
          'Сильная'
        ].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedPainLevel = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]?.selectedPainLevel == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: medicalHistories[index]?.selectedPainLevel == value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildBirthTypeButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          'Своевременные',
          'Преждевременные',
          'Не было'
        ].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedBirthType = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]?.selectedBirthType == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: medicalHistories[index]?.selectedBirthType == value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

// Добавьте новый метод для кнопок выбора типа абортов
  Widget _buildAbortionTypeButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...[
          'Да (один)',
          'Да (несколько)',
          'Не было'
        ].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedAbortionType = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: medicalHistories[index]?.selectedAbortionType == value
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color:
                        medicalHistories[index]?.selectedAbortionType == value
                            ? Colors.blue
                            : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

// Добавьте новый метод для кнопок выбора сложностей беременности
  Widget _buildPregnancyComplicationsButtons(int index) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...['Да', 'Нет'].map((value) => GestureDetector(
              onTap: () => setState(() {
                medicalHistories[index]?.selectedPregnancyComplications = value;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      medicalHistories[index]?.selectedPregnancyComplications ==
                              value
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  border: Border.all(
                    color: medicalHistories[index]
                                ?.selectedPregnancyComplications ==
                            value
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value),
              ),
            )),
      ],
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required String content,
    required int index,
  }) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _expansionStates[index] = expanded;
        });
      },
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      trailing: Transform.rotate(
        angle: _expansionStates[index] ? math.pi / 5 : 0,
        child: Icon(
          Icons.arrow_forward_ios,
          color: _expansionStates[index] ? Colors.black : Colors.grey,
          size: 22,
        ),
      ),
      title: Container(
        width: double.infinity,
       // padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.report,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: null,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        if (index == 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Группа крови',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildBloodTypeButtons(index),
              ),
              SizedBox(height: 8),
              ListTile(
                  title: Text(
                'Резус фактор',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildRhFactorButtons(index),
              ),
              SizedBox(height: 8),
              ListTile(
                  title: Text(
                'Инвалидность',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildDisabilityButtons(index),
              ),
              ListTile(
                  title: Text(
                'Физические ограничения',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildPhysicalLimitationsButtons(index),
              ),
              SizedBox(height: 28),
            ],
          )
        else if (index == 1) // Параметры тела
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildBodyParameters(index),
          )
        else if (index == 2) // История болезни
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Какие заболевания вы перенесли?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildDiseasesButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                    title: Text(
                  'Вы перенесли травмы?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildMedicalHistoryButtons(0),
                ),
                SizedBox(height: 8),
                ListTile(
                    title: Text(
                  'Вы перенесли операции?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildMedicalHistoryButtons(1),
                ),
                SizedBox(height: 8),
                ListTile(
                    title: Text(
                  'Вы принимаете лекарства на постоянной основе?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildMedicalHistoryButtons(2),
                ),
                SizedBox(height: 28),
              ],
            ),
          )
        else if (index == 3) // Хронические заболевания
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Кнопка "Добавить"
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() {
                      _showDiseaseDialog(context, index);
                    }),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            'Добавить',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Список выбранных заболеваний
                if (medicalHistories[index]?.selectedDiseases?.isNotEmpty ??
                    false)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...medicalHistories[index]
                              ?.selectedDiseases
                              ?.map((disease) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(disease),
                                        SizedBox(width: 4),
                                        InkWell(
                                          onTap: () => setState(() {
                                            medicalHistories[index]
                                                ?.selectedDiseases
                                                ?.remove(disease);
                                          }),
                                          child: Icon(Icons.close,
                                              color: Colors.blue, size: 16),
                                        ),
                                      ],
                                    ),
                                  )) ??
                          []
                    ],
                  ),
                SizedBox(height: 28),
              ],
            ),
          )
        else if (index == 4) // Наследственные заболевания
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Кнопка "Добавить"
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() {
                      _showDiseaseDialog(context, index);
                    }),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            'Добавить',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Список выбранных заболеваний
                if (medicalHistories[index]?.selectedDiseases?.isNotEmpty ??
                    false)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...medicalHistories[index]
                              ?.selectedDiseases
                              ?.map((disease) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(disease),
                                        SizedBox(width: 4),
                                        InkWell(
                                          onTap: () => setState(() {
                                            medicalHistories[index]
                                                ?.selectedDiseases
                                                ?.remove(disease);
                                          }),
                                          child: Icon(Icons.close,
                                              color: Colors.blue, size: 16),
                                        ),
                                      ],
                                    ),
                                  )) ??
                          []
                    ],
                  ),
                SizedBox(height: 28),
              ],
            ),
          )
        else if (index == 5) // Аллергические реакции
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Кнопка "Добавить"
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() {
                      _showDiseaseDialog(context, index);
                    }),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            'Добавить',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Список выбранных заболеваний
                if (medicalHistories[index]?.selectedDiseases?.isNotEmpty ??
                    false)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...medicalHistories[index]
                              ?.selectedDiseases
                              ?.map((disease) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(disease),
                                        SizedBox(width: 4),
                                        InkWell(
                                          onTap: () => setState(() {
                                            medicalHistories[index]
                                                ?.selectedDiseases
                                                ?.remove(disease);
                                          }),
                                          child: Icon(Icons.close,
                                              color: Colors.blue, size: 16),
                                        ),
                                      ],
                                    ),
                                  )) ??
                          []
                    ],
                  ),
                SizedBox(height: 28),
              ],
            ),
          )
        else if (index == 6) // Менструальный цикл
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Длина цикла',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCycleLengthButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Есть ли отличия длины циклов?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCycleVariationButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Обильность выделений',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildFlowIntensityButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Ощущение боли',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPainLevelButtons(index),
                ),
                SizedBox(height: 28),
              ],
            ),
          )
        else if (index == 7) // Беременность и контрацепция
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Роды',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildBirthTypeButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Аборты',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildAbortionTypeButtons(index),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Сложности во время беременности',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPregnancyComplicationsButtons(index),
                ),
                SizedBox(height: 28),
              ],
            ),
          )
        else
          ListTile(title: Text(content ?? ''))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("height:"+ MediaQuery.of(context).size.height.toString());
    return 
ListView(
  padding:EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.35),
    children:[
  Container(
                   
    child:         
             
                Column( 
                children: [
                  _buildExpansionTile(
                    title: 'Общая информация',
                    content: '',
                    index: 0,
                  ),
                 
                  _buildExpansionTile(
                    title: 'Параметры тела',
                    content: '',
                    index: 1,
                  ),
                
                  _buildExpansionTile(
                    title: 'История болезни',
                    content: '',
                    index: 2,
                  ),
                 
                  _buildExpansionTile(
                    title: 'Хронические заболевания',
                    content: '',
                    index: 3,
                  ),
         
                  _buildExpansionTile(
                    title: 'Наследственные заболевания',
                    content: '',
                    index: 4,
                  ),
                
                  _buildExpansionTile(
                    title: 'Аллергические реакции',
                    content: '',
                    index: 5,
                  ),
         
                  _buildExpansionTile(
                    title: 'Менструальный цикл',
                    content: '',
                    index: 6,
                  ),
          
                  _buildExpansionTile(
                    title: 'Беременность и контрацепция',
                    content: '',
                    index: 7,
                  ),
               //   SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _saveAllValues();
                       snackBar(context, message: 'Данные сохранены');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder:(context)=> MedCardScreen()));
                    
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 96, 159, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Сохранить',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20)
             
                ],
              ),
  )]);
  }
}
