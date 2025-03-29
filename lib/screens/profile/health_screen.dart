import 'dart:typed_data';
import 'package:doctorq/screens/medcard/profile_survey.dart';
import 'package:doctorq/screens/profile/high_pressure.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
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
                text: "Здоровье",
                context: context,
                back: false,
                icon: Icon(Icons.favorite)),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: _buildTabBar(tabController),
            ),
            HealthContent(tabController, MediaQuery.of(context).size.height),
            VerticalSpace(height: 224),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(TabController? controller) {
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
        onTap: (int index) {
          if (index == 1) {
            // Трекер пока пустой
            return;
          }
        },
        controller: controller,
        isScrollable: true,
        padding: getPadding(top: 10, bottom: 10),
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(120),
          color: Colors.white,
        ),
        unselectedLabelColor: ColorConstant.blueA400,
        unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.w600,
          fontFamily: 'Source Sans Pro',
        ),
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.w600,
          fontFamily: 'Source Sans Pro',
        ),
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Статьи'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Трекер'),
            ),
          ),
        ],
      ),
    );
  }

  Widget HealthContent(TabController? tabController, double height) {
    return SizedBox(
      height: height,
      child: TabBarView(
        controller: tabController,
        children: [
          ArticlesSection(),
          Container(), // Пустой трекер
        ],
      ),
    );
  }

  Widget ArticlesSection() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HighPressureScreen()),
          );
        },
        child:
        ArticleSection(
          title: "Важные советы от врачей",
          images: [
            ArticleImage(
              imageUrl: "assets/images/ad.png",
              title: "Высокое давление",
            ),
            ArticleImage(
              imageUrl: "assets/images/abouthealth.png",
              title: "5 причин заболеваний",
            ),
          ],
        ),
      ),
        VerticalSpace(height: 24),
        ArticleSection(
          title: "Все про симптомы",
          images: [
            ArticleImage(
              imageUrl: "assets/images/pain.png",
              title: "Головная боль",
            ),
            ArticleImage(
              imageUrl: "assets/images/vomiting.png",
              title: "Рвота и тошнота",
            ),
          ],
        ),
        VerticalSpace(height: 24),
        ArticleSection(
          title: "В чем смысл здорового образа жизни",
          images: [
            ArticleImage(
              imageUrl: "assets/images/backpain.png",
              title: "Спинная боль",
            ),
            ArticleImage(
              imageUrl: "assets/images/vitamins.png",
              title: "Витамины: миф или реальность",
            ),
          ],
        ),
        VerticalSpace(height: 24),
        ArticleSection(
          title: "Важное про беременность",
          images: [
            ArticleImage(
              imageUrl: "assets/images/screening.png",
              title: "Зачем нужны скрининги",
            ),
            ArticleImage(
              imageUrl: "assets/images/how.png",
              title: "Как подготовиться к родам",
            ),
          ],
        ),
        SizedBox(height: 38),
      ],
    );
  }

  Widget ArticleSection({required String title, required List<ArticleImage> images}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: getFontSize(16),
              fontWeight: FontWeight.bold,
              fontFamily: 'Source Sans Pro',
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: images.map((image) => Padding(
                padding: EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image.imageUrl,
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      image.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getFontSize(12),
                        fontFamily: 'Source Sans Pro',
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleImage {
  final String imageUrl;
  final String title;

  ArticleImage({
    required this.imageUrl,
    required this.title,
  });
}