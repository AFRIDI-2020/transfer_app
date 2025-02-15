import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/provider/transaction_history_provider.dart';
import 'package:transfer/view/transferHistory/transaction_history_item_details.dart';
import 'package:transfer/view/transferHistory/transfer_history_list_item.dart';

import '../../utils/app_colors.dart';
import '../login/login_screen.dart';

class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  bool _loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTransactionList();
    },);

    super.initState();
  }

  Future<void> getTransactionList() async {
    final transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final theme = Theme.of(context);
    setState(() {
      _loading = true;
    });

    var result = await authProvider.getCurrentUserInfo();
    await transactionHistoryProvider.getTransactionHistory();

    if (result?.statusCode == 401) {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return PopScope(
              canPop: false,
              child: AlertDialog(
                title: const Text("Session Timeout"),
                content: Text(
                  "Please login again!",
                  style: theme.textTheme.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Logout",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer History"),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : transactionHistoryProvider.transactionList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/transfer.png"),
                      Text(
                        "You Have Not Made Any Transfer Yet",
                        style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: transactionHistoryProvider.transactionList.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return TransferHistoryListItem(
                      transactionHistoryItemModel:
                          transactionHistoryProvider.transactionList[index],
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return TransactionHistoryItemDetails(
                                transactionHistoryItemModel:
                                    transactionHistoryProvider
                                        .transactionList[index]);
                          },
                        );
                      },
                    );
                  },
                ),
    );
  }
}
