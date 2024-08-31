import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../util/config.dart';
import '../../../util/constant.dart';

class GraphApis {
  static final _httpLink = HttpLink(
    'http://${Config.instance.kRestApiBaseURL}/$kGraphQLEndpoint',
    defaultHeaders: {'Content-Type': 'application/json'},
  );

  static ValueNotifier<GraphQLClient> initClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: Link.from([_httpLink]),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
    return client;
  }
}
