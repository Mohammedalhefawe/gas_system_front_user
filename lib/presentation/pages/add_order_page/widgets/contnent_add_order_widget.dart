import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/data/models/address_model.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';
import 'package:gas_user_app/presentation/custom_widgets/custom_text_field.dart';
import 'package:gas_user_app/presentation/custom_widgets/popup_menu_button_child.dart';
import 'package:gas_user_app/presentation/pages/add_order_page/add_order_controller.dart';
import 'package:gas_user_app/presentation/pages/cart_page/widgets/details_paid_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class ContentAddOrderWidget extends StatelessWidget {
  const ContentAddOrderWidget({super.key, required this.controller});

  final AddOrderPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PopupMenuButton<AddressModel>(
                      key: controller.addressPopupMenuKey,
                      elevation: 2,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context) {
                        return controller.addresses.map((address) {
                          return PopupMenuItem<AddressModel>(
                            value: address,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p12,
                              vertical: AppPadding.p8,
                            ),
                            child: PopUpMenuButtonChild(
                              text: address.addressName ?? address.address,
                              color: ColorManager.colorFontPrimary,
                              icon: null,
                            ),
                            onTap: () {
                              controller.selectAddress(address);
                            },
                          );
                        }).toList();
                      },
                      child: CustomTextField(
                        title: 'Address'.tr,
                        hint: 'SelectAddress'.tr,
                        icon: Assets.icons.locationIcon.svg(width: AppSize.s28),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Transform.rotate(
                            angle: -math.pi / 2,
                            child: Assets.icons.arrowBackIcon.svg(
                              width: AppSize.s22,
                            ),
                          ),
                        ),
                        textEditingController: TextEditingController(
                          text: controller.selectedAddress.value != null
                              ? controller.selectedAddress.value!.addressName ??
                                    controller.selectedAddress.value!.address
                              : '',
                        ),
                        textInputType: TextInputType.text,
                        readOnly: true,
                        fillColor: ColorManager.colorWhite,
                        borderRadius: AppSize.s8,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            controller.selectedAddress.value == null
                            ? 'RequiredAddress'.tr
                            : null,
                        onTap: () {
                          controller.addressPopupMenuKey.currentState!
                              .showButtonMenu();
                        },
                        requiredField: true,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    PopupMenuButton<String>(
                      key: controller.paymentPopupMenuKey,
                      color: ColorManager.colorGrey0,
                      elevation: 2,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context) {
                        return ['cash'].map((method) {
                          return PopupMenuItem<String>(
                            value: method,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p12,
                              vertical: AppPadding.p8,
                            ),
                            child: PopUpMenuButtonChild(
                              text: method.tr,
                              color: ColorManager.colorFontPrimary,
                              icon: null,
                            ),
                            onTap: () {
                              controller.selectPaymentMethod(method);
                            },
                          );
                        }).toList();
                      },
                      child: CustomTextField(
                        title: 'PaymentMethod'.tr,
                        hint: controller.paymentMethod.value.tr,
                        icon: Assets.icons.paymentIcon.svg(width: AppSize.s28),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Transform.rotate(
                            angle: -math.pi / 2,
                            child: Assets.icons.arrowBackIcon.svg(
                              width: AppSize.s22,
                            ),
                          ),
                        ),
                        textEditingController: TextEditingController(
                          text: controller.paymentMethod.value.tr,
                        ),
                        textInputType: TextInputType.none,
                        readOnly: true,
                        fillColor: ColorManager.colorWhite,
                        borderRadius: AppSize.s8,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            controller.paymentMethod.value.isEmpty
                            ? 'RequiredPaymentMethod'.tr
                            : null,
                        onTap: () {
                          controller.paymentPopupMenuKey.currentState!
                              .showButtonMenu();
                        },
                        requiredField: true,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    RichText(
                      text: TextSpan(
                        text: 'DeliveryOptions'.tr,
                        style: Get.textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: ' *',
                            style: Get.textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('ImmediateDelivery'.tr),
                            value: true,
                            groupValue: controller.isImmediate.value,
                            onChanged: (value) =>
                                controller.isImmediate.value = value ?? true,
                            activeColor: ColorManager.colorPrimary,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('ScheduledDelivery'.tr),
                            value: false,
                            groupValue: controller.isImmediate.value,
                            onChanged: (value) =>
                                controller.isImmediate.value = value ?? false,
                            activeColor: ColorManager.colorPrimary,
                          ),
                        ),
                      ],
                    ),
                    if (!controller.isImmediate.value) ...[
                      const SizedBox(height: AppSize.s16),
                      CustomTextField(
                        requiredField: true,
                        title: 'DeliveryDate'.tr,
                        hint: 'SelectDate'.tr,
                        icon: Assets.icons.dateIcon.svg(width: AppSize.s28),
                        textEditingController: controller.dateController,
                        textInputType: TextInputType.datetime,
                        fillColor: ColorManager.colorWhite,
                        borderRadius: AppSize.s8,
                        readOnly: true,
                        onTap: () => controller.selectDate(context),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'RequiredDate'.tr
                            : null,
                      ),
                      const SizedBox(height: AppSize.s16),
                      CustomTextField(
                        requiredField: true,
                        title: 'DeliveryTime'.tr,
                        hint: 'SelectTime'.tr,
                        icon: Assets.icons.timeIcon.svg(width: AppSize.s28),
                        textEditingController: controller.timeController,
                        textInputType: TextInputType.datetime,
                        fillColor: ColorManager.colorWhite,
                        borderRadius: AppSize.s8,
                        readOnly: true,
                        onTap: () => controller.selectTime(context),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'RequiredTime'.tr
                            : null,
                      ),
                    ],
                    const SizedBox(height: AppSize.s16),
                    CustomTextField(
                      requiredField: false,
                      title: 'Note'.tr,
                      hint: 'EnterNote'.tr,
                      textEditingController: controller.noteController,
                      textInputType: TextInputType.multiline,
                      maxLines: 2,
                      minLines: 2,
                      fillColor: ColorManager.colorWhite,
                      borderRadius: AppSize.s8,
                    ),
                  ],
                ),
              ),
            ),
          ),

          DetailsPaidWidget(
            controller: controller.cartController,
            btnWidget: AppButton(
              loadingMode:
                  controller.loadingState.value == LoadingState.loading,
              onPressed: controller.submitOrder,
              text: 'PlaceOrder'.tr,
              backgroundColor: ColorManager.colorPrimary,
            ),
          ),
        ],
      );
    });
  }
}
