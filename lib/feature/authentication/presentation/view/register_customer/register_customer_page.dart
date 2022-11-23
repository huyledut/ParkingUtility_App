import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/register_customer/register_customer_controller.dart';

class RegisterCustomerPage extends GetView<RegisterCustomerController> {
  const RegisterCustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Đăng ký'),
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.username,
                            maxLength: 25,
                            controller: controller.usernameTextEditingController,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.email,
                            maxLength: 80,
                            controller: controller.emailTextEditingController,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller: controller.passwordTextEditingController,
                            obscureText: controller.isShowPassword.value,
                            suffixIcon: controller.isShowPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon: controller.onTapShowPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.confirmPassword,
                            controller: controller.confirmPasswordTextEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isShowConfirmPassword.value,
                            suffixIcon: controller.isShowConfirmPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon: controller.onTapShowConfirmPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapRegister(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: 'Đăng ký',
                      onPressed: () => controller.onTapRegister(context),
                      pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                      fillColor: controller.isDisableButton.value ? ColorName.gray838 : ColorName.primaryColor,
                      state: controller.registerState,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
