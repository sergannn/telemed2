import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/recommendation_model.dart';
import 'package:doctorq/screens/profile/high_pressure.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecommendationItemWidget extends StatelessWidget {
  final RecommendationModel recommendation;
  final int index;
  
  RecommendationItemWidget({Key? key, required this.recommendation, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HighPressureScreen(
              articleId: recommendation.id,
              articleTitle: recommendation.title,
            ),
          ),
        );
      },
      child: Container(
        width: getHorizontalSize(280),
        margin: getMargin(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: getVerticalSize(160),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage('https://admin.onlinedoctor.su/storage/' + recommendation.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: getPadding(all: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recommendation.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorConstant.bluegray800,
                      fontSize: getFontSize(16),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Description (if available)
                  if (recommendation.description != null && recommendation.description!.isNotEmpty)
                    Text(
                      recommendation.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorConstant.bluegray300,
                        fontSize: getFontSize(14),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
