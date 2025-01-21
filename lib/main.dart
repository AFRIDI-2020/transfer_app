import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/provider/create_transaction_provider.dart';
import 'package:transfer/provider/page_controll_provider.dart';
import 'package:transfer/provider/transaction_history_provider.dart';
import 'package:transfer/utils/theme.dart';
import 'package:transfer/view/splashScreen/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionHistoryProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CreateTransactionProvider()),
        ChangeNotifierProvider(create: (_) => PageControllerProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        home: const SplashScreen(),
      ),
    );
  }
}


