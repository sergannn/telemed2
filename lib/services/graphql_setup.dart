import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utility.dart';

class MyAppAuthLib {
  late String url;
  String? consumerKey;
  String? consumerSecret;
  bool? isHttps;

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
    final httpLink = HttpLink(
      '$url/graphql',
    );
    Link link = httpLink;
    print(link.toString());
    GraphQLClient graphqlClient = GraphQLClient(
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
    final httpLink = HttpLink(
      '$url/graphql',
      defaultHeaders: headers,
    );
    Link link = httpLink;

    GraphQLClient graphqlClient = GraphQLClient(
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: link,
    );
    return graphqlClient;
  }
}
