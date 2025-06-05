import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<EventPage> {
  @override
  bool get wantKeepAlive => true;
  DateTime? selectedDate;
  late TabController _tabController;
  String frequencyValue = 'Однократно';
  String timeZoneValue = 'GMT+3:00';
  String dateValue = 'чт, 26 февраля 2025 15:30';
  String _getMonthName(int month) {
    final months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return months[month - 1];
  }

  String _currentTitle = 'Название события';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      print('Текущий индекс: ${_tabController.index}');
      print('Текущий заголовок: $_currentTitle');
      if (mounted) {
        // Добавьте проверку mounted
        setState(() {
          switch (_tabController.index) {
            case 0: // Приемы
              _currentTitle = 'Название события';
              break;
            case 1: // Лекарства
              _currentTitle = 'Название лекарства';
              break;
            case 2: // Упражнения
              _currentTitle = 'Название упражнения';
              break;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...topBack(
              text: "Событие",
              context: context,
              back: true,
              icon: Icon(Icons.favorite),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: _buildTabBar()),
                  _buildTabContent(
                      _tabController, MediaQuery.of(context).size.height),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(120),
          bottomLeft: Radius.circular(120),
        ),
        color: ColorConstant.fromHex("E4F0FF"),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: EdgeInsets.symmetric(vertical: 10),
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(120),
          color: Colors.white,
        ),
        unselectedLabelColor: ColorConstant.blueA400,
        unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.w600,
          fontFamily: 'SourceSansPro',
        ),
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.w600,
          fontFamily: 'SourceSansPro',
        ),
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Приемы'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Лекарства'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Упражнения'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(TabController _tabController, double height) {
    return SizedBox(
      height: height,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildReceiptContent(), // Пересоздаем каждый раз
          _buildMedicinesContent(), // Пересоздаем каждый раз
          _buildExercisesContent(), // Обсуждение с врачами (пока пусто)
        ],
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          this.selectedDate = selectedDate;
          dateValue =
              '${selectedDate.weekday == 4 ? 'чт' : ''}, ${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  Widget _buildReceiptContent() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          _currentTitle,
          style: TextStyle(
            fontSize: getFontSize(16),
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
          ),
          key: ValueKey(_currentTitle),
        ),
        SizedBox(height: 8),
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color(0xFFEDF5FF),
            borderRadius: BorderRadius.circular(90),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Название',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дата/время',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: _showDatePicker,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Контейнер для переключателя
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Повтор',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            frequencyValue = frequencyValue == 'Однократно'
                                ? 'Ежедневно'
                                : 'Однократно';
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                frequencyValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Новый блок для часового пояса
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Часовой пояс',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          void _showTimezoneDialog() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Выберите часовой пояс'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 24, // GMT-12 до GMT+12
                                      itemBuilder: (context, index) {
                                        String offset = (index - 12)
                                            .toString()
                                            .padLeft(2, '0');
                                        return ListTile(
                                          title: Text('GMT$offset:00'),
                                          onTap: () {
                                            setState(() {
                                              timeZoneValue = 'GMT$offset:00';
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          // Здесь будет логика выбора часового пояса
                          print('Выбор часового пояса');
                          setState(() {
                            onTap:
                            _showTimezoneDialog;
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$timeZoneValue Москва',
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMedicinesContent() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          _currentTitle,
          style: TextStyle(
            fontSize: getFontSize(16),
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
          ),
          key: ValueKey(_currentTitle),
        ),
        SizedBox(height: 8),
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color(0xFFEDF5FF),
            borderRadius: BorderRadius.circular(90),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Название',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дата/время',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: _showDatePicker,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Контейнер для переключателя
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Повтор',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            frequencyValue = frequencyValue == 'Однократно'
                                ? 'Ежедневно'
                                : 'Однократно';
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                frequencyValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Новый блок для часового пояса
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Часовой пояс',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          void _showTimezoneDialog() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Выберите часовой пояс'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 24, // GMT-12 до GMT+12
                                      itemBuilder: (context, index) {
                                        String offset = (index - 12)
                                            .toString()
                                            .padLeft(2, '0');
                                        return ListTile(
                                          title: Text('GMT$offset:00'),
                                          onTap: () {
                                            setState(() {
                                              timeZoneValue = 'GMT$offset:00';
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          // Здесь будет логика выбора часового пояса
                          print('Выбор часового пояса');
                          setState(() {
                            onTap:
                            _showTimezoneDialog;
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$timeZoneValue Москва',
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildExercisesContent() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          _currentTitle,
          style: TextStyle(
            fontSize: getFontSize(16),
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
          ),
          key: ValueKey(_currentTitle),
        ),
        SizedBox(height: 8),
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color(0xFFEDF5FF),
            borderRadius: BorderRadius.circular(90),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Название',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дата/время',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: _showDatePicker,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Контейнер для переключателя
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Повтор',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            frequencyValue = frequencyValue == 'Однократно'
                                ? 'Ежедневно'
                                : 'Однократно';
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                frequencyValue,
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Новый блок для часового пояса
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Часовой пояс',
                    style: TextStyle(
                      fontSize: getFontSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: InkWell(
                        onTap: () {
                          void _showTimezoneDialog() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Выберите часовой пояс'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 24, // GMT-12 до GMT+12
                                      itemBuilder: (context, index) {
                                        String offset = (index - 12)
                                            .toString()
                                            .padLeft(2, '0');
                                        return ListTile(
                                          title: Text('GMT$offset:00'),
                                          onTap: () {
                                            setState(() {
                                              timeZoneValue = 'GMT$offset:00';
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          // Здесь будет логика выбора часового пояса
                          print('Выбор часового пояса');
                          setState(() {
                            onTap:
                            _showTimezoneDialog;
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$timeZoneValue Москва',
                                style: TextStyle(
                                  fontSize: getFontSize(12),
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  String _getSectionTitle(int index) {
    if (index == 0) {
      return _currentTitle;
    }
    return '';
  }
}
