import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/doctors_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:flutter/material.dart';

class DoctorsSliderItem extends StatelessWidget {
  int index;

  Map<String, dynamic> item;
  DoctorsSliderItem({Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) {
              context.setSelectedDoctorByIndex(index);
              return AppointmentsBookScreen();
            }));
          },
          child: Container(
            width: getHorizontalSize(160),
            decoration: BoxDecoration(
              color: isDark
                  ? ColorConstant.darkContainer
                  : ColorConstant.whiteA700,
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  12.00,
                ),
              ),
              border: Border.all(
                color:
                    isDark ? ColorConstant.darkLine : ColorConstant.bluegray50,
                width: getHorizontalSize(
                  1.00,
                ),
              ),
            ),
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
          ),
        ),
      ),
    );
  }
}
