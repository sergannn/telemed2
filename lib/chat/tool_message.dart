import 'package:flutter/material.dart';
import 'chat_message_model.dart';

class ToolMessage extends StatefulWidget {
  final ChatMessageModel message;

  ToolMessage({required this.message});

  @override
  _ToolMessageState createState() => _ToolMessageState();
}

class _ToolMessageState extends State<ToolMessage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(15),
        ),
        height: _isExpanded ? MediaQuery.of(context).size.height - 100 : 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _isExpanded ? 'Tap to collapse' : 'Tap to expand',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            if (_isExpanded) ...[
              SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Text('Tool interface content goes here'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}