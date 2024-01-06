import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:awp/core/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final Dio dio;
  late RxList<EventModel> events = <EventModel>[].obs;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool isSelected = false.obs;
  late Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() async {
    dio = Dio();

    final userId = Get.arguments[0];
    await _loadUser(userId);

    await _loadEvents();
    await _loadCategories();

    super.onInit();
  }

  Future<void> _loadEvents() async {
    try {
      final response = await dio.get('${Connection.baseUrl}/events');
      events.clear();
      List<EventModel> dbEvents = (response.data as List)
          .map((item) => EventModel.fromJson(item))
          .toList();
      events.addAll(dbEvents);
    } catch (e) {
      final ex = e; //TODO show popup
    }
  }

  Future<void> _loadCategories() async {
    try {
      final response = await dio.get('${Connection.baseUrl}/categories');
      categories.clear();
      List<CategoryModel> dbCategories = (response.data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      categories.addAll(dbCategories);
    } catch (e) {
      final ex = e; //TODO show popup
    }
  }

  _loadUser(String userId) {
    user.value = UserModel(
      id: userId,
      email: "EMAIL TEST",
    );
  }
}
