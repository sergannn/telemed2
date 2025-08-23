import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';

class HighPressureScreen extends StatefulWidget {
  const HighPressureScreen({Key? key}) : super(key: key);

  @override
  State<HighPressureScreen> createState() => _HighPressureScreenState();
}

class _HighPressureScreenState extends State<HighPressureScreen> with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        Container(), // Обсуждение с врачами (пока пусто)
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
          imageUrl: "assets/images/davlenie.jpg",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/davlenie2.jpg",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/gol.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/forvideo.png",
        ),
        SizedBox(height: 16),
        _buildVideoItem(
          title: "Все о давлении",
          imageUrl: "assets/images/fiveforvideo.png",
        ),
      ],
    );
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
          ),
          ClipRRect(
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
          ),
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