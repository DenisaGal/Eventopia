import 'dart:convert';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class AddEventController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> titleKey;
  late final GlobalKey<FormFieldState> locationKey;
  late final GlobalKey<FormFieldState> dateKey;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController taxController;
  late final TextEditingController locationController;
  late final TextEditingController dateController;
  late DateTime selectedDate;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    titleKey = GlobalKey<FormFieldState>();
    locationKey = GlobalKey<FormFieldState>();
    dateKey = GlobalKey<FormFieldState>();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    taxController = TextEditingController();
    locationController = TextEditingController();
    dateController = TextEditingController();
    templateUploadController = TextEditingController();

    super.onInit();
  }

  void save() async {
    final event = EventModel(
      name: titleController.text,
      description: descriptionController.text,
      cost: int.tryParse(taxController.text) ?? 0,
      location: locationController.text,
      date: selectedDate,
    );

    final dio = Dio();
    try {
      final response = await dio.post('${Connection.baseUrl}/events',
          data: jsonEncode(event));
    } catch (e) {}

    clearForm();
  }

  late Rxn<Uint8List> selectedFile =  Rxn<Uint8List>();
  late final TextEditingController templateUploadController;

  Future<void> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      if (result != null && result.files.isNotEmpty) {
        selectedFile.value = result.files.first.bytes;
        templateUploadController.text = result.files.first.name;
      }
    } catch (e) {
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    taxController.clear();
    locationController.clear();
    dateController.clear();
  }
}
