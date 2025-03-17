import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class PromocodesCertificatesScreen extends StatelessWidget {
  const PromocodesCertificatesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text:"Промокоды и сертификаты",context: context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                        
                          const Text(
                            'Ожидает дальнейшей разработки',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                          const Spacer(), // раздвигает элементы
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
