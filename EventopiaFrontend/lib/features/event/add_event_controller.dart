import 'dart:convert';
import 'dart:html';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
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
  late Rxn<Uint8List> selectedFile =  Rxn<Uint8List>();
  late final TextEditingController templateUploadController;
  late PlatformFile file;

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
    //String fileName = select.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
      MultipartFile.fromBytes(selectedFile.value as List<int>)
    });


    try {
      final response = await dio.post('${Connection.baseUrl}/Event/Create',
          data: jsonEncode(event));
      if (response.statusCode == 200){
        var jsonResponse = jsonDecode(response.data);
        var id = jsonResponse['id'];
        final image_response = await dio.post('${Connection.baseUrl}/Event/AddImage/$id',
            data: formData);
      }
    } catch (e) {}

    clearForm();
  }

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
      final ex = e; //TODO show popup
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    taxController.clear();
    locationController.clear();
    dateController.clear();
    templateUploadController.clear();
  }
}
