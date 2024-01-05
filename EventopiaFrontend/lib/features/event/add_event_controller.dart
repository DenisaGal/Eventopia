import 'package:awp/core/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    super.onInit();
  }

  void save() async {
    final event = EventModel(
      name: titleController.text,
      description: descriptionController.text,
      tax: int.tryParse(taxController.text) ?? 0,
      location: locationController.text,
      date: selectedDate,
    );

    //TODO call save endpoint
    /*final dio = Dio();
    final response = await dio.post('http://localhost:XXXX', data: event.toJson());*/

    clearForm();
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    taxController.clear();
    locationController.clear();
    dateController.clear();
  }
}
