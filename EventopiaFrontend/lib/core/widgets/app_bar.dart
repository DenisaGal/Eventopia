import 'package:awp/core/theme/colors.dart';
import 'package:awp/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
    required this.title,
    required this.icon,
    this.onHomePressed,
    this.secondPage,
    this.onSecondPressed,
    this.thirdPage,
    this.onThirdPressed,
  });

  final String title;
  final IconData icon;
  final void Function()? onHomePressed;
  final String? secondPage;
  final void Function()? onSecondPressed;
  final String? thirdPage;
  final void Function()? onThirdPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.blue,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: onHomePressed,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: AppColorScheme.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColorScheme.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                if (secondPage != null)
                  InkWell(
                    onTap: onSecondPressed,
                    child: Text(
                      secondPage ?? '',
                      style: const TextStyle(
                        color: AppColorScheme.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (thirdPage != null)
                  InkWell(
                    onTap: onThirdPressed,
                    child: Text(
                      thirdPage ?? '',
                      style: const TextStyle(
                        color: AppColorScheme.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(LoginPage());
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: AppColorScheme.white)))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 1,
                  ),
                  child: Text("Log out"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
