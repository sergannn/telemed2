import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctorq/config/daily_config.dart';

/// Тестовый класс для диагностики подключения к Daily.co
class DailyConnectionTest {
  
  /// Проверка WebRTC портов и TURN серверов
  static Future<Map<String, dynamic>> testWebRTCConnectivity() async {
    print('\n=== TEST: WebRTC Connectivity ===');
    final results = <String, dynamic>{
      'test': 'WebRTC Connectivity',
      'success': false,
      'message': '',
      'ports': <Map<String, dynamic>>[],
    };
    
    // Daily.co использует эти порты для WebRTC
    final webrtcEndpoints = [
      {'host': 'global.turn.daily.co', 'port': 443, 'protocol': 'TURN/TLS'},
      {'host': 'global.turn.daily.co', 'port': 3478, 'protocol': 'TURN/UDP'},
      {'host': 'global.stun.daily.co', 'port': 3478, 'protocol': 'STUN'},
      {'host': 'sfu.daily.co', 'port': 443, 'protocol': 'SFU/WSS'},
    ];
    
    int successCount = 0;
    
    for (final endpoint in webrtcEndpoints) {
      final portResult = <String, dynamic>{
        'host': endpoint['host'],
        'port': endpoint['port'],
        'protocol': endpoint['protocol'],
        'success': false,
      };
      
      try {
        final socket = await Socket.connect(
          endpoint['host'] as String,
          endpoint['port'] as int,
          timeout: const Duration(seconds: 5),
        );
        await socket.close();
        
        portResult['success'] = true;
        successCount++;
        print('✓ ${endpoint['protocol']}: ${endpoint['host']}:${endpoint['port']}');
      } on SocketException catch (e) {
        portResult['error'] = 'Socket: ${e.message}';
        print('✗ ${endpoint['protocol']}: ${endpoint['host']}:${endpoint['port']} - ${e.message}');
      } on TimeoutException {
        portResult['error'] = 'Timeout';
        print('✗ ${endpoint['protocol']}: ${endpoint['host']}:${endpoint['port']} - Timeout');
      } catch (e) {
        portResult['error'] = e.toString();
        print('✗ ${endpoint['protocol']}: ${endpoint['host']}:${endpoint['port']} - $e');
      }
      
      (results['ports'] as List).add(portResult);
    }
    
    results['success'] = successCount >= 2; // Минимум 2 работающих endpoint
    results['message'] = '$successCount/${webrtcEndpoints.length} WebRTC endpoints доступны';
    
    if (successCount < 2) {
      results['recommendation'] = 'Возможно, firewall блокирует WebRTC порты. Проверьте настройки сети.';
    }
    
    return results;
  }
  
  /// Проверка времени отклика SFU серверов Daily
  static Future<Map<String, dynamic>> testSFULatency() async {
    print('\n=== TEST: SFU Server Latency ===');
    final results = <String, dynamic>{
      'test': 'SFU Server Latency',
      'success': false,
      'message': '',
      'latencies': <Map<String, dynamic>>[],
    };
    
    // Региональные SFU серверы Daily.co
    final sfuServers = [
      'https://sfu.daily.co',
      'https://c5.sfu.daily.co', // US
      'https://c6.sfu.daily.co', // EU
    ];
    
    int successCount = 0;
    int minLatency = 999999;
    
    for (final server in sfuServers) {
      final stopwatch = Stopwatch()..start();
      final latencyResult = <String, dynamic>{
        'server': server,
        'success': false,
        'latency': 0,
      };
      
      try {
        final response = await http.head(
          Uri.parse(server),
        ).timeout(const Duration(seconds: 10));
        
        stopwatch.stop();
        latencyResult['latency'] = stopwatch.elapsedMilliseconds;
        latencyResult['success'] = response.statusCode < 500;
        latencyResult['statusCode'] = response.statusCode;
        
        if (latencyResult['success'] == true) {
          successCount++;
          if (stopwatch.elapsedMilliseconds < minLatency) {
            minLatency = stopwatch.elapsedMilliseconds;
          }
          print('✓ $server: ${stopwatch.elapsedMilliseconds}ms');
        } else {
          print('✗ $server: HTTP ${response.statusCode}');
        }
      } on TimeoutException {
        stopwatch.stop();
        latencyResult['error'] = 'Timeout (>10s)';
        print('✗ $server: Timeout');
      } catch (e) {
        stopwatch.stop();
        latencyResult['error'] = e.toString();
        print('✗ $server: $e');
      }
      
      (results['latencies'] as List).add(latencyResult);
    }
    
    results['success'] = successCount > 0;
    results['minLatency'] = minLatency == 999999 ? null : minLatency;
    results['message'] = successCount > 0 
        ? '$successCount SFU серверов доступны, мин. latency: ${minLatency}ms'
        : 'Все SFU серверы недоступны!';
    
    if (minLatency > 500) {
      results['recommendation'] = 'Высокая задержка ($minLatency ms). Возможны проблемы с подключением.';
    }
    
    return results;
  }
  
  /// Проверка доступности Daily.co API
  static Future<Map<String, dynamic>> testApiConnection() async {
    print('\n=== TEST 1: API Connection ===');
    final results = <String, dynamic>{
      'test': 'API Connection',
      'success': false,
      'message': '',
      'responseTime': 0,
    };
    
    final stopwatch = Stopwatch()..start();
    
    try {
      final response = await http.get(
        Uri.parse('${DailyConfig.baseUrl}/rooms'),
        headers: {
          'Authorization': 'Bearer ${DailyConfig.apiKey}',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      
      stopwatch.stop();
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        results['success'] = true;
        results['message'] = 'API доступен. Найдено ${data['data']?.length ?? 0} комнат';
        results['roomCount'] = data['data']?.length ?? 0;
        print('✓ API Connection OK (${stopwatch.elapsedMilliseconds}ms)');
      } else {
        results['message'] = 'HTTP ${response.statusCode}: ${response.body}';
        print('✗ API Error: ${response.statusCode}');
      }
    } on TimeoutException {
      stopwatch.stop();
      results['message'] = 'Timeout после 10 секунд';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ API Timeout');
    } catch (e) {
      stopwatch.stop();
      results['message'] = 'Ошибка: $e';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ API Error: $e');
    }
    
    return results;
  }
  
  /// Проверка существования тестовой комнаты
  static Future<Map<String, dynamic>> testRoomExists() async {
    print('\n=== TEST 2: Test Room Exists ===');
    final results = <String, dynamic>{
      'test': 'Test Room Exists',
      'success': false,
      'message': '',
      'responseTime': 0,
    };
    
    final stopwatch = Stopwatch()..start();
    final roomName = DailyConfig.testRoomUrl.split('/').last;
    
    try {
      final response = await http.get(
        Uri.parse('${DailyConfig.baseUrl}/rooms/$roomName'),
        headers: {
          'Authorization': 'Bearer ${DailyConfig.apiKey}',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      
      stopwatch.stop();
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        results['success'] = true;
        results['message'] = 'Комната существует: ${data['name']}';
        results['roomData'] = data;
        print('✓ Room exists: ${data['name']} (${stopwatch.elapsedMilliseconds}ms)');
      } else if (response.statusCode == 404) {
        results['message'] = 'Комната не найдена (404)';
        print('✗ Room not found');
      } else {
        results['message'] = 'HTTP ${response.statusCode}';
        print('✗ HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      stopwatch.stop();
      results['message'] = 'Timeout';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Timeout');
    } catch (e) {
      stopwatch.stop();
      results['message'] = 'Ошибка: $e';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Error: $e');
    }
    
    return results;
  }
  
  /// Создание новой тестовой комнаты
  static Future<Map<String, dynamic>> createTestRoom() async {
    print('\n=== TEST 3: Create Test Room ===');
    final results = <String, dynamic>{
      'test': 'Create Test Room',
      'success': false,
      'message': '',
      'responseTime': 0,
    };
    
    final stopwatch = Stopwatch()..start();
    final roomName = 'test_${DateTime.now().millisecondsSinceEpoch}';
    
    try {
      final response = await http.post(
        Uri.parse('${DailyConfig.baseUrl}/rooms'),
        headers: {
          'Authorization': 'Bearer ${DailyConfig.apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': roomName,
          'privacy': 'public',
          'properties': {
            'exp': DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
            'enable_chat': true,
            'enable_screenshare': true,
          },
        }),
      ).timeout(const Duration(seconds: 15));
      
      stopwatch.stop();
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        results['success'] = true;
        results['message'] = 'Комната создана';
        results['roomUrl'] = data['url'];
        results['roomName'] = data['name'];
        print('✓ Room created: ${data['url']} (${stopwatch.elapsedMilliseconds}ms)');
      } else {
        results['message'] = 'HTTP ${response.statusCode}: ${response.body}';
        print('✗ Failed: ${response.statusCode}');
      }
    } on TimeoutException {
      stopwatch.stop();
      results['message'] = 'Timeout при создании комнаты';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Timeout');
    } catch (e) {
      stopwatch.stop();
      results['message'] = 'Ошибка: $e';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Error: $e');
    }
    
    return results;
  }
  
  /// Проверка сетевого подключения
  static Future<Map<String, dynamic>> testNetworkConnectivity() async {
    print('\n=== TEST 4: Network Connectivity ===');
    final results = <String, dynamic>{
      'test': 'Network Connectivity',
      'success': false,
      'endpoints': <Map<String, dynamic>>[],
    };
    
    final endpoints = [
      {'name': 'Google', 'url': 'https://www.google.com'},
      {'name': 'Daily.co Main', 'url': 'https://daily.co'},
      {'name': 'Daily.co API', 'url': 'https://api.daily.co'},
      {'name': 'Your Domain', 'url': 'https://${DailyConfig.domain}'},
    ];
    
    int successCount = 0;
    
    for (final endpoint in endpoints) {
      final stopwatch = Stopwatch()..start();
      final endpointResult = <String, dynamic>{
        'name': endpoint['name'],
        'url': endpoint['url'],
        'success': false,
        'responseTime': 0,
      };
      
      try {
        final response = await http.head(
          Uri.parse(endpoint['url']!),
        ).timeout(const Duration(seconds: 5));
        
        stopwatch.stop();
        endpointResult['responseTime'] = stopwatch.elapsedMilliseconds;
        endpointResult['success'] = response.statusCode < 400;
        endpointResult['statusCode'] = response.statusCode;
        
        if (endpointResult['success'] == true) {
          successCount++;
          print('✓ ${endpoint['name']}: ${response.statusCode} (${stopwatch.elapsedMilliseconds}ms)');
        } else {
          print('✗ ${endpoint['name']}: ${response.statusCode}');
        }
      } on TimeoutException {
        stopwatch.stop();
        endpointResult['responseTime'] = stopwatch.elapsedMilliseconds;
        endpointResult['error'] = 'Timeout';
        print('✗ ${endpoint['name']}: Timeout');
      } catch (e) {
        stopwatch.stop();
        endpointResult['responseTime'] = stopwatch.elapsedMilliseconds;
        endpointResult['error'] = e.toString();
        print('✗ ${endpoint['name']}: $e');
      }
      
      (results['endpoints'] as List).add(endpointResult);
    }
    
    results['success'] = successCount == endpoints.length;
    results['message'] = '$successCount/${endpoints.length} endpoints доступны';
    
    return results;
  }
  
  /// Проверка конкретной комнаты по URL
  static Future<Map<String, dynamic>> testSpecificRoom(String roomUrl) async {
    print('\n=== TEST: Specific Room ===');
    final results = <String, dynamic>{
      'test': 'Specific Room Check',
      'success': false,
      'message': '',
      'roomUrl': roomUrl,
    };
    
    final roomName = roomUrl.split('/').last;
    final stopwatch = Stopwatch()..start();
    
    try {
      final response = await http.get(
        Uri.parse('${DailyConfig.baseUrl}/rooms/$roomName'),
        headers: {
          'Authorization': 'Bearer ${DailyConfig.apiKey}',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      
      stopwatch.stop();
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        results['success'] = true;
        results['roomData'] = data;
        
        // Проверяем срок действия
        if (data['config'] != null && data['config']['exp'] != null) {
          final expTimestamp = data['config']['exp'] as int;
          final expDate = DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
          final now = DateTime.now();
          
          results['expiresAt'] = expDate.toIso8601String();
          results['isExpired'] = expDate.isBefore(now);
          
          if (results['isExpired'] == true) {
            results['success'] = false;
            results['message'] = 'Комната истекла: ${expDate.toString()}';
            print('✗ Room expired at: $expDate');
          } else {
            final remaining = expDate.difference(now);
            results['message'] = 'Комната активна. Истекает через: ${remaining.inMinutes} минут';
            print('✓ Room valid, expires in ${remaining.inMinutes} minutes');
          }
        } else {
          results['message'] = 'Комната существует (без срока действия)';
          print('✓ Room exists (no expiration)');
        }
        
        // Проверяем privacy
        results['privacy'] = data['privacy'];
        print('  Privacy: ${data['privacy']}');
        
      } else if (response.statusCode == 404) {
        results['message'] = 'Комната не найдена (404)';
        print('✗ Room not found');
      } else {
        results['message'] = 'HTTP ${response.statusCode}: ${response.body}';
        print('✗ HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      stopwatch.stop();
      results['message'] = 'Timeout при проверке комнаты';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Timeout');
    } catch (e) {
      stopwatch.stop();
      results['message'] = 'Ошибка: $e';
      results['responseTime'] = stopwatch.elapsedMilliseconds;
      print('✗ Error: $e');
    }
    
    return results;
  }
  
  /// Получение диагностической информации
  static Map<String, dynamic> getDiagnosticInfo() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'config': {
        'domain': DailyConfig.domain,
        'apiUrl': DailyConfig.baseUrl,
        'testRoomUrl': DailyConfig.testRoomUrl,
        'apiKeyPresent': DailyConfig.apiKey.isNotEmpty,
        'apiKeyPrefix': DailyConfig.apiKey.substring(0, 8),
      },
      'recommendations': [
        'Убедитесь, что firewall не блокирует порты 443, 3478 (UDP/TCP)',
        'Проверьте, что Wi-Fi/мобильный интернет работает стабильно',
        'Попробуйте переключиться между Wi-Fi и мобильными данными',
        'Если используете VPN - попробуйте отключить',
      ],
    };
  }
  
  /// Запуск всех тестов
  static Future<List<Map<String, dynamic>>> runAllTests() async {
    print('\n' + '=' * 50);
    print('DAILY.CO CONNECTION DIAGNOSTICS');
    print('=' * 50);
    print('Domain: ${DailyConfig.domain}');
    print('Test Room: ${DailyConfig.testRoomUrl}');
    print('Time: ${DateTime.now()}');
    print('=' * 50);
    
    final results = <Map<String, dynamic>>[];
    
    // Test 1: Network connectivity
    results.add(await testNetworkConnectivity());
    
    // Test 2: WebRTC ports
    results.add(await testWebRTCConnectivity());
    
    // Test 3: SFU latency
    results.add(await testSFULatency());
    
    // Test 4: API
    results.add(await testApiConnection());
    
    // Test 5: Check test room exists
    results.add(await testRoomExists());
    
    print('\n' + '=' * 50);
    print('SUMMARY');
    print('=' * 50);
    
    int passed = 0;
    for (final result in results) {
      final status = result['success'] == true ? '✓ PASS' : '✗ FAIL';
      print('$status: ${result['test']} - ${result['message']}');
      if (result['success'] == true) passed++;
      
      // Показываем рекомендации если есть
      if (result['recommendation'] != null) {
        print('  → ${result['recommendation']}');
      }
    }
    
    print('=' * 50);
    print('Total: $passed/${results.length} tests passed');
    
    if (passed < results.length) {
      print('\nРЕКОМЕНДАЦИИ:');
      final info = getDiagnosticInfo();
      for (final rec in info['recommendations'] as List) {
        print('• $rec');
      }
    }
    
    print('=' * 50 + '\n');
    
    return results;
  }
}

// Для запуска из консоли Flutter
void main() async {
  await DailyConnectionTest.runAllTests();
}
