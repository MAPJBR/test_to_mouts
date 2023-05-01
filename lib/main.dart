import 'package:books/data/data_drivers/api/api.dart';
import 'package:books/data/services/app_notifier.dart';
import 'package:books/domain/use_cases/favorite.dart';
import 'package:books/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookApi bookApi = BookApi();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNotifier(bookApi: bookApi)),
        ChangeNotifierProvider(create: (_) => FavoritesNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: textTheme),
        home: const MainScreen(),
      ),
    );
  }
}
