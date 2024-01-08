import 'package:awp/core/constants/paths.dart';
import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/home/home_page.dart';
import 'package:awp/features/MyEvents/my_events.dart';
import 'package:awp/features/user_events/user_events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEventsPage extends StatelessWidget {
  UserEventsPage({super.key});

  final controller = Get.put(UserEventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderBar(
            title: "Eventopia",
            icon: Icons.home,
            onHomePressed: () {
              Get.offAll(HomePage());
            },
            secondPage: "Recommended",
            onSecondPressed: () {
              Get.to(() => UserEventsPage(), arguments: controller.userId);
            },
            thirdPage: "My events",
            onThirdPressed: () {
              Get.to(() => MyEventsPage(), arguments: controller.userId);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Based on your interests, you might also like: ",
                    style: TextStyle(
                      color: AppColorScheme.darkBlue,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => SizedBox(
                      height: 620,
                      child: ListView.builder(
                        itemCount: controller.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = controller.categories[index];

                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Flexible(
                                    flex: 1,
                                    child: Divider(
                                      color: AppColorScheme.darkRed,
                                      thickness: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    category.categoryName,
                                    style: const TextStyle(
                                      color: AppColorScheme.darkRed,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Flexible(
                                    flex: 4,
                                    child: Divider(
                                      color: AppColorScheme.darkRed,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: category.events.length,
                                  itemBuilder:
                                      (BuildContext context, int eventIndex) {
                                    final event = category.events[eventIndex];

                                    return Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(2, 2),
                                                  blurRadius: 6)
                                            ],
                                            color: AppColorScheme.background,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 200,
                                          width: 300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  event.details,
                                                  style: const TextStyle(
                                                      color: AppColorScheme
                                                          .darkOrange,
                                                      fontSize: 18),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        event.extra ?? '',
                                                        maxLines: 5,
                                                        style: const TextStyle(
                                                            color:
                                                                AppColorScheme
                                                                    .blue),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Image.asset(
                                                        Paths.concert,
                                                        width: 100,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
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
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
