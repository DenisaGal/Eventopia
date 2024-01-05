import 'package:awp/core/constants/paths.dart';
import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/event/add_event_page.dart';
import 'package:awp/features/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderBar(
            title: "Home",
            icon: Icons.home,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.categories.length,
                    //shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final category = controller.categories[index];

                      return Row(
                        children: [
                          Text(
                            category.name,
                            style:
                                const TextStyle(color: AppColorScheme.orange),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Most popular / recent events"),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.events.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var event = controller.events[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColorScheme.darkRed),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 200,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  event.name,
                                  style: const TextStyle(
                                      color: AppColorScheme.darkRed,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  event.description,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Location: ",
                                              style: TextStyle(
                                                  color:
                                                      AppColorScheme.darkBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(event.location),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Date: ",
                                              style: TextStyle(
                                                  color:
                                                      AppColorScheme.darkBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                                "${event.date.day}/${event.date.month}/${event.date.year}"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Fee: ",
                                              style: TextStyle(
                                                  color:
                                                      AppColorScheme.darkBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(event.tax.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Image.asset(
                                        event.name[0] == 'C'
                                            ? Paths.concert
                                            : Paths.hike,
                                        height: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(AddEventPage());
                  },
                  child: const Text("Add event"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
