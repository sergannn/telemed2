import 'package:doctorq/extensions.dart';
import 'package:flutter/material.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //const SizedBox(height: 40), // фиксированный отступ
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                //const Text(
                //'Поддержка',
                // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'О враче',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              // Text(context.selectedDoctor.toString()),

                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  '${context.selectedDoctor['username'] ?? 'Врач'}${context.selectedDoctor['description'] != null ? ', ${context.selectedDoctor['description']}' : ''}',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Образование',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  context.selectedDoctor['qualifications'] != null && context.selectedDoctor['qualifications'].isNotEmpty
                                      ? context.selectedDoctor['qualifications']
                                          .map<String>((qual) =>
                                              '${qual['degree'] ?? ''}${qual['university'] != null ? ', ${qual['university']}' : ''}${qual['year'] != null ? ' (${qual['year']})' : ''}')
                                          .where((text) => (text as String).isNotEmpty)
                                          .join('\n')
                                      : 'Информация об образовании отсутствует',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Специальность',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  context.selectedDoctor['specializations'] != null && context.selectedDoctor['specializations'].isNotEmpty
                                      ? context.selectedDoctor['specializations'].
                                          map((spec) => spec['name'] ?? '')
                                          .join(', ')
                                      : 'Специальности не указаны',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Профиль лечения',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Стаж работы',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  context.selectedDoctor['experience'] != null
                                      ? 'Стаж работы: ${context.selectedDoctor['experience']} ${_getExperienceYearsText(context.selectedDoctor['experience'])}'
                                      : 'Информация о стаже работы отсутствует',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Отзывы пациентов',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Row с иконкой и текстом
                              _buildReviewsSection(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Документы',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            // Здесь будет код для перехода к препаратам
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 159, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(
                            'Перейти к трекеру тестов',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewsSection(BuildContext context) {
    final reviews = context.selectedDoctor['reviews'] as List<dynamic>?;
    final hasReviews = reviews != null && reviews.isNotEmpty;
    
    if (!hasReviews) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star, color: Color(0xFFFFD700), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '0.0',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 17, 17, 17),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Отзывов пока нет',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 17, 17, 17),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Calculate average rating
    final averageRating = reviews!
        .map((review) => (review['rating'] as num?)?.toDouble() ?? 0.0)
        .reduce((a, b) => a + b) / reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Average rating
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.star, color: Color(0xFFFFD700), size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                averageRating.toStringAsFixed(1),
                style: TextStyle(
                  color: const Color.fromARGB(255, 17, 17, 17),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Мнение пациентов (${reviews.length})',
                style: TextStyle(
                  color: const Color.fromARGB(255, 17, 17, 17),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Display first review
        ...reviews.take(1).map((review) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stars
                ...List.generate(5, (index) => Icon(
                  Icons.star,
                  color: index < (review['rating'] as int? ?? 0) 
                      ? Color(0xFFFFD700) 
                      : Colors.grey[300],
                  size: 18,
                )),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatDate(review['created_at']),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 17, 17, 17),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Комментарии',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 17, 17, 17),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    review['review']?.toString() ?? 'Без комментария',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 17, 17, 17),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )).toList(),
      ],
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Дата не указана';
    
    try {
      final dateStr = date.toString();
      if (dateStr.length >= 10) {
        return '${dateStr.substring(8, 10)}.${dateStr.substring(5, 7)}.${dateStr.substring(0, 4)}';
      }
      return dateStr;
    } catch (e) {
      return date.toString();
    }
  }

  String _getExperienceYearsText(dynamic experience) {
    if (experience == null) return 'лет';
    
    final exp = experience is int ? experience : int.tryParse(experience.toString());
    if (exp == null) return 'лет';
    
    if (exp % 10 == 1 && exp % 100 != 11) return 'год';
    if (exp % 10 >= 2 && exp % 10 <= 4 && (exp % 100 < 10 || exp % 100 >= 20)) return 'года';
    return 'лет';
  }
}
