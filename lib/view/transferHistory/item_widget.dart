import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final String subValue;
  final bool? showInRow;
  final TextStyle? valueStyle;
  final bool showDivider;

  const ItemWidget({super.key, required this.title, required this.value, required this.subValue, this.showInRow = false, this.valueStyle, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 15,),
              if(showInRow == false)
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      subValue,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if(showInRow == true)
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          style: valueStyle ?? theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      Text(
                        subValue,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
            ],
          ),
         if(showDivider)
         ...[
           const SizedBox(height: 8,),
           Divider(
             thickness: 0.5,
             height: 0.5,
             color: Colors.grey.shade300,
           ),
         ]

        ],
      ),
    );
  }
}
