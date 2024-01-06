import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/validators/input_validator.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/event/add_event_controller.dart';
import 'package:awp/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddEventPage extends StatelessWidget {
  AddEventPage({super.key});

  final controller = Get.put(AddEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderBar(
            title: "Add event",
            icon: Icons.add_box_rounded,
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: controller.formKey,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.titleController,
                      key: controller.titleKey,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                      validator: (value) => InputValidator.validate(
                        value,
                        'Mandatory input',
                      ),
                      onChanged: (value) {
                        if (controller.titleKey.currentState!.hasError) {
                          controller.titleKey.currentState!.validate();
                        }
                      },
                    ),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                    ),
                    TextFormField(
                      controller: controller.taxController,
                      decoration: const InputDecoration(
                        labelText: "Cost",
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextFormField(
                      controller: controller.locationController,
                      key: controller.locationKey,
                      decoration: const InputDecoration(
                        labelText: "Location",
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                      validator: (value) => InputValidator.validate(
                        value,
                        'Mandatory input',
                      ),
                      onChanged: (value) {
                        if (controller.locationKey.currentState!.hasError) {
                          controller.locationKey.currentState!.validate();
                        }
                      },
                    ),
                    TextFormField(
                      controller: controller.dateController,
                      key: controller.dateKey,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                              initialDate: DateTime.now(),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((selectedTime) {
                                  if (selectedTime != null) {
                                    DateTime selectedDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );

                                    controller.selectedDate = selectedDateTime;

                                    controller.dateController.text =
                                        "${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year} ${selectedDateTime.hour}:${selectedDateTime.minute}";
                                  } else {
                                    controller.selectedDate = selectedDate;
                                    controller.dateController.text =
                                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                  }
                                });
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppColorScheme.darkBlue,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                      validator: (value) => InputValidator.validate(
                        value,
                        'Mandatory input',
                      ),
                      onChanged: (value) {
                        if (controller.dateKey.currentState!.hasError) {
                          controller.dateKey.currentState!.validate();
                        }
                      },
                    ),
                    Obx(
                          () => Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Select picture',
                              ),
                              controller: controller.templateUploadController,
                              autovalidateMode: controller.selectedFile.value != null ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: controller.selectFile,
                            child: Text('Browse'.tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.save();
                              Get.offAll(HomePage());
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text("Save"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            controller.clearForm();
                            Get.offAll(HomePage());
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
