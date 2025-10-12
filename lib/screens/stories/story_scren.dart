import 'package:doctorq/screens/main_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_story_view/flutter_story_view.dart';
//import 'package:flutter_story_view/models/story_item.dart';
//import 'package:flutter_story_view/models/user_info.dart';

import 'package:story_view/story_view.dart';

//void main() => runApp(MyApp());

class StoryScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WhatsApp Story View',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: WhatsAppStoryViewExample());
  }
}

class WhatsAppStoryViewExample extends StatefulWidget {
  const WhatsAppStoryViewExample({Key? key}) : super(key: key);

  @override
  State<WhatsAppStoryViewExample> createState() =>
      _WhatsAppStoryViewExampleState();
}

class _WhatsAppStoryViewExampleState extends State<WhatsAppStoryViewExample> {
  final StoryController controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      body: Stack(
        children: [
          InkWell(
            onTap: () {
              print("a");
            },
            onHover: (value) {
              print('hover');
              Navigator.of(context).pop();
            },
            child: Container(
              height: MediaQuery.of(context).size.height - 25,
              // constraints: BoxConstraints.expand(),
              child: StoryView(
                onVerticalSwipeComplete: (direction) {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                controller: controller,
                storyItems: [
                  StoryItem.inlineImage(
                    url:
                        "https://img.freepik.com/free-photo/mobile-phone-stethoscope-chart-file-desktop-mobile-medical-handheld-doctor-concepts_1387-450.jpg",
                    controller: controller,
                    caption: Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  StoryItem.pageImage(
                    url:
                        "https://thumbs.dreamstime.com/b/vertical-photo-collage-sad-man-iphone-video-call-doctor-girl-stand-back-isolation-pills-prescription-help-isolated-vertical-315748893.jpg",
                    controller: controller,
                    caption: Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
                onComplete: () {
                  print("Completed");
                }, // called when stories completed

                indicatorColor:
                    Colors.grey[500], // You can modify it whichever you like :)
                indicatorHeight: IndicatorHeight
                    .large, // You can modify it whichever you like :)
              ),
            ),
          )
        ],
      ),
    );
  }
}
