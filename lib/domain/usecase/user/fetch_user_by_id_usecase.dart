import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../entity/user_entity.dart';

class FetchUserByIdUseCase {
  Future<UserEntity?> execute(
    BuildContext context, {
    required int id,
  }) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    final result = await client.query(QueryOptions(document: gql('''
      query {
        user(id: $id) {
          id
          name
        }
      }
    ''')));
    final user = result.data!['user'];
    return user.isEmpty ? null : UserEntity.fromMap(user);
  }
}
