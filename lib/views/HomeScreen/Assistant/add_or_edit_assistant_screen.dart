// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:astrowaypartner/constants/colorConst.dart';
import 'package:astrowaypartner/controllers/AssistantController/add_assistant_controller.dart';
import 'package:astrowaypartner/models/Master%20Table%20Model/assistant/assistant_all_skill_model.dart';
import 'package:astrowaypartner/models/Master%20Table%20Model/assistant/assistant_language_list_model.dart';
import 'package:astrowaypartner/models/Master%20Table%20Model/assistant/assistant_primary_skill_model.dart';
import 'package:astrowaypartner/models/astrologerAssistant_model.dart';
import 'package:astrowaypartner/views/HomeScreen/Assistant/assistant_screen.dart';
import 'package:astrowaypartner/widgets/app_bar_widget.dart';
import 'package:astrowaypartner/widgets/common_drop_down.dart';
import 'package:astrowaypartner/widgets/common_textfield_widget.dart';
import 'package:astrowaypartner/widgets/primary_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:astrowaypartner/utils/global.dart' as global;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../utils/config.dart';
import '../../Authentication/login_screen.dart';

class AddAssistantScreen extends StatelessWidget {
  int? flagId;
  AstrologerAssistantModel? assistantModel;
  AddAssistantScreen({super.key, required this.flagId, this.assistantModel});
  AddAssistantController assistantController =
      Get.find<AddAssistantController>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        assistantController.userFile = null;
        assistantController.profile = '';

        Get.to(() => AssistantScreen());
        return true;
      },
      child: SafeArea(
        child: GetBuilder<AddAssistantController>(
            init: assistantController,
            builder: (assistantController) {
              return Scaffold(
                backgroundColor: COLORS().greyBackgroundColor,
                appBar: MyCustomAppBar(
                  height: 80,
                  title: flagId == 1
                      ? const Text("Add Assistant").tr()
                      : const Text("Edit Assistant").tr(),
                  backgroundColor: COLORS().primaryColor,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Assistant Image
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // ignore: unrelated_type_equality_checks
                            assistantController.userFile != null &&
                                    // ignore: unrelated_type_equality_checks
                                    assistantController.userFile != ''
                                ? Center(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Get.theme.primaryColor,
                                          image: DecorationImage(
                                            image: FileImage(
                                                assistantController.userFile!),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                : assistantModel?.profile != null &&
                                        assistantModel?.profile != ''
                                    ? Center(
                                        child: Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Get.theme.primaryColor,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "$imgBaseurl${assistantModel!.profile}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ))
                                    : Center(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          height: 100,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 70,
                                            color: COLORS().primaryColor,
                                          ),
                                        ),
                                      ),
                            Positioned(
                              bottom: -20,
                              width: MediaQuery.of(context).size.width + 20,
                              child: IconButton(
                                onPressed: () async {
                                  Get.bottomSheet(
                                      selectImageBottomSheetWidget(context),
                                      backgroundColor: Colors.white);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.penToSquare,
                                  color: COLORS().blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Name
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CommonTextFieldWidget(
                            hintText: tr("Name"),
                            textEditingController: assistantController.cName,
                            focusNode: assistantController.fName,
                            textCapitalization: TextCapitalization.sentences,
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z ]"))
                            ],
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(assistantController.fEmail);
                            },
                          ),
                        ),
                        //Email
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Email"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CommonTextFieldWidget(
                            hintText: "user@gmail.com",
                            textEditingController: assistantController.cEmail,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: assistantController.fEmail,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(
                                  assistantController.fMobileNumber);
                            },
                          ),
                        ),
                        //Mobile Number
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Mobile Number"),
                        ),
                        Container(
                          height: 48,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                //     child: IntlPhoneField(
                                //   autovalidateMode: null,
                                //   showDropdownIcon: false,
                                //   onCountryChanged: (value) {},
                                //   controller:
                                //       assistantController.cMobileNumber,
                                //   keyboardType:
                                //       const TextInputType.numberWithOptions(
                                //           decimal: true, signed: true),
                                //   inputFormatters: [
                                //     FilteringTextInputFormatter.digitsOnly
                                //   ],
                                //   decoration: InputDecoration(
                                //       border: const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       enabledBorder: const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       disabledBorder:
                                //           const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       focusedBorder: const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       errorBorder: const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       errorText: null,
                                //       contentPadding:
                                //           const EdgeInsets.symmetric(
                                //               vertical: 8, horizontal: 10),
                                //       hintText: tr('Mobile Number'),
                                //       hintStyle: const TextStyle(
                                //         color: Colors.grey,
                                //         fontSize: 16,
                                //         fontFamily: "verdana_regular",
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //       counterText: ''),
                                //   initialCountryCode: 'IN',
                                //   focusNode:
                                //       assistantController.fMobileNumber,
                                //   onSubmitted: (f) {
                                //     FocusScope.of(context).unfocus();
                                //   },
                                //   onChanged: (phone) {
                                //     // ignore: avoid_print
                                //     print('length ${phone.number.length}');
                                //   },
                                // )),
                                child: _buildphoneNumberWidget(
                                  context,
                                  assistantController,
                                ),
                              )),
                            ],
                          ),
                        ),
                        //Gender
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: PrimaryTextWidget(text: "Gender"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CommonDropDown(
                            val: assistantController.selectGender,
                            list: global.genderList.map((e) => e).toList(),
                            onTap: () {},
                            onChanged: (selectedValue) {
                              assistantController.selectGender = selectedValue;
                              assistantController.update();
                            },
                          ),
                        ),
                        //Date of Birth
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "DOB"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CommonTextFieldWidget(
                            hintText: "Select Birth Date",
                            textEditingController:
                                assistantController.cBirthDate,
                            obscureText: false,
                            readOnly: true,
                            suffixIcon: Icons.calendar_month,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        //Primary Skills
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Primary Skills"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GetBuilder<AddAssistantController>(
                              init: assistantController,
                              builder: (assistantController) {
                                return CommonTextFieldWidget(
                                  hintText: tr("Choose Your Primary Skills"),
                                  textEditingController: assistantController
                                      .cAssistantPrimarySkill,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.arrow_drop_down,
                                  onTap: () {
                                    Get.dialog(
                                      GetBuilder<AddAssistantController>(
                                        init: assistantController,
                                        builder: (controller) {
                                          return AlertDialog(
                                            title: const Text("Primary Skills")
                                                .tr(),
                                            content: SizedBox(
                                              height: Get.height * 1 / 3,
                                              width: Get.width,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: global
                                                    .assistantPrimarySkillModelList!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return CheckboxListTile(
                                                    tristate: false,
                                                    value: global
                                                        .assistantPrimarySkillModelList![
                                                            index]
                                                        .isCheck,
                                                    onChanged: (value) {
                                                      global
                                                          .assistantPrimarySkillModelList![
                                                              index]
                                                          .isCheck = value;
                                                      assistantController
                                                          .update();
                                                    },
                                                    title: Text(
                                                      global
                                                              .assistantPrimarySkillModelList![
                                                                  index]
                                                              .name ??
                                                          "No primary skills",
                                                      style: Get
                                                          .theme
                                                          .primaryTextTheme
                                                          .titleMedium,
                                                    ),
                                                    activeColor:
                                                        COLORS().primaryColor,
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  for (int i = 0;
                                                      i <
                                                          global
                                                              .assistantPrimarySkillModelList!
                                                              .length;
                                                      i++) {
                                                    if (global
                                                            .assistantPrimarySkillModelList![
                                                                i]
                                                            .isCheck ==
                                                        true) {
                                                      global
                                                          .assistantPrimarySkillModelList![
                                                              i]
                                                          .isCheck = false;
                                                    }
                                                  }
                                                  assistantController
                                                      .cAssistantPrimarySkill
                                                      .text = "";
                                                  Get.back();
                                                  assistantController.update();
                                                },
                                                child: const Text("Clear").tr(),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  assistantController.assistant
                                                      .assistantPrimarySkillId = [];
                                                  assistantController
                                                      .cAssistantPrimarySkill
                                                      .text = '';
                                                  for (int i = 0;
                                                      i <
                                                          global
                                                              .assistantPrimarySkillModelList!
                                                              .length;
                                                      i++) {
                                                    if (global
                                                            .assistantPrimarySkillModelList![
                                                                i]
                                                            .isCheck ==
                                                        true) {
                                                      assistantController
                                                              .cAssistantPrimarySkill
                                                              .text +=
                                                          "${global.assistantPrimarySkillModelList![i].name},";
                                                    }
                                                    if (i ==
                                                        global.assistantPrimarySkillModelList!
                                                                .length -
                                                            1) {
                                                      assistantController
                                                              .cAssistantPrimarySkill
                                                              .text =
                                                          assistantController
                                                              .cAssistantPrimarySkill
                                                              .text
                                                              .substring(
                                                                  0,
                                                                  assistantController
                                                                          .cAssistantPrimarySkill
                                                                          .text
                                                                          .length -
                                                                      1); //remove last ","
                                                    }
                                                    assistantController
                                                            .assistantPrimaryId =
                                                        global
                                                            .assistantPrimarySkillModelList!
                                                            .where((element) =>
                                                                element
                                                                    .isCheck ==
                                                                true)
                                                            .toList();
                                                  }
                                                  for (int j = 0;
                                                      j <
                                                          assistantController
                                                              .assistantPrimaryId
                                                              .length;
                                                      j++) {
                                                    assistantController
                                                        .assistant
                                                        .assistantPrimarySkillId!
                                                        .add(AssistantPrimarySkillModel(
                                                            id: assistantController
                                                                .assistantPrimaryId[
                                                                    j]
                                                                .id));
                                                  }
                                                  Get.back();
                                                  assistantController.update();
                                                },
                                                child: const Text("Done").tr(),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                        //All Skills
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "All Skills"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GetBuilder<AddAssistantController>(
                              init: assistantController,
                              builder: (controller) {
                                return CommonTextFieldWidget(
                                  hintText: "Choose Your All Skills",
                                  textEditingController:
                                      assistantController.cAssistantAllSkill,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.arrow_drop_down,
                                  onTap: () {
                                    Get.dialog(
                                      GetBuilder<AddAssistantController>(
                                          init: assistantController,
                                          builder: (controller) {
                                            return AlertDialog(
                                              title:
                                                  const Text("All Skills").tr(),
                                              content: SizedBox(
                                                height: Get.height * 1 / 3,
                                                width: Get.width,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: global
                                                      .assistantAllSkillModelList!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      tristate: false,
                                                      value: global
                                                          .assistantAllSkillModelList![
                                                              index]
                                                          .isCheck,
                                                      onChanged: (value) {
                                                        global
                                                                .assistantAllSkillModelList![
                                                                    index]
                                                                .isCheck =
                                                            value ?? false;
                                                        assistantController
                                                            .update();
                                                      },
                                                      title: Text(
                                                        global
                                                                .assistantAllSkillModelList![
                                                                    index]
                                                                .name ??
                                                            "No Skills",
                                                        style: Get
                                                            .theme
                                                            .primaryTextTheme
                                                            .titleMedium,
                                                      ),
                                                      activeColor:
                                                          COLORS().primaryColor,
                                                    );
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    for (int i = 0;
                                                        i <
                                                            global
                                                                .assistantAllSkillModelList!
                                                                .length;
                                                        i++) {
                                                      if (global
                                                              .assistantAllSkillModelList![
                                                                  i]
                                                              .isCheck ==
                                                          true) {
                                                        global
                                                            .assistantAllSkillModelList![
                                                                i]
                                                            .isCheck = false;
                                                      }
                                                    }
                                                    assistantController
                                                        .cAssistantAllSkill
                                                        .text = "";
                                                    Get.back();
                                                    assistantController
                                                        .update();
                                                  },
                                                  child:
                                                      const Text("Clear").tr(),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    assistantController
                                                        .assistant
                                                        .assistantAllSkillId = [];
                                                    assistantController
                                                        .cAssistantAllSkill
                                                        .text = '';
                                                    for (int i = 0;
                                                        i <
                                                            global
                                                                .assistantAllSkillModelList!
                                                                .length;
                                                        i++) {
                                                      if (global
                                                              .assistantAllSkillModelList![
                                                                  i]
                                                              .isCheck ==
                                                          true) {
                                                        assistantController
                                                                .cAssistantAllSkill
                                                                .text +=
                                                            "${global.assistantAllSkillModelList![i].name},";
                                                      }
                                                      if (i ==
                                                          global.assistantAllSkillModelList!
                                                                  .length -
                                                              1) {
                                                        assistantController
                                                                .cAssistantAllSkill
                                                                .text =
                                                            assistantController
                                                                .cAssistantAllSkill
                                                                .text
                                                                .substring(
                                                                    0,
                                                                    assistantController
                                                                            .cAssistantAllSkill
                                                                            .text
                                                                            .length -
                                                                        1); //remove last ","
                                                      }
                                                      assistantController
                                                              .assistantAllId =
                                                          global
                                                              .assistantAllSkillModelList!
                                                              .where((element) =>
                                                                  element
                                                                      .isCheck ==
                                                                  true)
                                                              .toList();
                                                    }
                                                    for (int j = 0;
                                                        j <
                                                            assistantController
                                                                .assistantAllId
                                                                .length;
                                                        j++) {
                                                      assistantController
                                                          .assistant
                                                          .assistantAllSkillId!
                                                          .add(AssistantAllSkillModel(
                                                              id: assistantController
                                                                  .assistantAllId[
                                                                      j]
                                                                  .id));
                                                    }
                                                    Get.back();
                                                    assistantController
                                                        .update();
                                                  },
                                                  child:
                                                      const Text("Done").tr(),
                                                ),
                                              ],
                                            );
                                          }),
                                    );
                                  },
                                );
                              }),
                        ),
                        //Language
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Language"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GetBuilder<AddAssistantController>(
                              init: assistantController,
                              builder: (controller) {
                                return CommonTextFieldWidget(
                                  hintText: "Choose Your Language",
                                  textEditingController:
                                      assistantController.cAssistantLanguage,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.arrow_drop_down,
                                  onTap: () {
                                    Get.dialog(
                                      GetBuilder<AddAssistantController>(
                                          init: assistantController,
                                          builder: (controller) {
                                            return AlertDialog(
                                              title: const Text("All Language")
                                                  .tr(),
                                              content: SizedBox(
                                                height: Get.height * 1 / 3,
                                                width: Get.width,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: global
                                                      .assistantLanguageModelList!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      tristate: false,
                                                      value: global
                                                          .assistantLanguageModelList![
                                                              index]
                                                          .isCheck,
                                                      onChanged: (value) {
                                                        global
                                                            .assistantLanguageModelList![
                                                                index]
                                                            .isCheck = value;
                                                        assistantController
                                                            .update();
                                                      },
                                                      title: Text(
                                                        global
                                                                .assistantLanguageModelList![
                                                                    index]
                                                                .name ??
                                                            "No language",
                                                        style: Get
                                                            .theme
                                                            .primaryTextTheme
                                                            .titleMedium,
                                                      ),
                                                      activeColor:
                                                          COLORS().primaryColor,
                                                    );
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    for (int i = 0;
                                                        i <
                                                            global
                                                                .assistantLanguageModelList!
                                                                .length;
                                                        i++) {
                                                      if (global
                                                              .assistantLanguageModelList![
                                                                  i]
                                                              .isCheck ==
                                                          true) {
                                                        global
                                                            .assistantLanguageModelList![
                                                                i]
                                                            .isCheck = false;
                                                      }
                                                    }
                                                    assistantController
                                                        .cAssistantLanguage
                                                        .text = "";
                                                    Get.back();
                                                    assistantController
                                                        .update();
                                                  },
                                                  child:
                                                      const Text("Clear").tr(),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    assistantController
                                                        .assistant
                                                        .assistantLanguageId = [];
                                                    assistantController
                                                        .cAssistantLanguage
                                                        .text = '';
                                                    for (int i = 0;
                                                        i <
                                                            global
                                                                .assistantLanguageModelList!
                                                                .length;
                                                        i++) {
                                                      if (global
                                                              .assistantLanguageModelList![
                                                                  i]
                                                              .isCheck ==
                                                          true) {
                                                        assistantController
                                                                .cAssistantLanguage
                                                                .text +=
                                                            "${global.assistantLanguageModelList![i].name},";
                                                      }
                                                      if (i ==
                                                          global.assistantLanguageModelList!
                                                                  .length -
                                                              1) {
                                                        assistantController
                                                                .cAssistantLanguage
                                                                .text =
                                                            assistantController
                                                                .cAssistantLanguage
                                                                .text
                                                                .substring(
                                                                    0,
                                                                    assistantController
                                                                            .cAssistantLanguage
                                                                            .text
                                                                            .length -
                                                                        1); //remove last ","
                                                      }
                                                      assistantController
                                                              .assistantLanguagesId =
                                                          global
                                                              .assistantLanguageModelList!
                                                              .where((element) =>
                                                                  element
                                                                      .isCheck ==
                                                                  true)
                                                              .toList();
                                                    }
                                                    for (int j = 0;
                                                        j <
                                                            assistantController
                                                                .assistantLanguagesId
                                                                .length;
                                                        j++) {
                                                      assistantController
                                                          .assistant
                                                          .assistantLanguageId!
                                                          .add(AssistantLanguageModel(
                                                              id: assistantController
                                                                  .assistantLanguagesId[
                                                                      j]
                                                                  .id));
                                                    }
                                                    Get.back();
                                                    assistantController
                                                        .update();
                                                  },
                                                  child:
                                                      const Text("Done").tr(),
                                                ),
                                              ],
                                            );
                                          }),
                                    );
                                  },
                                );
                              }),
                        ),
                        //Expirence
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: PrimaryTextWidget(text: "Experience In Years"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CommonTextFieldWidget(
                            textEditingController:
                                assistantController.cExpirence,
                            formatter: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 2,
                            counterText: '',
                            focusNode: assistantController.fExpirence,
                            onFieldSubmitted: (f) {
                              FocusScope.of(context).unfocus();
                            },
                            hintText: "Enter Your Expirence",
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: COLORS().primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (flagId == 2) {
                        // ignore: unrelated_type_equality_checks
                        if (assistantController.userFile == null ||
                            // ignore: unrelated_type_equality_checks
                            assistantController.userFile == '') {
                          if (assistantModel?.profile != null &&
                              assistantModel?.profile != '') {
                            assistantController.profile =
                                assistantModel!.profile!;
                          }
                        }

                        assistantController.updateValidateAssistantForm(
                            assistantController.updateAssistantId!);
                      } else {
                        assistantController.validateAssistantForm();
                      }
                    },
                    child: flagId == 1
                        ? const Text(
                            "Add Assistant",
                            style: TextStyle(color: Colors.black),
                          ).tr()
                        : const Text(
                            "Edit Assistant",
                            style: TextStyle(color: Colors.black),
                          ).tr(),
                  ),
                ),
              );
            }),
      ),
    );
  }

  //User Image
  Widget selectImageBottomSheetWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.camera_alt,
            color: COLORS().blackColor,
          ),
          title: Text(
            "Camera",
            style: Get.theme.primaryTextTheme.titleMedium,
          ).tr(),
          onTap: () async {
            assistantController.imageFile =
                await assistantController.imageService(ImageSource.camera);
            assistantController.userFile = assistantController.imageFile;
            assistantController.profile =
                base64.encode(assistantController.imageFile!.readAsBytesSync());
            assistantController.update();
            Get.back();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.photo_library,
            color: Colors.blue,
          ),
          title: Text(
            "Gallery",
            style: Get.theme.primaryTextTheme.titleMedium,
          ).tr(),
          onTap: () async {
            assistantController.imageFile =
                await assistantController.imageService(ImageSource.gallery);
            assistantController.userFile = assistantController.imageFile;
            assistantController.profile =
                base64.encode(assistantController.imageFile!.readAsBytesSync());
            assistantController.update();
            Get.back();
            // assistantController.onOpenGallery();
          },
        ),
        ListTile(
          leading: Icon(Icons.cancel, color: COLORS().errorColor),
          title: Text(
            "Cancel",
            style: Get.theme.primaryTextTheme.titleMedium,
          ).tr(),
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }

  //Date of Birth
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style:
                  TextButton.styleFrom(foregroundColor: Get.theme.primaryColor),
            ),
            colorScheme: ColorScheme.light(
              primary: Get.theme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      assistantController.onDateSelected(picked);
    }
  }

  Container _buildphoneNumberWidget(
      BuildContext context, AddAssistantController assistatncontroller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey)),
      child: SizedBox(
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              contentTextStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey[800],
              surfaceTintColor: Colors.grey[800],
            ),
          ),
          //MOBILE
          child: SizedBox(
            child: InternationalPhoneNumberInput(
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              focusNode: assistantController.fMobileNumber,
              spaceBetweenSelectorAndTextField: 0,
              maxLength: 10,
              scrollPadding: EdgeInsets.zero,
              textFieldController: assistatncontroller.cMobileNumber,
              inputDecoration: InputDecoration(
                hintText: tr('Mobile Number'),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              onInputValidated: (bool value) {},
              selectorConfig: const SelectorConfig(
                trailingSpace: false,
                leadingPadding: 2,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              searchBoxDecoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  )),
              initialValue: initialPhone,
              formatInput: false,
              inputBorder: InputBorder.none,
              onSaved: (PhoneNumber number) {
                debugPrint('On Saved: ${number.dialCode}');
                assistatncontroller.updateCountryCode(number.dialCode);
                assistatncontroller.update();
              },
              onFieldSubmitted: (value) {
                debugPrint('On onFieldSubmitted: $value');
                FocusScope.of(context).unfocus();
              },
              onInputChanged: (PhoneNumber number) {
                debugPrint('On onInputChanged: ${number.dialCode}');
                assistatncontroller.updateCountryCode(number.dialCode);
                assistatncontroller.update();
              },
              onSubmit: () {
                debugPrint('On onSubmit:');
              },
            ),
          ),
        ),
      ),
    );
  }
}
