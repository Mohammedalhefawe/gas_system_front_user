import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/add_order_page/add_order_controller.dart';
import 'package:gas_user_app/presentation/pages/add_order_page/widgets/contnent_add_order_widget.dart';
import 'package:gas_user_app/presentation/pages/add_order_page/widgets/no_address_widget.dart';
import 'package:get/get.dart';

class AddOrderPage extends GetView<AddOrderPageController> {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: NormalAppBar(title: 'AddOrder'.tr, backIcon: true),
        body: Obx(() {
          if (controller.addresses.isEmpty &&
              controller.loadingState.value == LoadingState.doneWithNoData) {
            return NoAddreesWidget(controller: controller);
          }
          return ContentAddOrderWidget(controller: controller);
        }),
      ),
    );
  }
}
