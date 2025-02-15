import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/common/button_child.dart';
import 'package:transfer/provider/nid_verification_provider.dart';
import 'package:transfer/utils/toast.dart';

class NidVerificationScreen extends StatefulWidget {
  const NidVerificationScreen({super.key});

  @override
  State<NidVerificationScreen> createState() => _NidVerificationScreenState();
}

class _NidVerificationScreenState extends State<NidVerificationScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final nidVerificationProvider =
        Provider.of<NidVerificationProvider>(context);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("NID Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NID Card (Need to verify)",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Update Your NID card, Only JPG PNG JPEG allowed.",
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "NID Front Part",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: nidVerificationProvider.frontPartImage != null
                        ? Image.file(
                            nidVerificationProvider.frontPartImage!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            nidVerificationProvider.selectFrontPartImage();
                          },
                          child: const Text("Choose File"),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (nidVerificationProvider.frontPartImage != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                nidVerificationProvider.fileName(
                                    nidVerificationProvider.frontPartImage!),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                nidVerificationProvider.clearFrontPartImage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.cancel_outlined),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // back part
            const SizedBox(
              height: 16,
            ),
            Text(
              "NID Back Part",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: nidVerificationProvider.backPartImage != null
                        ? Image.file(
                            nidVerificationProvider.backPartImage!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            nidVerificationProvider.selectBackPartImage();
                          },
                          child: const Text("Choose File"),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (nidVerificationProvider.backPartImage != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                nidVerificationProvider.fileName(
                                    nidVerificationProvider.backPartImage!),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                nidVerificationProvider.clearBackPartImage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.cancel_outlined),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),
            Text(
              "Own Image",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: nidVerificationProvider.ownImage != null
                        ? Image.file(
                      nidVerificationProvider.ownImage!,
                      fit: BoxFit.cover,
                    )
                        : const SizedBox(),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            nidVerificationProvider.selectOwnImage();
                          },
                          child: const Text("Choose File"),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (nidVerificationProvider.ownImage != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                nidVerificationProvider.fileName(
                                    nidVerificationProvider.ownImage!),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                nidVerificationProvider.clearOwnImage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.cancel_outlined),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () async {
                  if (nidVerificationProvider.frontPartImage == null) {
                    toast(
                        message: "Select NID front part photo", isError: true);
                    return;
                  }
                  if (nidVerificationProvider.backPartImage == null) {
                    toast(message: "Select NID back part photo", isError: true);
                    return;
                  }

                  if (nidVerificationProvider.ownImage == null) {
                    toast(message: "Select your own photo", isError: true);
                    return;
                  }

                  setState(() {
                    _loading = true;
                  });
                  var response = await nidVerificationProvider.uploadNid();
                  log(response?.statusCode.toString() ?? "");
                  log(response?.body.toString() ?? "");
                  setState(() {
                    _loading = false;
                  });
                  if (response?.statusCode == 200) {
                    nidVerificationProvider.clearFrontPartImage();
                    nidVerificationProvider.clearBackPartImage();
                    toast(message: "NID uploaded successfully.");
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    toast(message: "NID upload failed", isError: true);
                  }
                },
                child: ButtonChild(
                  text: "Upload",
                  loading: _loading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
