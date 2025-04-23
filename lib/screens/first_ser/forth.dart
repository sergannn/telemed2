import 'package:flutter/material.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class forthScreen extends StatelessWidget {
  const forthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // User swiped left
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            body: CustomContainer(),
          ),
        ));
  }
}

class CustomContainer extends StatelessWidget {
  final String imageUrl =
      'assets/images/a_hands.jpg'; // Replace with your image path
  final String bottomText =
      'Возможность записи на онлайн-консультацию писаться к врачу \n 24/7';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.7, 1],
              colors: [
                Colors.white.withOpacity(0),
                Color(0x6B1A5F7E),
                Color(0xFF1C5E7E)
              ],
            ),
          ),
        ),

        Positioned(
            left: 16,
            bottom: MediaQuery.of(context).size.height / 10,
            right: 16,
            child: Column(
              children: [
                Text(
                  bottomText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        ...List.generate(
                          4,
                          (_) => Container(
                            // child: Text(_.toString()),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _ == 3 ? Colors.blue : Colors.white,
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(
                            right:
                                16), // Matches the Positioned widget's padding
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.blue,
                          elevation: 1000,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInBlankScreen()),
                            );
                          },
                          label: Text("Далее"),
                        ),
                      ),
                    ])
              ],
            ))
      ]),
    );
  }
}
