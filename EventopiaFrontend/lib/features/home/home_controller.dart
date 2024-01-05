import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late RxList<EventModel> events = <EventModel>[].obs;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() async {
    await _loadEvents();
    await _loadCategories();

    super.onInit();
  }

  Future<void> _loadEvents() async {
    final dio = Dio();
    try {
      final response = await dio.get('http://localhost:46772/events');
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
    categories.add(CategoryModel(
      id: "1",
      name: "Music",
    ));
    categories.add(CategoryModel(
      id: "2",
      name: "Outdoors",
    ));
  }
}
