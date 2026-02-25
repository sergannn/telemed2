import 'package:flutter/material.dart';

class FigmaToCodeApp extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FigmaToCodeApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/doctor1.png'),
                ),
                SizedBox(width: screenWidth * 0.02), // 2% of screen width
                Text('Алла', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Add notification action here
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Section with Calendar
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenHeight * 0.02), // 2% of screen height
              child: Row(
                children: [
                  DateCard(
                      date: '25',
                      color: Colors.blue,
                      time: '20:00',
                      event: 'Онлайн прием врач аллерголог',
                      width: screenWidth),
                  DateCard(
                      date: '26',
                      color: Colors.yellow,
                      time: '10:00',
                      event: 'Прием лекарств амбулаторно',
                      width: screenWidth),
                  DateCard(
                      date: '27',
                      color: Colors.blue,
                      time: '08:00',
                      event: 'Профилактика заболеваний',
                      width: screenWidth),
                ],
              ),
            ),
            // Search Bar
            TextField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                labelText: 'Найти врача',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.blue.shade50,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            // Appointment Section
            SectionTitle(title: 'Доступ к пациентам'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppointmentCard(
                  color: Colors.blue,
                  title: 'Онлайн прием',
                  subtitle: 'Предварительный диагноз',
                  rating: 4.3,
                  patients: 200,
                  reviews: 150,
                  width: screenWidth,
                ),
                AppointmentCard(
                  color: Colors.yellow,
                  title: 'Онлайн прием',
                  subtitle: 'Предварительный диагноз',
                  rating: 4.3,
                  patients: 14,
                  reviews: 14,
                  width: screenWidth,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            SizedBox(
                width: screenWidth *
                    0.12), // Center space for the floating action button
            IconButton(
              icon: Icon(Icons.health_and_safety),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action for the central + button
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Custom widget for Date cards (Calendar)
class DateCard extends StatelessWidget {
  final String date;
  final Color color;
  final String time;
  final String event;
  final double width;

  DateCard(
      {required this.date,
      required this.color,
      required this.time,
      required this.event,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.28, // 28% of screen width
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(date,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 8),
          Text(time, style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(event, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// Custom widget for Appointment cards
class AppointmentCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final double rating;
  final int patients;
  final int reviews;
  final double width;

  AppointmentCard({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.patients,
    required this.reviews,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.43, // 43% of screen width
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text(subtitle, style: TextStyle(color: Colors.white)),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              SizedBox(width: 4),
              Text('$rating', style: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Text('$patients пациентов',
                  style: TextStyle(color: Colors.white)),
              SizedBox(width: 8),
              Text('$reviews отзывов', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom widget for section titles
class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
