import 'package:flutter/material.dart';
import 'package:my_boilerplate/presentation/view/posts_page.dart';
import 'package:provider/provider.dart';

import '../view_model/nav_vm.dart';
import 'users_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  late List<Widget> pages = [];

  @override
  void initState() {
    super.initState();

    pages = [
      const PostsPage(),
      const UsersPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final NavVM vm = context.watch<NavVM>();
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: vm.selectedIndex,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_search),
              label: 'Users',
            ),
          ],
          onTap: (value) => setState(() => vm.setIndex(value)),
        ),
      ),
      body: pages[vm.selectedIndex],
    );
  }
}
