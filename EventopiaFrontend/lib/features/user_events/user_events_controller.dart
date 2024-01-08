import 'dart:typed_data';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:awp/core/models/preference_model.dart';
import 'package:awp/core/models/user_details_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserEventsController extends GetxController {
  late final Dio dio;
  late RxList<EventModel> events = <EventModel>[].obs;
  late RxList<PreferenceModel> categories = <PreferenceModel>[].obs;
  late Rxn<UserDetailsModel> user = Rxn<UserDetailsModel>();
  late String userId;
  late RxList<Uint8List> images = RxList<Uint8List>();

  @override
  void onInit() async {
    super.onInit();
    dio = Dio();

    userId = Get.arguments;
    await _loadUser(userId);

    await _loadCategories();
  }

  Future<void> _loadEvents() async {
    try {
      final response = await dio.get('${Connection.baseUrl}/Event/GetEvents');
      events.clear();
      images.clear();
      List<EventModel> dbEvents = (response.data as List)
          .map((item) => EventModel.fromJson(item))
          .toList();

      for (var event in dbEvents) {
        events.add(event);
        final imageResponse = await dio.get(
          '${Connection.baseUrl}/Event/GetImage/?eventId=${event.id}',
          options: Options(responseType: ResponseType.bytes),
        );
        images.add(Uint8List.fromList(imageResponse.data));
      }
    } catch (_) {
      await ErrorDialog.show("Failed to load events.");
    }
  }

  Future<void> _loadCategories() async {
    try {
      final response = await dio.get(
          '${Connection.baseUrl}/Category/GetCategoriesByUserId?UserId=$userId');
      categories.clear();
      //TODO load images
      List<PreferenceModel> dbCategories = (response.data as List)
          .map((item) => PreferenceModel.fromJson(item))
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
}
