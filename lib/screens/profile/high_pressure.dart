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
        FakeChatScreen()
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

// Keep the existing FakeChatScreen class as it was
class FakeChatScreen extends StatefulWidget {
  @override
  _FakeChatScreenState createState() => _FakeChatScreenState();
}

class _FakeChatScreenState extends State<FakeChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Здравствуйте! У меня вопрос по поводу давления.",
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 5))),
    ChatMessage(
      text: "Добрый день! Чем могу помочь?",
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 4))),
    ChatMessage(
      text: "Какое давление считается нормальным для человека 45 лет?",
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 3))),
    ChatMessage(
      text: "Нормальное давление для взрослого человека - 120/80 мм рт.ст. Но небольшие отклонения в пределах 110-139/70-89 тоже могут быть нормальными.",
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 2))),
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _buildMessage(_messages[index]);
            },
          ),
        ),
        _buildMessageComposer(),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: message.isMe 
                ? Color(0xFFE3F2FD) 
                : Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: message.isMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight: message.isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(message.time),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: "Напишите сообщение...",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (_textController.text.trim().isNotEmpty) {
                _sendMessage(_textController.text);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isMe: true,
        time: DateTime.now(),
      ));
      
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _messages.add(ChatMessage(
            text: _getRandomDoctorReply(),
            isMe: false,
            time: DateTime.now(),
          ));
        });
      });
    });
  }

  String _getRandomDoctorReply() {
    final replies = [
      "Похоже на классические симптомы гипертонии.",
      "Рекомендую измерить давление утром и вечером в течение недели.",
      "Вам следует обратиться к кардиологу для дополнительного обследования.",
      "Попробуйте уменьшить потребление соли и больше отдыхать.",
      "При таком давлении лучше вызвать скорую помощь.",
    ];
    return replies[DateTime.now().millisecond % replies.length];
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}
