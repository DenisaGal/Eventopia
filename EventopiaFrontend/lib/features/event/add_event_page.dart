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
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Image',
                              ),
                              controller: controller.fileController,
                              autovalidateMode:
                                  controller.selectedFile.value != null
                                      ? AutovalidateMode.onUserInteraction
                                      : AutovalidateMode.disabled,
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
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final category = controller.categories[index];

                                  return Row(
                                    children: [
                                      Obx(
                                        () => InkWell(
                                          onTap: () {
                                            controller.editSelectedCategories(
                                                category.id ?? '');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: !controller
                                                        .selectedCategories
                                                        .contains(category.id)
                                                    ? Border.all(
                                                        color: AppColorScheme
                                                            .orange)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: !controller
                                                        .selectedCategories
                                                        .contains(category.id)
                                                    ? AppColorScheme.white
                                                    : AppColorScheme.orange),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              child: Text(
                                                category.name,
                                                style: TextStyle(
                                                    color: !controller
                                                            .selectedCategories
                                                            .contains(
                                                                category.id)
                                                        ? AppColorScheme.orange
                                                        : AppColorScheme.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await Get.dialog(
                                  AlertDialog(
                                    title: const Text(
                                      "New category",
                                      style: TextStyle(
                                          color: AppColorScheme.darkBlue),
                                    ),
                                    content: TextFormField(
                                      controller: controller.categoryController,
                                      decoration: const InputDecoration(
                                        labelText: "Name",
                                      ),
                                      key: controller.categoryKey,
                                      onChanged: (value) {
                                        if (controller.categoryKey.currentState!
                                            .hasError) {
                                          controller.categoryKey.currentState!
                                              .validate();
                                        }
                                      },
                                      validator: (value) {
                                        var mandatoryValidator =
                                            InputValidator.validate(
                                                value, "Mandatory input");

                                        if (mandatoryValidator != null &&
                                            mandatoryValidator.isNotEmpty) {
                                          return mandatoryValidator;
                                        }

                                        if (controller.categories
                                            .map((c) => c.name)
                                            .any((c) => c == value)) {
                                          return "Category already exists";
                                        }

                                        return null;
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(255),
                                      ],
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      ElevatedButton(
                                        child: const Text("Add"),
                                        onPressed: () {
                                          if (controller
                                              .categoryKey.currentState!
                                              .validate()) {
                                            controller.addCategory();
                                            controller.categoryController
                                                .clear();
                                            Get.back();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add_rounded,
                                color: AppColorScheme.orange,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.save();
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
                            Get.off(HomePage());
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
