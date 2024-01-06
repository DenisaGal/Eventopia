import 'package:awp/core/theme/colors.dart';
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
    required this.title,
    required this.icon,
    this.onHomePressed,
    this.secondPage,
    this.onSecondPressed,
  });

  final String title;
  final IconData icon;
  final void Function()? onHomePressed;
  final String? secondPage;
  final void Function()? onSecondPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.blue,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
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
          ],
        ),
      ),
    );
  }
}
