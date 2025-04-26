import 'dart:ui';
import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/widgets/custom_button.dart';

class AudioResolution extends StatefulWidget {
  const AudioResolution({Key? key}) : super(key: key);

  @override
  State<AudioResolution> createState() => _AudioResolutionState();
}

class _AudioResolutionState extends State<AudioResolution> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCancelDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аудио запись с врачом'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showBottomSheet();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок над чатом
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 4, right: 24),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 247, 247)
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: const AssetImage('assets/images/11.png'),
                          ),
                          const SizedBox(width: 12),
                          // Информация о враче
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Парфенов К.С.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Акушер-гинеколог',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '10:00 - 10:45',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 47, 47, 47),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      // Контейнер с текстом над изображением
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Аудио запись (45 мин)',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Контейнер с изображением
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: Image.asset(
                            'assets/images/Audio.png',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Контейнер с временем
                      Container(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  margin: const EdgeInsets.only(top: 16),
  child: Center(
    child: const Text(
      '10:18 мин',
      style: TextStyle(
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    ),
  ),
),
                      const SizedBox(height: 20),

                       // Контейнер с кнопками
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 34),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                backgroundColor: const Color.fromARGB(255, 125, 171, 223),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                // Добавьте здесь логику для кнопки "Начать"
                              },
                              child: const Text(
                                "Начать",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 34),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                backgroundColor: const Color.fromARGB(255, 125, 171, 223),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                // Добавьте здесь логику для кнопки "Пауза"
                              },
                              child: const Text(
                                "Пауза",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 34),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                backgroundColor: const Color.fromARGB(255, 125, 171, 223),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                // Добавьте здесь логику для кнопки "Остановить"
                              },
                              child: const Text(
                                "Остановить",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                ]
              ),
            ),]))))
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Стрелка для свайпа вниз
            Container(
              height: 4,
              width: 40,
              margin: EdgeInsets.only(top: 18, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Круглые элементы (без Expanded и с меньшим padding)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircleItem(Icons.share_outlined, 'Поделиться'),
                  GestureDetector(
                   onTap: () { 
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return AppointmentsBookScreen();
                  } ));}, 
                  child:
                  _buildCircleItem(Icons.date_range, 'Записаться')),
                         GestureDetector(
                        child:
                            _buildCircleItem(Icons.delete_outline, 'Удалить'),
                        onTap: () {
                        showDeleteDialog(context);
//                          showCancelDialog(context);
                        })
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

  Widget _buildCircleItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFE4F0FF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: Colors.black),
        ),
        SizedBox(height: 14),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ],
    );
  }
}



void showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dcontext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Удалить чат со всеми данными безвозвратно?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14),
                Text(
                  'Пропадут все данные этого чата. Восстановить не получится.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  text: "Удалить",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () async {
                    print("continuing");
                    Navigator.pop(dcontext);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  width: double.infinity,
                  text: "Отставить",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.of(dcontext).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


void showCancelDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dcontext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Чтобы получить данную запись чата с врачом, необходимо отправить заявку',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14),
                Text(
                  'Cрок рассмотрения заявки 24 часа',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  text: "Отмена",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () async {
                    print("continuing");
                    Navigator.pop(dcontext);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  width: double.infinity,
                  text: "Отправить",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.of(dcontext).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDark;
  final double width;
  final String text;
  final EdgeInsetsGeometry? margin;
  final ButtonVariant variant;
  final ButtonFontStyle fontStyle;
  final Alignment alignment;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.isDark = false,
    required this.width,
    required this.text,
    this.margin,
    required this.variant,
    required this.fontStyle,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isDark
              ? const Color.fromARGB(255, 125, 171, 223)
              : const Color.fromARGB(255, 125, 171, 223),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
