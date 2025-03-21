// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:astrowaypartner/constants/colorConst.dart';
import 'package:astrowaypartner/constants/messageConst.dart';
import 'package:astrowaypartner/controllers/Authentication/signup_controller.dart';
import 'package:astrowaypartner/controllers/report_detail_controller.dart';
import 'package:astrowaypartner/models/report_model.dart';
import 'package:astrowaypartner/views/HomeScreen/Report_Module/view_report_pdf_scree.dart';
import 'package:astrowaypartner/widgets/app_bar_widget.dart';
import 'package:astrowaypartner/widgets/common_padding_2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:astrowaypartner/utils/global.dart' as global;

import '../../../utils/config.dart';

class ReportDetailScreen extends StatelessWidget {
  final ReportModel? report;

  int? flagId; //1 for Request Screen & 2 For History Screen
  ReportDetailScreen({super.key, required this.flagId, this.report});
  final ReportDetailController reportDetailController =
      Get.find<ReportDetailController>();
  SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ReportDetailController>(
          init: reportDetailController,
          builder: (reportDetailController) {
            return Scaffold(
              appBar: MyCustomAppBar(
                height: 80,
                backgroundColor: COLORS().primaryColor,
                title: const Text("Report Detail's").tr(),
              ),
              body: CommonPadding2(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      report?.profile != null && report!.profile != ''
                          ? Container(
                              height: 150,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "$imgBaseurl${report!.profile}"),
                                ),
                              ),
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/no_customer_image.png"),
                                ),
                              ),
                            ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Report Type",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: SizedBox(
                            width: 190,
                            child: Text(
                              report?.reportType != null &&
                                      report!.reportType!.isNotEmpty
                                  ? '${report?.reportType}'
                                  : '',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "First Name",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: SizedBox(
                            width: 190,
                            child: Text(
                              report?.firstName != null &&
                                      report!.firstName!.isNotEmpty
                                  ? '${report?.firstName}'
                                  : 'User',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Last Name",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: SizedBox(
                            width: 190,
                            child: Text(
                              report?.lastName != null
                                  ? '${report!.lastName}'
                                  : "",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Phone Number",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            report?.contactNo != null
                                ? '${report!.contactNo}'
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Gender",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            report?.gender != null ? '${report!.gender}' : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Date of Birth",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            report?.birthDate != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(report!.birthDate!)
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Time of Birth",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            report?.birthTime != null
                                ? '${report!.birthTime}'
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Place of Birth",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: SizedBox(
                            width: 190,
                            child: Text(
                              report?.birthPlace != null
                                  ? '${report!.birthPlace}'
                                  : "",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      report!.occupation != null && report!.occupation != ""
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: ListTile(
                                title: Text(
                                  "Occupation",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .displaySmall,
                                ).tr(),
                                trailing: SizedBox(
                                  width: 190,
                                  child: Text(
                                    report?.occupation != null
                                        ? '${report!.occupation}'
                                        : "",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            "Marital Status",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            report?.maritalStatus != null
                                ? '${report!.maritalStatus}'
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                      report != null
                          ? Column(
                              children: [
                                report!.partnerName != null &&
                                        report!.partnerName != ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: ListTile(
                                          title: Text(
                                            "Partner name",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displaySmall,
                                          ).tr(),
                                          trailing: SizedBox(
                                            width: 190,
                                            child: Text(
                                              report?.partnerName != null
                                                  ? '${report!.partnerName}'
                                                  : "",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                report?.partnerBirthDate != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: ListTile(
                                          title: Text(
                                            "Partner Date of Birth",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displaySmall,
                                          ).tr(),
                                          trailing: Text(
                                            report?.partnerBirthDate != null
                                                ? DateFormat('dd-MM-yyyy')
                                                    .format(report!
                                                        .partnerBirthDate!)
                                                : "",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                report?.partnerBirthTime != null &&
                                        report?.partnerBirthTime != ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: ListTile(
                                          title: Text(
                                            "Partner Time of Birth",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displaySmall,
                                          ).tr(),
                                          trailing: Text(
                                            report?.partnerBirthTime != null
                                                ? '${report!.partnerBirthTime}'
                                                : "",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                report?.partnerBirthPlace != null &&
                                        report?.partnerBirthPlace != ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: ListTile(
                                          title: Text(
                                            "Partner Place of Birth",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displaySmall,
                                          ).tr(),
                                          trailing: SizedBox(
                                            width: 190,
                                            child: Text(
                                              report?.partnerBirthPlace != null
                                                  ? '${report!.partnerBirthPlace}'
                                                  : "",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ExpansionTile(
                          childrenPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          title: Text(
                            "Comments",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                report?.comments != null
                                    ? '${report?.comments}'
                                    : 'I want my full 2022 Detailed Yearly Report',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: flagId == 1
                    ? TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: COLORS().primaryColor,
                          maximumSize:
                              Size(MediaQuery.of(context).size.width, 100),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 48),
                        ),
                        onPressed: () {
                          Get.dialog(uploadPDFDialog(context));
                        },
                        child: const Text(
                          MessageConstants.UPLOAD_PDF,
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ).tr(),
                      )
                    : TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: COLORS().primaryColor,
                          maximumSize:
                              Size(MediaQuery.of(context).size.width, 100),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 48),
                        ),
                        onPressed: () {
                          Get.to(() => ViewReportPdfScreen());
                        },
                        child: const Text(
                          MessageConstants.VIEW_PDF,
                          style: TextStyle(color: Colors.black),
                        ).tr(),
                      ),
              ),
            );
          }),
    );
  }

  Widget uploadPDFDialog(BuildContext context) {
    return GetBuilder<ReportDetailController>(
      init: reportDetailController,
      builder: (reportDetailController) {
        return AlertDialog(
          title: Center(
            child: const Text("Select PDF").tr(),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "PDF",
                    style: Theme.of(context).primaryTextTheme.displaySmall,
                    children: const <TextSpan>[
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: DottedBorder(
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: reportDetailController.path == "" ||
                              reportDetailController.path == null
                          ? IconButton(
                              onPressed: () async {
                                reportDetailController.selectPDF();
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.file_copy,
                                  size: 55,
                                  color: Color(0xFF8A8D9F),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          // OpenFilex.open(
                                          //     reportDetailController.path!);
                                          final bytes =
                                              File(reportDetailController.path!)
                                                  .readAsBytesSync();
                                          String file64 = base64Encode(bytes);
                                          print(file64);
                                        },
                                        child: const Text("View").tr(),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Share.shareXFiles([
                                            XFile(reportDetailController.path!)
                                          ]);
                                        },
                                        child: const Text("Share").tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          reportDetailController.path = "";
                          reportDetailController.update();
                          Get.back();
                        },
                        child: const Text(MessageConstants.CLEAR).tr(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (reportDetailController.path == null) {
                            global.showToast(
                                message: tr('Please select file first!'));
                          } else {
                            reportDetailController.reoprtId = report!.id;
                            reportDetailController
                                .reportSent(reportDetailController.reoprtId!);
                            Get.back();
                          }
                        },
                        child: const Text(
                          MessageConstants.UPLOAD_PDF,
                          textAlign: TextAlign.center,
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
