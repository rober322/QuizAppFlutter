import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      initialRoute: 'welcome',
      routes: getApplicationRoutes(),
      theme: ThemeData.dark(),
    );
  }
}