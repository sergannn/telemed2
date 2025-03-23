import 'package:flutter/material.dart';
import 'package:number_pad_keyboard/number_pad_keyboard.dart';

class Numscreen extends StatelessWidget {
  Numscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NumState(),
    );
  }
}

class NumState extends StatefulWidget {
  NumState({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NumState> {
  final TextEditingController _textController = TextEditingController();

  void _addDigit(int digit) {
    if (_textController.text.length < 10) {
      setState(() {
        _textController.text = _textController.text + digit.toString();
      });
    }
  }

  void _backspace() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _textController.text =
            _textController.text.substring(0, _textController.text.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            // Handle blocked back navigation
            print('Back navigation prevented');
          }
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Введите код для входа',
                    ),
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                const SizedBox(height: 200.0),
                NumberPadKeyboard(
                  numberStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  //  color: Colors.white,
                  //  backgroundColor: Colors.blue),
                  addDigit: _addDigit,
                  backspace: _backspace,
                  enterButtonText: 'ENTER',
                  onEnter: () {
                    Navigator.pop(context);
                    debugPrint('PIN Code: ${_textController.text}');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
