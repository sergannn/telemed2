import 'dart:convert';

import 'package:doctorq/services/api_service.dart';
import 'package:flutter/material.dart';

class PatientMedcardViewer extends StatefulWidget {
  final String patientUserId;
  final String? patientName;

  const PatientMedcardViewer({
    super.key,
    required this.patientUserId,
    this.patientName,
  });

  @override
  State<PatientMedcardViewer> createState() => _PatientMedcardViewerState();
}

class _PatientMedcardViewerState extends State<PatientMedcardViewer> {
  late Future<Map<String, dynamic>?> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchPatientMedcard(widget.patientUserId);
  }

  Widget _buildQuestionnaire(dynamic value, {String? label, int depth = 0}) {
    final padding = EdgeInsets.only(left: depth * 12.0, top: 6, bottom: 6);

    if (value is Map) {
      final entries = value.entries.toList();
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null && label.isNotEmpty)
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            ...entries.map(
              (entry) => _buildQuestionnaire(
                entry.value,
                label: entry.key.toString(),
                depth: depth + 1,
              ),
            ),
          ],
        ),
      );
    }

    if (value is List) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null && label.isNotEmpty)
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(value.isEmpty ? '—' : value.join(', ')),
          ],
        ),
      );
    }

    return Padding(
      padding: padding,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.45),
          children: [
            if (label != null && label.isNotEmpty)
              TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            TextSpan(
              text: (value == null || value.toString().trim().isEmpty)
                  ? '—'
                  : value.toString(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patientName?.isNotEmpty == true
              ? 'Медкарта: ${widget.patientName}'
              : 'Медкарта пациента',
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Не удалось загрузить медкарту пациента.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data!;
          final docItems = ((data['document_items'] as List?) ?? const [])
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
          final docs = docItems.isNotEmpty
              ? docItems
              : ((data['document_urls'] as List?)?.cast<String>() ?? const [])
                  .map(
                    (url) => {
                      'url': url,
                      'name': 'Документ',
                      'category': 'Документы',
                    },
                  )
                  .toList();
          final docsCount = docs.length;
          final questionnaireRaw = data['questionnaire_data'] as String?;
          dynamic questionnaire;
          if (questionnaireRaw != null && questionnaireRaw.trim().isNotEmpty) {
            try {
              questionnaire = jsonDecode(questionnaireRaw);
            } catch (_) {
              questionnaire = questionnaireRaw;
            }
          }

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Документы ($docsCount)'),
                    const Tab(text: 'Анкета'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      docs.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  'У пациента пока нет загруженных документов.\nКоличество документов: $docsCount',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                  child: Text(
                                    'Количество документов: $docsCount',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemCount: docs.length,
                                    itemBuilder: (context, index) {
                                      final document = docs[index];
                                      final url = document['url']?.toString() ?? '';
                                      final category =
                                          document['category']?.toString() ??
                                              'Документы';
                                      final name = document['name']?.toString() ??
                                          'Документ';
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Material(
                                          color: Colors.grey.shade50,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => Dialog(
                                                  child: InteractiveViewer(
                                                    child: Image.network(
                                                      url,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Image.network(
                                                    url,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) =>
                                                        Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons
                                                            .broken_image_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 8,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          category,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      questionnaire == null
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  'Анкета пациента ещё не была сохранена на сервере.',
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: _buildQuestionnaire(questionnaire),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
