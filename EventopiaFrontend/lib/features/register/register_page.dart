import 'package:awp/core/constants/paths.dart';
import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/validators/input_validator.dart';
import 'package:awp/features/register/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = Get.put(RegisterController());
  var checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColorScheme.background,
          ),
          Center(
            child: Column(
              children: [
                Flexible(
                  child: Image.asset(
                    Paths.logo,
                    height: 500,
                  ),
                ),
                const Text(
                  "Eventopia",
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColorScheme.darkRed,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: controller.formKey,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                const TextStyle(color: AppColorScheme.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColorScheme.white,
                            hoverColor: AppColorScheme.white,
                          ),
                          controller: controller.emailController,
                          key: controller.emailKey,
                          onChanged: (value) {
                            if (controller.emailKey.currentState!.hasError) {
                              controller.emailKey.currentState!.validate();
                            }
                          },
                          validator: (value) {
                            var mandatoryInputValidation =
                                InputValidator.validate(
                                    value, 'Mandatory field');
                            if (mandatoryInputValidation != null &&
                                mandatoryInputValidation.isNotEmpty) {
                              return mandatoryInputValidation;
                            }
                            var emailValidator = InputValidator.validateEmail(
                                value, 'Invalid email');
                            if (emailValidator != null &&
                                emailValidator.isNotEmpty) {
                              return emailValidator;
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(255),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                const TextStyle(color: AppColorScheme.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColorScheme.white,
                            hoverColor: AppColorScheme.white,
                          ),
                          key: controller.passwordKey,
                          onChanged: (value) {
                            if (controller.passwordKey.currentState!.hasError) {
                              controller.passwordKey.currentState!.validate();
                            }
                          },
                          validator: (value) => InputValidator.validate(
                            value,
                            'Mandatory field',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(255),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.register();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              backgroundColor: AppColorScheme.darkBlue),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 15),
                        RichText(
                          text: TextSpan(
                            text: 'Login',
                            style: const TextStyle(color: AppColorScheme.red),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.emailController.clear();
                                controller.passwordController.clear();
                                //Get.offAll(RegisterPage());
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
