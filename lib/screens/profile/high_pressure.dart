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

class HighPressureScreen extends StatefulWidget {
  const HighPressureScreen({Key? key}) : super(key: key);

  @override
  State<HighPressureScreen> createState() => _HighPressureScreenState();
}

class _HighPressureScreenState extends State<HighPressureScreen> with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  late TabController _tabController;
   late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
      // For network video
    _controller = VideoPlayerController.network(
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
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
              text: "Высокое давление",
              context: context,
              back: true,
              icon: Icon(Icons.favorite),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
              
                  SizedBox(height: 16),
                  Container(child:
                  _buildTabBar()),
                  // HealthContent(tabController, MediaQuery.of(context).size.height),
                 _buildTabContent(_tabController, MediaQuery.of(context).size.height),
                 /*
                  CustomButton(
                    width: size.width,
                    text: "Записаться",
                    margin: getMargin(left: 24, top: 22, right: 24),
                    variant: ButtonVariant.FillBlueA400,
                    fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                    alignment: Alignment.center,
                    onTap: () {
                      if (selectedDate != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AppointmentsStep2FilledScreen(date: selectedDate!),
                          ),
                        );
                      } else {
                        print("Дата не выбрана");
                      }
                    },
                  ),*/
                 // SizedBox(height: 100),
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
              child: Text('Статья'),
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

  Widget _buildTabContent(TabController _tabController, double height)  {
     return SizedBox(
      height: height,
    child: TabBarView(
      controller: _tabController,
      children: [
          
        _buildArticleContent(),
        _buildVideoContent(),
        FakeChatScreen()
//        Container(), // Обсуждение с врачами (пока пусто)
      ],
    ));
  }

  Widget _buildArticleContent() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: List.generate(
        8,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getSectionTitle(index),
              style: TextStyle(
                fontSize: getFontSize(16),
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceSansPro',
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getSectionText(index),
                style: TextStyle(
                  fontSize: getFontSize(14),
                  fontFamily: 'SourceSansPro',
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        _buildVideoItem(
          title: "Высокое давление - миф?",
          imageUrl: "assets/images/oneforvideo.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/twoforvideo.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/threeforvideo.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/fourforvideo.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/fiveforvideo.png",
        ),
      ],
    );
  }
void _toggleVideoPlayback() {
  setState(() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  });
}
  Widget _buildVideoItem({required String title, required String imageUrl}) {
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
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: getFontSize(16),
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceSansPro',
              ),
            ),
          ),Center(
        child: _controller.value.isInitialized
            ? GestureDetector(child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),onTap:  () {_controller.pause(); })
            : CircularProgressIndicator(),
      ),
          /*ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),*/
        ],
      ),
    );
  }

  String _getSectionTitle(int index) {
    final titles = [
      "Что нужно знать?",
      "Что такое высокое давление?",
      "Причины гипертонии?",
      "Симптомы высокого давления",
      "Последствия гипертонии",
      "Методы лечения",
      "Профилактика",
      "Заключение",
    ];
    return titles[index];
  }

  String _getSectionText(int index) {
    final texts = [
      "Высокое давление, или гипертония, представляет собой серьезную проблему для здоровья, затрагивающую миллионы людей по всему миру. В этой статье мы разберем основные аспекты заболевания, его причины, симптомы, методы лечения и профилактики.",
      "Высокое давление — это состояние, при котором значения артериального давления превышают нормальные показатели (обычно выше 140/90 мм рт. ст.). Гипертония считается «тихим убийцей», поскольку она может не иметь заметных симптомов, но в то же время приводит к серьезным последствиям, таким как инсульт, сердечная недостаточность и болезни почек.",
      "Существуют как первичные, так и вторичные формы гипертонии. Первичная гипертония (или эссенциальная) развивается без явной причины и чаще всего связана с наследственными факторами, неправильным образом жизни и стрессом. Вторичная гипертония возникает в результате других заболеваний, таких как заболевания почек, гормональные расстройства или употребление некоторых медикаментов.",
      "К сожалению, многие люди не чувствуют никаких симптомов при высоком давлении. Однако некоторые могут испытывать: головные боли, ощущение пульсации в голове, усталость или слабость, затуманенное зрение, одышку. Если вы замечаете у себя подобные симптомы, стоит обратиться к врачу для диагностики.",
      "Долгосрочное высокое давление может привести к множеству серьезных заболеваний, включая: инсульт, сердечные заболевания, поражения почек, потерю зрения, артериальные заболевания. Эти осложнения делают гипертонию одной из ведущих причин смертности в мире.",
      "Лечение высокого давления обычно включает изменение образа жизни и, при необходимости, применение медикаментов. К основным методам относятся: соблюдение сбалансированной диеты с низким содержанием соли и жиров, регулярные физические нагрузки, отказ от курения и ограничение алкоголя, управление стрессом. Если изменения в образе жизни недостаточны, врач может назначить гипотензивные средства, которые помогут контролировать давление.",
      "Профилактика гипертонии включает в себя: регулярные проверки артериального давления, поддержание здорового веса, употребление достаточного количества воды, ограничение потребления кофеина и алкоголя, стремление к активному образу жизни. Эти шаги помогут снизить риск развития гипертонии и других связанных заболеваний.",
      "Высокое давление — это серьезное заболевание, требующее внимания и своевременного вмешательства. Главное — следить за своим здоровьем, обращать внимание на признаки и вовремя консультироваться с врачом. Профилактика и правильное лечение помогут избежать серьезных последствий и улучшить качество жизни.",
    ];
    return texts[index];
  }
}


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
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Обсуждение с врачами"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),*/
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
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
      
      // Add fake doctor reply after 1 second
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