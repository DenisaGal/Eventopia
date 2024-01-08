import 'dart:math';
import 'dart:typed_data';
import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:awp/core/models/user_details_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyEventsController extends GetxController {
  late final Dio dio;
  late RxList<EventModel> eventsToday = <EventModel>[].obs;
  late RxList<EventModel> futureEvents = <EventModel>[].obs;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;
  late final TextEditingController categoryController;
  late final GlobalKey<FormFieldState> categoryKey;
  RxBool isSelected = false.obs;
  late Rxn<UserDetailsModel> user = Rxn<UserDetailsModel>();
  late String userId;
  late RxList<Uint8List> imagesToday = RxList<Uint8List>();
  late RxList<Uint8List> imagesFuture = RxList<Uint8List>();
  late RxList<Uint8List> defaultImage = RxList<Uint8List>();

  @override
  void onInit() async {
    super.onInit();
    dio = Dio();

    userId = Get.arguments;
    await _loadUser(userId);

    await _loadCategories();
    await _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final response = await dio.get('${Connection.baseUrl}/Event/GetUserEvents?userId=$userId');
      eventsToday.clear();
      imagesToday.clear();
      futureEvents.clear();
      imagesFuture.clear();
      List<EventModel> dbEvents = (response.data as List)
          .map((item) => EventModel.fromJson(item))
          .toList();

      for (var event in dbEvents) {
        if(calculateDifference(event.date) == 0){
          eventsToday.add(event);
          final imageResponse = await dio.get(
            '${Connection.baseUrl}/Event/GetImage/?eventId=${event.id}',
            options: Options(responseType: ResponseType.bytes),
          );
          imagesToday.add(Uint8List.fromList(imageResponse.data));
        }
        else if(calculateDifference(event.date) > 1){
          futureEvents.add(event);
          final imageResponse = await dio.get(
            '${Connection.baseUrl}/Event/GetImage/?eventId=${event.id}',
            options: Options(responseType: ResponseType.bytes),
          );
          imagesFuture.add(Uint8List.fromList(imageResponse.data));
        }
      }
    } catch (_) {
      await ErrorDialog.show("Failed to load events.");
    }
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

  _loadUser(String userId) async {
    try {
      final response =
      await dio.get('${Connection.baseUrl}/User/GetUserById/?id=$userId');
      user.value = UserDetailsModel.fromJson(response.data);
    } catch (_) {
      await ErrorDialog.show("Failed to load events.");
    }
  }

  Future<void> editUserEvent(String? eventId) async {
    try {
      await dio.post(
          '${Connection.baseUrl}/Event/EditUserEvents?userId=$userId&eventId=$eventId');
      await _loadUser(userId);
      await _loadEvents();
    } catch (_) {
      await ErrorDialog.show("Failed to edit user events.");
    }
  }

  bool userHasEvent(String? eventId) {
    return user.value?.events.map((e) => e.id).contains(eventId) ?? false;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
}
