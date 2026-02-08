import 'package:flutter/material.dart';
import 'package:doctorq/test_daily_connection.dart';
import 'package:doctorq/config/daily_config.dart';

class DailyConnectionTestScreen extends StatefulWidget {
  const DailyConnectionTestScreen({Key? key}) : super(key: key);

  @override
  State<DailyConnectionTestScreen> createState() => _DailyConnectionTestScreenState();
}

class _DailyConnectionTestScreenState extends State<DailyConnectionTestScreen> {
  List<Map<String, dynamic>> _results = [];
  bool _isRunning = false;
  String _currentTest = '';

  Future<void> _runTests() async {
    setState(() {
      _isRunning = true;
      _results = [];
      _currentTest = 'Запуск тестов...';
    });

    try {
      // Network test
      setState(() => _currentTest = 'Проверка сети...');
      final networkResult = await DailyConnectionTest.testNetworkConnectivity();
      setState(() => _results.add(networkResult));

      // WebRTC ports test
      setState(() => _currentTest = 'Проверка WebRTC портов...');
      final webrtcResult = await DailyConnectionTest.testWebRTCConnectivity();
      setState(() => _results.add(webrtcResult));

      // SFU latency test
      setState(() => _currentTest = 'Проверка SFU серверов...');
      final sfuResult = await DailyConnectionTest.testSFULatency();
      setState(() => _results.add(sfuResult));

      // API test
      setState(() => _currentTest = 'Проверка Daily.co API...');
      final apiResult = await DailyConnectionTest.testApiConnection();
      setState(() => _results.add(apiResult));

      // Room test
      setState(() => _currentTest = 'Проверка тестовой комнаты...');
      final roomResult = await DailyConnectionTest.testRoomExists();
      setState(() => _results.add(roomResult));

    } catch (e) {
      setState(() {
        _results.add({
          'test': 'Error',
          'success': false,
          'message': e.toString(),
        });
      });
    }

    setState(() {
      _isRunning = false;
      _currentTest = '';
    });
  }

  Future<void> _createTestRoom() async {
    setState(() {
      _isRunning = true;
      _currentTest = 'Создание тестовой комнаты...';
    });

    try {
      final result = await DailyConnectionTest.createTestRoom();
      setState(() => _results.add(result));
    } catch (e) {
      setState(() {
        _results.add({
          'test': 'Create Room Error',
          'success': false,
          'message': e.toString(),
        });
      });
    }

    setState(() {
      _isRunning = false;
      _currentTest = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily.co Диагностика'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Config info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Конфигурация',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Domain: ${DailyConfig.domain}'),
                    Text('API URL: ${DailyConfig.baseUrl}'),
                    Text('Test Room: ${DailyConfig.testRoomUrl}'),
                    Text('API Key: ${DailyConfig.apiKey.substring(0, 10)}...'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isRunning ? null : _runTests,
                    icon: _isRunning 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow),
                    label: const Text('Запустить тесты'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isRunning ? null : _createTestRoom,
                    icon: const Icon(Icons.add),
                    label: const Text('Создать комнату'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            
            if (_currentTest.isNotEmpty) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(),
              const SizedBox(height: 8),
              Text(_currentTest, style: TextStyle(color: Colors.grey[600])),
            ],
            
            const SizedBox(height: 16),
            
            // Results
            if (_results.isNotEmpty) ...[
              const Text(
                'Результаты',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._results.map((result) => _buildResultCard(result)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result) {
    final success = result['success'] == true;
    final color = success ? Colors.green : Colors.red;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(
          success ? Icons.check_circle : Icons.error,
          color: color,
        ),
        title: Text(
          result['test'] ?? 'Unknown Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          result['message'] ?? '',
          style: TextStyle(color: Colors.grey[600]),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (result['responseTime'] != null)
                  Text('Response time: ${result['responseTime']}ms'),
                if (result['roomUrl'] != null)
                  SelectableText('Room URL: ${result['roomUrl']}'),
                if (result['roomName'] != null)
                  Text('Room name: ${result['roomName']}'),
                if (result['endpoints'] != null)
                  ...((result['endpoints'] as List).map((e) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Icon(
                          e['success'] == true ? Icons.check : Icons.close,
                          size: 16,
                          color: e['success'] == true ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${e['name']}: ${e['responseTime']}ms',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
