import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../entity/user_entity.dart';

class FetchUsersUseCase {
  Future<List<UserEntity>> fetchAll(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;

    List<UserEntity> users = [];
    int page = 0;
    int size = 2;
    bool hasNext = true;
    while (hasNext) {
      final usersData = await _fetchUsers(client, page, size);
      final contents = usersData['contents'] as List;
      users.addAll(contents.map((user) => UserEntity.fromMap(user)));
      hasNext = usersData['pageInfo']['hasNext'];
      page++;
    }
    return users;
  }

  Future<Map<String, dynamic>> fetch(BuildContext context,
      {required int page, required int size}) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    final usersData = await _fetchUsers(client, page, size);
    final contents = usersData['contents'] as List;
    return {
      'contents': contents.map((user) => UserEntity.fromMap(user)).toList(),
      'hasNext': usersData['pageInfo']['hasNext'],
    };
  }

  Future<Map<String, dynamic>> _fetchUsers(
      GraphQLClient client, int page, int size) async {
    final result = await client.query(QueryOptions(document: gql('''
      query {
        users (page: $page, size: $size) {
          contents {
            id
            name
          }
          pageInfo {
            currentPage
            totalPage
            hasNext
          }
        }
      }
    ''')));
    return result.data!['users'];
  }
}
