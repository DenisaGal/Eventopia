import 'dart:convert';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/create_event_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late DateTime selectedDate;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;
  late RxList<String> selectedCategories = <String>[].obs;

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

  void save() async {
    final event = CreateEventModel(
      name: titleController.text,
      description: descriptionController.text,
      cost: int.tryParse(taxController.text) ?? 0,
      location: locationController.text,
      date: selectedDate,
      categories: selectedCategories,
    );

    try {
      await dio.post('${Connection.baseUrl}/Event/Create',
          data: jsonEncode(event));
    } catch (_) {
      await ErrorDialog.show("Failed to create event.");
    }

    clearForm();
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    taxController.clear();
    locationController.clear();
    dateController.clear();
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
}
