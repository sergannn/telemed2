import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart'; // Добавляем правильный импорт для WebView
import 'base_tool.dart';
import 'dart:convert';
import 'dart:async';

Future<bool> _isImageAvailable(String imageUrl) async {
  try {
    final response = await http.head(Uri.parse(imageUrl));
    return response.statusCode == 200;
  } catch (e) {
    print('Image check failed: $e');
    return false;
  }
}

class MarketplaceTool extends BaseTool {
  @override
  String get name => 'MarketplaceTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final query = parameters['query'] as String;
    final String toolSummary = '<tool_summary>I have provided a marketplace search interface for the user to search for: $query</tool_summary>';

    return {
      'toolWidget': MarketplaceToolWidget(initialQuery: query),
      'toolSummary': toolSummary,
    };
  }
}

class MarketplaceToolWidget extends StatefulWidget {
  final String initialQuery;

  const MarketplaceToolWidget({Key? key, required this.initialQuery}) : super(key: key);

  @override
  _MarketplaceToolWidgetState createState() => _MarketplaceToolWidgetState();
}

class _MarketplaceToolWidgetState extends State<MarketplaceToolWidget> {
  String _result = '';
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _performSearch(widget.initialQuery);
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _result = 'Searching...';
    });

    const int maxAttempts = 3;
    int attempts = 0;
    List<Map<String, dynamic>> validProducts = [];

    while (attempts < maxAttempts && validProducts.length < 10) {
      try {
        final searchResults = await _marketplaceSearch(query);  // Ожидаем результат поиска
        validProducts = await _filterValidProducts(searchResults);

        if (validProducts.length >= 10) break;
      } catch (e) {
        print('Error occurred during search attempt ${attempts + 1}: $e');
        await Future.delayed(Duration(seconds: 2));
      }
      attempts++;
    }

    setState(() {
      _products = validProducts;
      _result = validProducts.isEmpty ? 'No results found with valid images.' : '';
      print('Search completed with ${validProducts.length} valid products.');
    });
  }

  Future<List<Map<String, dynamic>>> _filterValidProducts(List<Map<String, dynamic>> products) async {
    List<Map<String, dynamic>> validProducts = [];

    for (var product in products) {
      final imageUrl = product['image'];
      if (await _isImageAvailable(imageUrl)) {
        validProducts.add(product);
      }
      if (validProducts.length >= 10) break;
    }

    return validProducts;
  }

  Future<List<Map<String, dynamic>>> _marketplaceSearch(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = Uri.parse('https://shop.mts.ru/search/?TYPE=products&q=$encodedQuery');
    final headers = {
      'GENUI': 'b7dLVU49DnL7lU6A4ivU2EdvRWnZEBzS',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    };

    int retryCount = 0;
    const int maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          final products = _extractProducts(response.body);
          return products;
        } else {
          print('Request to MTS Shop failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error in _marketplaceSearch: $e');
        await Future.delayed(Duration(seconds: 2));
      }
      retryCount++;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _extractProducts(String htmlContent) async {
    final products = <Map<String, dynamic>>[];
    final productCards = RegExp(r'<div id="[^"]*" class="card-product-wrapper[^"]*".*?</div></div></div></div>', dotAll: true)
        .allMatches(htmlContent);

    for (var card in productCards.take(10)) {
      final nameMatch = RegExp(r'aria-label="([^"]*)"').firstMatch(card.group(0)!);
      final urlMatch = RegExp(r'href="(/product/[^"]*)"').firstMatch(card.group(0)!);

      final productUrl = urlMatch != null ? 'https://shop.mts.ru${urlMatch.group(1)}' : '';
      final details = await _getProductDetails(productUrl); // Добавляем await для асинхронного получения данных

      products.add({
        'name': nameMatch?.group(1) ?? 'Название не найдено',
        'link': productUrl,
        'image': details['image_url'], // Теперь это будет работать после получения данных
        'price': details['price'],     // Теперь это будет работать после получения данных
      });
    }

    return products;
  }


  Future<Map<String, dynamic>> _getProductDetails(String url) async {
    final headers = {
      'GENUI': 'b7dLVU49DnL7lU6A4ivU2EdvRWnZEBzS',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);  // Асинхронно получаем данные
      final htmlContent = response.body;  // Получаем тело ответа как строку

      final priceMatch = RegExp(r'<span class="product-price__current"><span>([^<]*)</span>').firstMatch(htmlContent);
      final imageMatch = RegExp(r'<img[^>]*data-src="([^"]*)"[^>]*itemprop="image"').firstMatch(htmlContent);

      final price = priceMatch != null ? priceMatch.group(1)!.replaceAll('\xa0', ' ').replaceAll('₽', '').trim() : 'Цена не найдена';
      final imageUrl = imageMatch?.group(1) ?? '';

      return {
        'price': price,
        'image_url': imageUrl,
      };
    } catch (e) {
      print('Failed to fetch product details: $e');
      return {
        'price': 'Ошибка получения данных',
        'image_url': '',
      };
    }
  }


  @override
  Widget build(BuildContext context) {
    final validProducts = _products.where((product) {
      try {
        Uri.parse(product['image']);
        return true;
      } catch (e) {
        return false;
      }
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Results:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        _result.isNotEmpty
            ? Text(_result)
            : Container(
                height: 450,
                child: PageView.builder(
                  itemCount: validProducts.length,
                  controller: PageController(viewportFraction: 0.75),
                  itemBuilder: (context, index) {
                    final product = validProducts[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Text('Image not available'));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product['price'],
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _openProductPage(product['link']);
                              },
                              child: const Text('Go to product page'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  void _openProductPage(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: WebViewWidget( // Используем WebViewWidget вместо WebView
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted) // Разрешаем JavaScript
              ..loadRequest(Uri.parse(url)),
          ),
        ),
      ),
    );
  }

}
