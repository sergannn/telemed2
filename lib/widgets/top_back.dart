import 'package:flutter/material.dart';

List<Widget> topBack(text, context) {
  return [
    //SizedBox(height: 40), // фиксированный отступ
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(), // раздвигает элементы
            IconButton(
              icon: const Icon(Icons.settings_input_component, size: 20),
              onPressed: () {}, //обработчик нажатия
            ),
          ],
        ),
      ),
    )
  ];
}
