import 'dart:convert';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/create_event_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:awp/features/home/home_page.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AddEventController extends GetxController {
  late final Dio dio;
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> titleKey;
  late final GlobalKey<FormFieldState> locationKey;
  late final GlobalKey<FormFieldState> dateKey;
  late final GlobalKey<FormFieldState> categoryKey;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController taxController;
  late final TextEditingController locationController;
  late final TextEditingController dateController;
  late final TextEditingController categoryController;
  late final TextEditingController fileController;
  late DateTime selectedDate;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;
  late RxList<String> selectedCategories = <String>[].obs;
  Rxn<PlatformFile> selectedFile = Rxn<PlatformFile>();

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    titleKey = GlobalKey<FormFieldState>();
    locationKey = GlobalKey<FormFieldState>();
    dateKey = GlobalKey<FormFieldState>();
    categoryKey = GlobalKey<FormFieldState>();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    taxController = TextEditingController();
    locationController = TextEditingController();
    dateController = TextEditingController();
    categoryController = TextEditingController();
    fileController = TextEditingController();

    dio = Dio();

    await _loadCategories();

    super.onInit();
  }

  Future<void> _loadCategories() async {
    try {
      final response =
          await dio.get('${Connection.baseUrl}/Category/GetCategories');
      categories.clear();
      List<CategoryModel> dbCategories = (response.data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      categories.addAll(dbCategories);
    } catch (_) {
      await ErrorDialog.show("Failed to load categories.");
    }
  }

  Future save() async {
    final event = CreateEventModel(
      name: titleController.text,
      description: descriptionController.text,
      cost: int.tryParse(taxController.text) ?? 0,
      location: locationController.text,
      date: selectedDate,
      categories: selectedCategories,
    );

    try {
      var eventResponse = await dio.post('${Connection.baseUrl}/Event/Create',
          data: jsonEncode(event));

      var createdEvent = EventModel.fromJson(eventResponse.data);

      try {
        var multipartBytes = MultipartFile.fromBytes(
          selectedFile.value!.bytes!.toList(),
          filename: fileController.text,
        );

        await dio.patch(
          '${Connection.baseUrl}/${createdEvent.id}',
          data: FormData.fromMap({
            "file": multipartBytes,
          }),
        );
      } catch (e) {
        await ErrorDialog.show("Failed to add image.");
      }

      clearForm();
      Get.off(HomePage());
    } catch (_) {
      await ErrorDialog.show("Failed to create event.");
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    taxController.clear();
    locationController.clear();
    dateController.clear();
    categories.clear();
    selectedCategories.clear();
    selectedFile.value = null;
    fileController.clear();
  }

  void editSelectedCategories(String categoryId) {
    if (selectedCategories.contains(categoryId)) {
      selectedCategories.remove(categoryId);
    } else {
      selectedCategories.add(categoryId);
    }
  }

  Future addCategory() async {
    try {
      final categoryModel = CategoryModel(
        name: categoryController.text,
      );

      final response = await dio.post('${Connection.baseUrl}/Category/Create',
          data: jsonEncode(categoryModel));

      categories.add(CategoryModel.fromJson(response.data));
    } catch (_) {
      await ErrorDialog.show("Failed to create category.");
    }
  }

  Future<void> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      if (result != null && result.files.isNotEmpty) {
        selectedFile.value = result.files.first;
        fileController.text = result.files.first.name;
      }
    } catch (e) {
      await ErrorDialog.show("Failed to select file.");
    }
  }
}
