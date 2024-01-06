import 'package:awp/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> emailKey;
  late final GlobalKey<FormFieldState> passwordKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController typeController;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    emailKey = GlobalKey<FormFieldState>();
    passwordKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    typeController = TextEditingController();

    super.onInit();
  }

  Future register() async {
    Get.offAll(HomePage());
  }
}
