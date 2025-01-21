import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/page_controll_provider.dart';
import 'package:transfer/view/addTransaction/add_transaction_screen.dart';
import 'package:transfer/view/profile/profile_screen.dart';
import 'package:transfer/view/transferHistory/transfer_history.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    const TransferHistory(),
    const AddTransactionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageControlProvider = Provider.of<PageControllerProvider>(context);
    return Scaffold(
      body: _pages[pageControlProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: pageControlProvider.currentIndex,
        onTap: (index) {
          pageControlProvider.setCurrentIndex(index);
        },
      ),
    );
  }
}
