import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/doctors_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DoctorItem extends StatelessWidget {
  int index;

  Map<String, dynamic> item;
  DoctorItem({Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context) //, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) {
          context.setSelectedDoctorByIndex(index);

          return AppointmentsBookScreen();
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // выравнивание всех чилдренов внутри коламн по левому краю
                  children: [
                    SizedBox(height: 10),
                    Text(
                      item['specializations'].length == 0
                          ? ''
                          : item['specializations'][0][
                              'name'], // добавлен SizedBox с отступом 16 пикселей

                      style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Зеленый контейнер
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 247, 247, 247).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            item['photo'],
/*                        AssetImage(
                            'assets/images/11.png'),*/ // Используем AssetImage вместо Image.asset
                          )),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['username'],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              item['specializations'].length == 0
                                  ? ''
                                  : item['specializations'][0][
                                      'name'], // добавлен SizedBox с отступом 16 пикселей
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 176, 214, 254),
                            ),
                            constraints: const BoxConstraints(
                                minWidth: 10, minHeight: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //увеличить рамку
                                const Text('Анкета',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 16, 16, 16),
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), //
                  //Container(width: double.infinity, child: Frame2()),
                  /* Container(
                      width: double.infinity, // Полная ширина
                      height: getVerticalSize(40), // Высота изображения
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12), // Закругленные углы

                        //                           AssetImage('assets/images/doctor_item_bottom.svg'),
                      ),
                      child: SvgPicture.string(
                          height: 40,
                          fit: BoxFit.contain,
                          SvgConstant.under_doctor)),*/
                ],
              ),
            )
          ],
        ),
      ), /*Container(
        width: getHorizontalSize(160),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  getHorizontalSize(
                    12.00,
                  ),
                ),
                topRight: Radius.circular(
                  getHorizontalSize(
                    12.00,
                  ),
                ),
              ),
              child: //Image.network(item['photo'],
                  // width: getHorizontalSize(160), fit: BoxFit.contain),
                  CommonImageView(
                url: item['photo'],
                //imagePath: 'assets/images/empty.png',
//                        this.item['profile_image'], //doctorList[index].img,
                height: getSize(
                  160.00,
                ),
                width: getHorizontalSize(160),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: getPadding(
                left: 8,
                top: 12,
                right: 8,
              ),
              child: Text(
                item['username'],
//                    doctorList[index].name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getFontSize(
                    16,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 8,
                top: 11,
                right: 8,
                bottom: 14,
              ),
              child: Text(
                item['specializations'].length == 0
                    ? ''
                    : item['specializations'][0]['name'],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getFontSize(
                    14,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}

class Frame2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStatItem(
          label: 'Рейтинг',
          value: '4.3',
          width: 36.06,
          iconSize: 11.73,
        ),
        const SizedBox(width: 8),
        _buildStatItem(
          label: 'Стаж',
          value: '14',
          width: 31.59,
          iconSize: 11.73,
        ),
        const SizedBox(width: 8),
        _buildStatItem(
          label: 'Пациенты',
          value: '105',
          width: 41,
          iconSize: 13.19,
        ),
        const SizedBox(width: 8),
        _buildStatItem(
          label: 'Отзывы',
          value: '125',
          width: 39.06,
          iconSize: 0, // Нет иконки для отзывов
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required double width,
    required double iconSize,
  }) {
    return Container(
      width: width,
      height: 31.52,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconSize > 0)
                Container(
                  width: iconSize,
                  height: iconSize,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: FlutterLogo(),
                ),
              const SizedBox(width: 1.47),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF101522),
                  fontSize: 12,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.52),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF6A6A6A),
              fontSize: 8,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
