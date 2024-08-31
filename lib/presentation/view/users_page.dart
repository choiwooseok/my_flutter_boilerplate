import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/users_page_vm.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UsersPageVM>(context, listen: false).clear();
      await Provider.of<UsersPageVM>(context, listen: false).fetch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Users'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer<UsersPageVM>(
              builder: (context, vm, child) {
                if (vm.users.isEmpty) {
                  return const SizedBox.shrink();
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    final isLoadingMore = scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.extentAfter == 0;

                    if (!vm.isLoading && !vm.isLast && isLoadingMore) {
                      vm.fetchMore(context);
                    }
                    return true;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    itemCount:
                        vm.users.length + (vm.isLoading && !vm.isLast ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < vm.users.length) {
                        var user = vm.users[index];
                        return Card(
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.id.toString()),
                          ),
                        );
                      }

                      return const Card(
                        child: ListTile(
                          title: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
