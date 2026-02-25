import 'dart:typed_data';
import 'package:doctorq/screens/medcard/profile_survey.dart';
import 'package:doctorq/screens/profile/high_pressure.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:table_calendar/TableCalendar.dart';
import 'dart:convert';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<dynamic> articles = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this); // Убрали трекер, оставили только статьи
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse('https://admin.onlinedoctor.su/api/articles'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> fetchedArticles = responseData['data'] ?? [];
        
        setState(() {
          articles = fetchedArticles;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load articles: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading articles: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...topBack(
                text: "Здоровье",
                context: context,
                back: false,
                icon: Icon(Icons.favorite)),
            Container(
              width: double.infinity,
             // margin: EdgeInsets.symmetric(horizontal: 16),
              child: _buildTabBar(tabController),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  RefreshIndicator(
                    onRefresh: _fetchArticles,
                    child: ArticlesSection(),
                  ),
                ],
              ),
            )
          ]),
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
        ],
      ),
    );
  }

  Widget ArticlesSection() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (articles.isEmpty) {
      return Center(child: Text('Нет статей'));
    }

    // Group articles by category for better organization
    final Map<String, List<dynamic>> articlesByCategory = {};
    
    for (var article in articles) {
      final categoryName = article['category'] != null && article['category']['title'] != null
          ? article['category']['title']
          : 'Без категории';
      
      if (!articlesByCategory.containsKey(categoryName)) {
        articlesByCategory[categoryName] = [];
      }
      articlesByCategory[categoryName]!.add(article);
    }

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      children: articlesByCategory.entries.map((entry) {
        final categoryName = entry.key;
        final categoryArticles = entry.value;
        return ArticleSection(
          title: categoryName,
          articles: categoryArticles,
        );
      }).toList(),
    );
  }

  Widget ArticleSection({required String title, required List<dynamic> articles}) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
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
              children: articles.map((article) => Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to article detail screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HighPressureScreen(
                          articleId: article['id'],
                          articleTitle: article['title'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: article['image'] != null
                            ? Image.network('https://admin.onlinedoctor.su/storage/'+
                                article['image'],
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 160,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.error),
                                  );
                                },
                              )
                            : Container(
                                width: 160,
                                height: 100,
                                color: Colors.grey[300],
                                child: Icon(Icons.article),
                              ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 160,
                        child: Text(
                          article['title'] ?? 'Без названия',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getFontSize(12),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
