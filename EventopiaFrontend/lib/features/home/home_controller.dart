import 'package:awp/core/models/category_model.dart';
import 'package:awp/core/models/event_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late List<EventModel> events = [];
  late List<CategoryModel> categories = [];

  @override
  void onInit() async {
    await _loadEvents();
    await _loadCategories();

    super.onInit();
  }

  Future<void> _loadEvents() async {
    events.add(EventModel(
        name: "Concert Om la luna",
        description: "Trupa Om la luna revine la Timisoara!!",
        tax: 80,
        location: "Timisoara",
        date: DateTime.now()));
    events.add(EventModel(
        name: "Hike Retezat",
        description: "Urcare pana la Lacul Bucura prin Muntii Retezat",
        tax: 20,
        location: "Retezat",
        date: DateTime.now()));
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
