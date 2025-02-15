import 'package:flutter/material.dart';
import 'package:transfer/utils/extensions/amount_deduction_type_extension.dart';
import 'package:transfer/utils/extensions/transaction_status_extension.dart';
import 'package:transfer/view/transferHistory/item_widget.dart';

import '../../models/transaction_history_item_model.dart';

class TransactionHistoryItemDetails extends StatelessWidget {
  final TransactionHistoryItemModel transactionHistoryItemModel;

  const TransactionHistoryItemDetails(
      {super.key, required this.transactionHistoryItemModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Details",
                  style: theme.textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.cancel_outlined),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.grey.shade300,
            ),
            const SizedBox(
              height: 10,
            ),
            ItemWidget(
              title: "Admin Number",
              value: transactionHistoryItemModel.sendingNumber ?? "",
              subValue: transactionHistoryItemModel.sendingType ?? "",
            ),
            ItemWidget(
              title: "Your Sending Number",
              value: transactionHistoryItemModel.senderNumber ?? "",
              subValue: transactionHistoryItemModel.sender?.method ?? "",
            ),
            ItemWidget(
              title: "Your Receiving Number",
              value: transactionHistoryItemModel.receiverNumber ?? "",
              subValue: transactionHistoryItemModel.receiver?.method ?? "",
            ),
            ItemWidget(
              title: "Per 1000 taka deduction",
              value: transactionHistoryItemModel.amount ?? "",
              subValue: (transactionHistoryItemModel.type ?? "1")
                  .amountDeductionType(),
              showInRow: true,
            ),
            ItemWidget(
              title: "Your Sending Amount",
              value: transactionHistoryItemModel.taka ?? "",
              subValue: "Taka",
              showInRow: true,
            ),
            ItemWidget(
              title: "Your Receiving Amount",
              value: transactionHistoryItemModel.netTaka ?? "",
              subValue: "Taka",
              showInRow: true,
            ),
            ItemWidget(
              title: "Your Transaction ID",
              value: transactionHistoryItemModel.senderTranId ?? "",
              subValue: "",
              showInRow: true,
            ),
            ItemWidget(
              title: "Date & Time",
              value: transactionHistoryItemModel.timeDate ?? "",
              subValue: "",
              showInRow: true,
            ),
            ItemWidget(
              title: "Current Status",
              value: (transactionHistoryItemModel.status ?? "4")
                  .transactionStatus(),
              subValue: "",
              valueStyle: theme.textTheme.titleMedium?.copyWith(
                  color: (transactionHistoryItemModel.status ?? "4")
                      .transactionStatusColor()),
              showInRow: true,
            ),
            ItemWidget(
              title: "Paid At",
              value: transactionHistoryItemModel.paidDate ?? "",
              subValue: "",
              showInRow: true,
            ),
            ItemWidget(
              title: "Narration",
              value: transactionHistoryItemModel.narration ?? "",
              subValue: "",
              showInRow: true,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
