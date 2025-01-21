import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/transaction_history_provider.dart';
import 'package:transfer/view/transferHistory/transfer_history_list_item.dart';

class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  bool _loading = false;

  @override
  void initState() {
    getTransactionList();
    super.initState();
  }

  Future<void> getTransactionList() async {
    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context, listen: false);
    setState(() {
      _loading = true;
    });
    await transactionHistoryProvider.getTransactionHistory();
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
                    return TransferHistoryListItem(transactionHistoryItemModel: transactionHistoryProvider.transactionList[index]);
                  },
                ),
    );
  }
}
