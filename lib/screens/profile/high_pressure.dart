import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighPressureScreen extends StatefulWidget {
  final int articleId;
  final String? articleTitle;

  const HighPressureScreen({Key? key, required this.articleId, this.articleTitle}) : super(key: key);

  @override
  State<HighPressureScreen> createState() => _HighPressureScreenState();
}

class _HighPressureScreenState extends State<HighPressureScreen> with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  late TabController _tabController;
  Map<String, dynamic>? article;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchArticle();
  }

  Future<void> _fetchArticle() async {
    try {
      final response = await http.get(
        Uri.parse('https://admin.onlinedoctor.su/api/articles/${widget.articleId}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> articleData = json.decode(response.body)['data'];
        setState(() {
          article = articleData;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load article: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading article: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(
            text: widget.articleTitle ?? article?['title'] ?? "Статья",
            context: context,
            back: true,
            icon: Icon(Icons.favorite),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: _buildTabBar(),
          ),
          Expanded(
            child: _buildTabContent(_tabController, MediaQuery.of(context).size.height),
          ),
        ],
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
              child: Text('Статьи'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Видео'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: Text('Обсуждение с врачами'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(TabController _tabController, double height) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildArticleContent(),
        _buildVideoContent(),
        ArticleCommentsScreen(articleId: widget.articleId)
      ],
    );
  }

  Widget _buildArticleContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (article == null) {
      return Center(child: Text('Статья не найдена'));
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: _buildArticleDetail(article!),
    );
  }
/*
  Widget _buildArticleItem(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article['image'] != null)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network('https://admin.onlinedoctor.su/storage/'+
                article['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article['category'] != null && article['category']['title'] != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      article['category']['title'],
                      style: TextStyle(
                        fontSize: getFontSize(12),
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: 8),
                Text(
                  article['title'] ?? 'Без названия',
                  style: TextStyle(
                    fontSize: getFontSize(18),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
                SizedBox(height: 8),
                if (article['description'] != null)
                  Text(
                    article['description'],
                    style: TextStyle(
                      fontSize: getFontSize(14),
                      fontFamily: 'SourceSansPro',
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _buildVideoContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (article == null || article!['video_url'] == null || article!['video_url'].toString().isEmpty) {
      return Center(child: Text('Нет видео для этой статьи'));//+article.toString()));
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: _buildVideoItem(article!),
    );
  }

  Widget _buildArticleDetail(Map<String, dynamic> article) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article['image'] != null)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network('https://admin.onlinedoctor.su/storage/'+
                article['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article['category'] != null && article['category']['title'] != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      article['category']['title'],
                      style: TextStyle(
                        fontSize: getFontSize(12),
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                Text(
                  article['title'] ?? 'Без названия',
                  style: TextStyle(
                    fontSize: getFontSize(24),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
                SizedBox(height: 16),
                if (article['description'] != null)
                  Text(
                    article['description'],
                    style: TextStyle(
                      fontSize: getFontSize(16),
                      fontFamily: 'SourceSansPro',
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                SizedBox(height: 16),
                if (article['html'] != null)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 300,
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: WebViewWidget(
                        controller: WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..loadHtmlString(
                            '''
                            <!DOCTYPE html>
                            <html>
                            <head>
                              <meta name="viewport" content="width=device-width, initial-scale=1.0">
                              <style>
                                body {
                                  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                                  font-size: 14px;
                                  line-height: 1.5;
                                  color: #374151;
                                  padding: 0;
                                  margin: 0;
                                }
                                img { max-width: 100%; height: auto; }
                                iframe { max-width: 100%; }
                                table { width: 100%; border-collapse: collapse; }
                                th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                                th { background-color: #f3f4f6; }
                              </style>
                            </head>
                            <body>
                              ${article['html']}
                            </body>
                            </html>
                            ''',
                          ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoItem(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article['category'] != null && article['category']['title'] != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      article['category']['title'],
                      style: TextStyle(
                        fontSize: getFontSize(12),
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: 8),
                Text(
                  article['title'] ?? 'Без названия',
                  style: TextStyle(
                    fontSize: getFontSize(18),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
              ],
            ),
          ),
          if (article['video_url'] != null)
            Container(
              padding: EdgeInsets.all(16),
              child: VideoPlayerWidget(videoUrl: article['video_url']),
            ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
          if (!_isPlaying && _controller.value.isInitialized)
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 48,
              ),
            ),
        ],
      ),
    );
  }
}

// Реальный экран комментариев к статье
class ArticleCommentsScreen extends StatefulWidget {
  final int articleId;
  
  const ArticleCommentsScreen({Key? key, required this.articleId}) : super(key: key);
  
  @override
  _ArticleCommentsScreenState createState() => _ArticleCommentsScreenState();
}

class _ArticleCommentsScreenState extends State<ArticleCommentsScreen> {
  final List<ArticleComment> _comments = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isSending = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://admin.onlinedoctor.su/api/articles/${widget.articleId}/comments'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          setState(() {
            _comments.clear();
            for (var commentData in data['data']) {
              _comments.add(ArticleComment.fromJson(commentData));
            }
            _isLoading = false;
          });
          _scrollToBottom();
        }
      } else {
        setState(() {
          _errorMessage = 'Не удалось загрузить комментарии';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка загрузки: $e';
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendComment(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _isSending = true;
    });

    try {
      // Получаем токен авторизации
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Необходимо войти в систему')),
        );
        setState(() {
          _isSending = false;
        });
        return;
      }

      final response = await http.post(
        Uri.parse('https://admin.onlinedoctor.su/api/articles/${widget.articleId}/comments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: json.encode({'text': text}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        _textController.clear();
        setState(() {
          _comments.add(ArticleComment.fromJson(data['data']));
          _isSending = false;
        });
        _scrollToBottom();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Ошибка отправки')),
        );
        setState(() {
          _isSending = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadComments,
              child: Text('Повторить'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: _comments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'Пока нет комментариев',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Будьте первым, кто оставит комментарий!',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    return _buildCommentWidget(_comments[index]);
                  },
                ),
        ),
        _buildMessageComposer(),
      ],
    );
  }

  Widget _buildCommentWidget(ArticleComment comment) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: comment.doctorProfileImage != null
                ? NetworkImage(comment.doctorProfileImage!)
                : AssetImage('assets/images/11.png') as ImageProvider,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.doctorName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      _formatTime(comment.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (comment.specializations.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      comment.specializations.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    comment.text,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 0) {
      return DateFormat('dd.MM.yy HH:mm').format(time);
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ч. назад';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} мин. назад';
    } else {
      return 'только что';
    }
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Напишите комментарий...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
            SizedBox(width: 8),
            _isSending
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      if (_textController.text.trim().isNotEmpty) {
                        _sendComment(_textController.text);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// Модель комментария к статье
class ArticleComment {
  final int id;
  final String text;
  final DateTime createdAt;
  final int? doctorId;
  final String doctorName;
  final String? doctorProfileImage;
  final List<String> specializations;
  final List<ArticleComment> replies;

  ArticleComment({
    required this.id,
    required this.text,
    required this.createdAt,
    this.doctorId,
    required this.doctorName,
    this.doctorProfileImage,
    required this.specializations,
    required this.replies,
  });

  factory ArticleComment.fromJson(Map<String, dynamic> json) {
    return ArticleComment(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      doctorId: json['doctor']?['id'],
      doctorName: json['doctor']?['full_name'] ?? 'Врач',
      doctorProfileImage: json['doctor']?['profile_image'],
      specializations: List<String>.from(json['doctor']?['specializations'] ?? []),
      replies: (json['replies'] as List<dynamic>?)
              ?.map((r) => ArticleComment.fromJson(r))
              .toList() ??
          [],
    );
  }
}
