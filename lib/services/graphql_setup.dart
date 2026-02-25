import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utility.dart';

class MyAppAuthLib {
  late String url;
  String? consumerKey;
  String? consumerSecret;
  bool? isHttps;
  
  // Timeout and retry configuration
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  MyAppAuthLib(this.url) {
    if (url.startsWith("https")) {
      isHttps = true;
    } else {
      printLog('WEBSITE SHOULD USE SSL');
    }
  }

  // Future<String> getCookie() async {
  //   Map<String, dynamic> cookie = await Requests.getStoredCookies(Requests.getHostname(url));
  //   try {
  //     return cookie.keys.first + "=" + cookie.values.first;
  //   } catch (e) {
  //     print(e);
  //     return '';
  //   }
  // }

  Future<GraphQLClient> noauthClient() async {
    print('$url/graphql');
    
    // Create HTTP client with longer timeout
    final httpClient = http.Client();
    
    final httpLink = HttpLink(
      '$url/graphql',
      httpClient: httpClient,
    );
    Link link = httpLink;
    print(link.toString());
    GraphQLClient graphqlClient = GraphQLClient(
      queryRequestTimeout: defaultTimeout,
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: link,
    );
    return graphqlClient;
  }

  Future<GraphQLClient> authClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    Map<String, String> headers = {};
    if (authToken != null && authToken != '') {
      headers = {
        'Authorization': 'Bearer $authToken',
      };
    }
    
    // Create HTTP client with longer timeout
    final httpClient = http.Client();
    
    final httpLink = HttpLink(
      '$url/graphql',
      defaultHeaders: headers,
      httpClient: httpClient,
    );
    Link link = httpLink;

    GraphQLClient graphqlClient = GraphQLClient(
      queryRequestTimeout: defaultTimeout,
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: link,
    );
    return graphqlClient;
  }
  
  /// Helper method to execute a query with retry logic
  Future<QueryResult> executeQueryWithRetry({
    required QueryOptions options,
    bool authenticated = false,
  }) async {
    int attempt = 0;
    Exception? lastException;
    
    while (attempt < maxRetries) {
      try {
        final client = authenticated 
            ? await authClient() 
            : await noauthClient();
        
        // Use timeout wrapper
        return await client.query(options).timeout(defaultTimeout);
      } on TimeoutException {
        attempt++;
        lastException = Exception('Request timeout (attempt $attempt/$maxRetries)');
        printLog('GraphQL request timeout, attempt $attempt/$maxRetries');
        
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay * attempt); // Exponential backoff
        }
      } on ServerException catch (e) {
        attempt++;
        lastException = e;
        printLog('GraphQL server error: ${e.originalException}, attempt $attempt/$maxRetries');
        
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay * attempt);
        }
      } catch (e) {
        attempt++;
        lastException = Exception('GraphQL request failed: $e');
        printLog('GraphQL request error: $e, attempt $attempt/$maxRetries');
        
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay * attempt);
        }
      }
    }
    
    // After all retries failed, throw the last exception
    throw lastException ?? Exception('Max retries exceeded for GraphQL request');
  }
}
