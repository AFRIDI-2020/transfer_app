import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/provider/create_transaction_provider.dart';
import 'package:transfer/provider/nid_verification_provider.dart';
import 'package:transfer/provider/page_controll_provider.dart';
import 'package:transfer/provider/transaction_history_provider.dart';
import 'package:transfer/utils/theme.dart';
import 'package:transfer/view/splashScreen/splash_screen.dart';

void main() async {
  await GetStorage.init("MyPref");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, TransactionHistoryProvider>(
          create: (context) => TransactionHistoryProvider(
            authProvider: context.read<AuthProvider>(),
          ),
          update: (context, value, previous) => previous!,
        ),
        ChangeNotifierProxyProvider<AuthProvider, CreateTransactionProvider>(
          create: (context) => CreateTransactionProvider(
            authProvider: context.read<AuthProvider>(),
          ),
          update: (context, value, previous) => previous!,
        ),
        ChangeNotifierProvider(create: (_) => PageControllerProvider()),
        ChangeNotifierProvider(create: (_) => NidVerificationProvider()),
      ],
      child: MaterialApp(
        title: 'RTransfer',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        home: const SplashScreen(),
      ),
    );
  }
}
