import 'dart:math' as math;

import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LegalInformationScreen extends StatefulWidget {
  const LegalInformationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new LegalInformationState();
}

class LegalInformationState extends State<LegalInformationScreen> {
  List<bool> _expansionStates = [];
  List<Map<String, dynamic>> _legalInfos = [];
  bool _isLoading = true;
  String? _error;

  Widget _buildExpansionTile({
    required String title,
    required String content,
    required int index,
  }) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _expansionStates[index] = expanded;
        });
      },
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      trailing: Transform.rotate(
        angle: _expansionStates[index] ? math.pi / 2 : 0,
        child: Icon(
          Icons.arrow_forward_ios,
          color: _expansionStates[index] ? Colors.black : Colors.grey,
          size: 22,
        ),
      ),
      title: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
          borderRadius: BorderRadius.only(
      topLeft: Radius.circular(22), // Скругление верхнего левого угла
      topRight: Radius.circular(22), // Скругление верхнего правого угла
    ),
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
                icon: const Icon(
                  Icons.description,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: null,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        ListTile(
          title: Text(content),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadLegalInfos();
  }

  Future<void> _loadLegalInfos() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final legalInfos = await fetchLegalInfos();
      
      setState(() {
        _legalInfos = legalInfos;
        _expansionStates = List<bool>.filled(legalInfos.length, false);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Не удалось загрузить юридическую информацию: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          ...topBack(
            text: "Юридическая информация",
            context: context,
            height: 0,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: _buildContent(),
            ),
          ),
          Container(height: getVerticalSize(100))
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadLegalInfos,
              child: Text('Попробовать снова'),
            ),
          ],
        ),
      );
    }

    if (_legalInfos.isEmpty) {
      return Center(
        child: Text('Юридическая информация не найдена'),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        ..._legalInfos.asMap().entries.map((entry) {
          final index = entry.key;
          final legalInfo = entry.value;
          return _buildExpansionTile(
            title: legalInfo['title'] ?? 'Без названия',
            content: legalInfo['content'] ?? 'Содержание не указано',
            index: index,
          );
        }).toList(),
      ],
    );
  }
}
