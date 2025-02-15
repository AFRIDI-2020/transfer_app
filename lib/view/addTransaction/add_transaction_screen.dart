import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transfer/common/button_child.dart';
import 'package:transfer/models/payment_request.dart';
import 'package:transfer/models/receiver.dart';
import 'package:transfer/provider/create_transaction_provider.dart';
import 'package:transfer/provider/page_controll_provider.dart';
import 'package:transfer/provider/transaction_history_provider.dart';
import 'package:transfer/utils/app_colors.dart';
import 'package:transfer/utils/extensions/verificaiton_check_extension.dart';
import 'package:transfer/utils/select_date.dart';
import 'package:transfer/utils/select_time.dart';
import 'package:transfer/utils/toast.dart';
import 'package:transfer/view/addTransaction/widgets/custom_input_field.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _loading = false;
  bool _btnLoading = false;
  final _sendingNumberController = TextEditingController();
  final _receivingNumberController = TextEditingController();
  final _sendingAmountController = TextEditingController();
  final _transactionIdController = TextEditingController();
  final _transactionDateTimeController = TextEditingController();
  final _formKay = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getTransactionCreateInfo();
      },
    );

    super.initState();
  }

  Future<void> _getTransactionCreateInfo() async {
    final createTransactionProvider =
        Provider.of<CreateTransactionProvider>(context, listen: false);

    setState(() {
      _loading = true;
    });
    createTransactionProvider.clearCreateTransactionData();
    await createTransactionProvider.getTransactionCreateInfo();
    setState(() {
      _loading = false;
    });
    if (mounted) {
      if (createTransactionProvider.didUserRequiredVerification()) {
        _showVerificationDialog(createTransactionProvider);
      }
    }
  }

  void _showVerificationDialog(
      CreateTransactionProvider createTransactionProvider) {
    final theme = Theme.of(context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text(
                (createTransactionProvider.transactionCreateInfo?.verification?.status ?? 0).verificationText(),
              ),
              content: Text(
                createTransactionProvider.transactionCreateInfo?.verification?.message ?? "fdf",
                style: theme.textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final pageControlProvider = Provider.of<PageControllerProvider>(context, listen: false);
                    Navigator.pop(context);
                    pageControlProvider.setCurrentIndex(2);
                  },
                  child: Text("Go to Profile",style: theme.textTheme.titleMedium?.copyWith(color: AppColors.primaryColor),),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createTransactionProvider =
        Provider.of<CreateTransactionProvider>(context);
    final transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

    final pageControllerProvider = Provider.of<PageControllerProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Make a Transaction"),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKay,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1* (Required)",
                        style:
                            theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Please Select Sending Method and Number",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Sender Method",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.grey,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: DropdownButtonHideUnderline(
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton<Receiver>(
                              value: createTransactionProvider
                                  .selectedSendingMethod,
                              hint: const Text(
                                "Select a Method",
                              ),
                              isDense: true,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryColor,
                              ),
                              items: createTransactionProvider
                                  .transactionCreateInfo?.sender
                                  ?.map((Receiver? method) {
                                return DropdownMenuItem<Receiver>(
                                  value: method,
                                  child: Text(
                                    method?.method ?? "",
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                createTransactionProvider
                                    .selectSendingMethod(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      if (createTransactionProvider.selectedSendingMethod !=
                          null) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sending Number",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomInputField(
                          controller: _sendingNumberController,
                          keyboardType: TextInputType.phone,
                          hint:
                              "Enter your ${createTransactionProvider.selectedSendingMethod?.method ?? ""} Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your ${createTransactionProvider.selectedSendingMethod?.method ?? ""} Number";
                            }

                            if (value.length != 11) {
                              return "The sender number must be of 11 digits";
                            }

                            return null;
                          },
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Step 2* (Required)",
                        style:
                            theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Please Select Receiving Method and Number",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Receiving Method",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.grey,
                            )),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: DropdownButtonHideUnderline(
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton<Receiver>(
                              value: createTransactionProvider
                                  .selectedReceivingMethod,
                              hint: const Text(
                                "Select a Method",
                              ),
                              isDense: true,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryColor,
                              ),
                              items: createTransactionProvider
                                  .transactionCreateInfo?.receiver
                                  ?.map((Receiver? method) {
                                return DropdownMenuItem<Receiver>(
                                  value: method,
                                  child: Text(
                                    method?.method ?? "",
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                createTransactionProvider
                                    .selectReceivingMethod(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      if (createTransactionProvider.selectedReceivingMethod !=
                          null) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Receiving Number",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomInputField(
                          controller: _receivingNumberController,
                          keyboardType: TextInputType.phone,
                          hint:
                              "Enter your ${createTransactionProvider.selectedReceivingMethod?.method ?? ""} Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your ${createTransactionProvider.selectedReceivingMethod?.method ?? ""} Number";
                            }

                            if (value.length != 11) {
                              return "The receiver number must be of 11 digits";
                            }

                            return null;
                          },
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Step 3* (Required)",
                        style:
                            theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Amount and Info",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please Enter Your Amount",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomInputField(
                        controller: _sendingAmountController,
                        hint: "Enter amount",
                        onChanged: (p0) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter amount";
                          }

                          if ((double.tryParse(value) ?? 0) < 500) {
                            return "You have to transfer at least 500 TK";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodyMedium,
                          children: [
                            const TextSpan(text: "Your sender method is "),
                            TextSpan(
                              text: createTransactionProvider
                                      .selectedSendingMethod?.method ??
                                  "",
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                            const TextSpan(
                              text: " using option ",
                            ),
                            TextSpan(
                              text: createTransactionProvider
                                      .selectedSendingMethod?.sendingType ??
                                  "",
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                            const TextSpan(
                              text: " and the charge is ",
                            ),
                            TextSpan(
                              text:
                                  "${createTransactionProvider.selectedSendingMethod?.amount ?? '0'} ${createTransactionProvider.selectedSendingMethod?.type == '1' ? "percent" : ""}",
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                            const TextSpan(
                              text:
                                  " per 1000 taka. The amount you will receive ",
                            ),
                            TextSpan(
                              text:
                                  " now is ${_receivingAmount(createTransactionProvider)} taka",
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (createTransactionProvider.selectedSendingMethod !=
                          null) ...[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: theme.textTheme.bodyMedium,
                                  children: [
                                    const TextSpan(text: "Please "),
                                    TextSpan(
                                      text: createTransactionProvider
                                              .selectedSendingMethod
                                              ?.sendingType ??
                                          "",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                    const TextSpan(
                                      text: " to ",
                                    ),
                                    TextSpan(
                                      text:
                                          "${createTransactionProvider.selectedSendingMethod?.sendingNumber ?? ""} (${createTransactionProvider.selectedSendingMethod?.method ?? ""})",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: createTransactionProvider
                                              .selectedSendingMethod
                                              ?.sendingNumber ??
                                          ""));
                                  toast(message: "Phone number copied");
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.copy,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Step 4

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Step 4 (Optional)",
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Transaction Details",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Enter ${createTransactionProvider.selectedSendingMethod?.method ?? ""} Transaction ID",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomInputField(
                          controller: _transactionIdController,
                          hint: "Transaction ID",
                          onChanged: (p0) {
                            setState(() {});
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Enter ${createTransactionProvider.selectedSendingMethod?.method ?? ""} Transaction Date Time",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await selectDate(context);
                            if (date != null) {
                              createTransactionProvider
                                  .selectTransactionDate(date);
                              if (context.mounted) {
                                TimeOfDay? time = await selectTime(context);
                                if (time != null) {
                                  createTransactionProvider
                                      .selectTransactionTime(time);
                                }
                              }
                            }

                            if (createTransactionProvider.transactionDate !=
                                    null &&
                                createTransactionProvider.transactionTime !=
                                    null) {
                              DateTime dateTime = DateTime(
                                createTransactionProvider.transactionDate!.year,
                                createTransactionProvider
                                    .transactionDate!.month,
                                createTransactionProvider.transactionDate!.day,
                                createTransactionProvider.transactionTime!.hour,
                                createTransactionProvider
                                    .transactionTime!.minute,
                              );

                              _transactionDateTimeController.text =
                                  DateFormat("dd/MM/yyyy hh:mm a")
                                      .format(dateTime);
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: CustomInputField(
                            controller: _transactionDateTimeController,
                            hint: "dd/MM/yyyy hh:mm a",
                            enabled: false,
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (createTransactionProvider
                                    .selectedSendingMethod ==
                                null) {
                              toast(
                                  message: "Select sending method",
                                  isError: true);
                              return;
                            }

                            if (createTransactionProvider
                                    .selectedReceivingMethod ==
                                null) {
                              toast(
                                  message: "Select receiving method",
                                  isError: true);
                              return;
                            }

                            if (_formKay.currentState!.validate()) {
                              PaymentRequest paymentRequest = PaymentRequest(
                                amount: (double.tryParse(
                                            _sendingAmountController.text) ??
                                        0.0)
                                    .toString(),
                                sender1: (createTransactionProvider
                                            .selectedSendingMethod?.id ??
                                        0)
                                    .toString(),
                                senderNumber: _sendingNumberController.text,
                                receiver1: (createTransactionProvider
                                            .selectedReceivingMethod?.id ??
                                        0)
                                    .toString(),
                                receiverNumber: _receivingNumberController.text,
                                net: (double.tryParse(_receivingAmount(
                                            createTransactionProvider)) ??
                                        0)
                                    .toString(),
                                date: _transactionDateTimeController.text,
                                trns: _transactionIdController.text,
                              );

                              setState(() {
                                _btnLoading = true;
                              });
                              var response = await createTransactionProvider
                                  .createTransaction(
                                      paymentRequest: paymentRequest);

                              if (response?.statusCode == 200) {
                                await transactionHistoryProvider
                                    .getTransactionHistory();
                                pageControllerProvider.setCurrentIndex(0);
                                setState(() {
                                  _btnLoading = false;
                                });
                                toast(
                                    message:
                                        "Your Transaction is in process. Please wait");
                              } else {
                                setState(() {
                                  _btnLoading = false;
                                });
                                toast(
                                    message:
                                        "Something went wrong! Request cannot be sent",
                                    isError: true);
                              }
                            }
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          child: ButtonChild(
                            text: "Submit",
                            loading: _btnLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String _receivingAmount(CreateTransactionProvider createTransactionProvider) {
    if (_sendingAmountController.text.isNotEmpty) {
      double sendingAmount =
          double.tryParse(_sendingAmountController.text) ?? 0;
      if (sendingAmount >= 500) {
        return createTransactionProvider
            .receivingAmount(sendingAmount: sendingAmount)
            .round()
            .toString();
      } else {
        return "";
      }
    } else {
      return "";
    }
  }
}
