import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/shoe_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vnfwlbuktaedjjgtgeyk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZuZndsYnVrdGFlZGpqZ3RnZXlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2MTM3ODQsImV4cCI6MjA3NjE4OTc4NH0.Jze8y6BF3b5v0kX-weepAWskPttcHe1UsKruPEjky6Q',
  );
  await Hive.initFlutter();
  //Hive.registerAdapter(ShoeAdapter);
  await Hive.openBox<Shoe>('shoeBox');
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ShoeService())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomePage(),
    );
  }
}
