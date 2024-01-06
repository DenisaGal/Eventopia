import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:awp/core/models/user_details_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final Dio dio;
  late RxList<EventModel> events = <EventModel>[].obs;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool isSelected = false.obs;
  late Rxn<UserDetailsModel> user = Rxn<UserDetailsModel>();
  late String userId;

  @override
  void onInit() async {
    dio = Dio();

    userId = Get.arguments;
    await _loadUser(userId);

    await _loadEvents();
    await _loadCategories();

    super.onInit();
  }

  Future<void> _loadEvents() async {
    try {
      final response = await dio.get('${Connection.baseUrl}/Event/GetEvents');
      events.clear();
      List<EventModel> dbEvents = (response.data as List)
          .map((item) => EventModel.fromJson(item))
          .toList();
      events.addAll(dbEvents);
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
      final response = await dio.post(
          '${Connection.baseUrl}/Event/EditUserEvents?userId=$userId&eventId=$eventId');
      await _loadUser(userId);
    } catch (_) {
      await ErrorDialog.show("Failed to edit user events.");
    }
  }

  bool userHasEvent(String? eventId) {
    return user.value?.events.map((e) => e.id).contains(eventId) ?? false;
  }
}
