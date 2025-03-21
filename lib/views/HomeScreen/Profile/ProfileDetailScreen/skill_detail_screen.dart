import 'package:astrowaypartner/constants/colorConst.dart';
import 'package:astrowaypartner/controllers/Authentication/signup_controller.dart';
import 'package:astrowaypartner/widgets/app_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:astrowaypartner/utils/global.dart' as global;
import 'package:get/get.dart';

import '../../../../utils/config.dart';

class SkillDetailScreen extends StatelessWidget {
  SkillDetailScreen({super.key});
  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyCustomAppBar(
          height: 80,
          backgroundColor: COLORS().primaryColor,
          title: const Text("Skill Details").tr(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: global.user.imagePath != null &&
                          global.user.imagePath!.isNotEmpty
                      ? signupController
                              .astrologerList[0]!.imagePath!.isNotEmpty
                          ? Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "$imgBaseurl${signupController.astrologerList[0]!.imagePath}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "$imgBaseurl${global.user.imagePath}"),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            )
                      : Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: COLORS().primaryColor),
                          child: CircleAvatar(
                            backgroundColor: COLORS().primaryColor,
                            radius: 45,
                            backgroundImage: const AssetImage(
                              "assets/images/no_customer_image.png",
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Gender",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.gender != null && global.user.gender != ''
                          ? '${global.user.gender}'
                          : "",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Date of Birth",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.birthDate != null
                          ? DateFormat('dd-MM-yyyy').format(
                              DateTime.parse(global.user.birthDate.toString()))
                          : "",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Astrologer category",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        global.user.astrologerCategoryId!.isNotEmpty
                            ? global.user.astrologerCategoryId!
                                .map((e) => e.name)
                                .toList()
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                            : "",
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Primary Skills",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        global.user.primarySkillId!.isNotEmpty
                            ? global.user.primarySkillId!
                                .map((e) => e.name)
                                .toList()
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                            : "",
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "All Skills",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        global.user.allSkillId!.isNotEmpty
                            ? global.user.allSkillId!
                                .map((e) => e.name)
                                .toList()
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                            : "",
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Language",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        global.user.languageId!.isNotEmpty
                            ? global.user.languageId!
                                .map((e) => e.name)
                                .toList()
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                            : "",
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Your charges (per minute)",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.charges != null && global.user.charges != 0
                          ? '${global.getSystemFlagValue(global.systemFlagNameList.currency)} '
                              '${global.user.charges}'
                          : "${global.getSystemFlagValue(global.systemFlagNameList.currency)} 0",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Video charges",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.videoCallRate != null &&
                              global.user.videoCallRate != 0
                          ? '${global.getSystemFlagValue(global.systemFlagNameList.currency)} '
                              '${global.user.videoCallRate}'
                          : "${global.getSystemFlagValue(global.systemFlagNameList.currency)} 0",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Report charges",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.reportRate != null &&
                              global.user.reportRate != 0
                          ? '${global.getSystemFlagValue(global.systemFlagNameList.currency)} '
                              '${global.user.reportRate}'
                          : "${global.getSystemFlagValue(global.systemFlagNameList.currency)} 0",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Experience In Years",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.expirenceInYear != null &&
                              global.user.expirenceInYear != 0
                          ? '${global.user.expirenceInYear}'
                          : "0",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "How many hours you can contribute daily?",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.dailyContributionHours != null &&
                              global.user.dailyContributionHours != 0
                          ? '${global.user.dailyContributionHours}'
                          : "0",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    enabled: true,
                    tileColor: Colors.white,
                    title: Text(
                      "Where did you hear about Us?",
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ).tr(),
                    trailing: Text(
                      global.user.hearAboutAstroGuru != null &&
                              global.user.hearAboutAstroGuru != ''
                          ? '${global.user.hearAboutAstroGuru}'
                          : "Youtube",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
                global.user.otherPlatformName != null &&
                        global.user.otherPlatformName != ''
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          enabled: true,
                          tileColor: Colors.white,
                          title: Text(
                            "Name Of Other Platform?",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            global.user.otherPlatformName != null &&
                                    global.user.otherPlatformName != ''
                                ? '${global.user.otherPlatformName}'
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      )
                    : const SizedBox(),
                global.user.otherPlatformMonthlyEarning != null &&
                        global.user.otherPlatformMonthlyEarning != ''
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          enabled: true,
                          tileColor: Colors.white,
                          title: Text(
                            "Monthly Earning From Other Platform?",
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ).tr(),
                          trailing: Text(
                            global.user.otherPlatformMonthlyEarning != null &&
                                    global.user.otherPlatformMonthlyEarning !=
                                        ''
                                ? '${global.user.otherPlatformMonthlyEarning}'
                                : "",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
