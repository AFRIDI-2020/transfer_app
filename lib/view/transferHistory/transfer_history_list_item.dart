import 'package:flutter/material.dart';
import 'package:transfer/utils/extensions/transaction_status_extension.dart';

import '../../models/transaction_history_item_model.dart';

class TransferHistoryListItem extends StatelessWidget {
  final TransactionHistoryItemModel transactionHistoryItemModel;
  final VoidCallback onTap;

  const TransferHistoryListItem(
      {super.key, required this.transactionHistoryItemModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sender",
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          "${transactionHistoryItemModel.sender?.method ?? ""} (${transactionHistoryItemModel.senderNumber ?? ""})",
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Receiver",
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          "${transactionHistoryItemModel.receiver?.method ?? ""} (${transactionHistoryItemModel.receiverNumber ?? ""})",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    (transactionHistoryItemModel.status ?? "4")
                        .transactionStatus(),
                    style: theme.textTheme.titleLarge?.copyWith(
                        color: (transactionHistoryItemModel.status ?? "4")
                            .transactionStatusColor()),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "৳",
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${transactionHistoryItemModel.netTaka} (${transactionHistoryItemModel.taka})",
                        style: theme.textTheme.titleLarge,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
