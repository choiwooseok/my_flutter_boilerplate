import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'presentation/view_model/nav_vm.dart';
import 'presentation/view_model/posts_page_vm.dart';
import 'presentation/view_model/users_page_vm.dart';
import 'util/config.dart';

void main() {
  Config(kReleaseMode ? 'prod' : 'dev');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PostsPageVM()..fetchPosts()),
      ChangeNotifierProvider(create: (context) => NavVM()),
      ChangeNotifierProvider(create: (context) => UsersPageVM())
    ],
    child: const AppRoot(),
  ));
}
