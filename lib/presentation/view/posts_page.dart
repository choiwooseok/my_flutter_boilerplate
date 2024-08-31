import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/posts_page_vm.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    final PostsPageVM vm = context.watch<PostsPageVM>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: vm.posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              vm.posts[index].title,
              style: const TextStyle(fontSize: 20),
            ),
            title: Text(
              '${vm.posts[index].body}\n${DateFormat('yyyy-MM-dd hh:mm:ss').format(
                DateTime.fromMillisecondsSinceEpoch(vm.posts[index].id),
              )}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async => await vm.delete(vm.posts[index].id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String title = '';
              String body = '';

              return AlertDialog(
                title: const Text('Add Post'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      onChanged: (value) => title = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Body'),
                      onChanged: (value) => body = value,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      vm.add(title, body);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
