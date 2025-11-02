import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/cart_page/cart_page_controller.dart';
import 'package:gas_user_app/presentation/pages/cart_page/widgets/cart_item_widget.dart';
import 'package:gas_user_app/presentation/pages/cart_page/widgets/content_empty_cart_widget.dart';
import 'package:gas_user_app/presentation/pages/cart_page/widgets/details_paid_widget.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/navigation_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: "Cart".tr, backIcon: true),

      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return ContentEmptyCartWidget();
        }
        return Column(
          children: [
            const SizedBox(height: AppSize.s8),
            Expanded(
              child: ListView.separated(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return CartItemWidget(item: item, controller: controller);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSize.s8),
              ),
            ),
            DetailsPaidWidget(
              controller: controller,
              btnWidget: AppButton(
                onPressed: () {
                  if (controller.deliveryFeeState.value ==
                          LoadingState.loading ||
                      controller.deliveryFeeState.value ==
                          LoadingState.hasError) {
                    return;
                  }
                  Get.toNamed(AppRoutes.addOrderRoute);
                },
                text: 'OrderNow'.tr,
                backgroundColor: ColorManager.colorPrimary,
              ),
            ),
          ],
        );
      }),
    );
  }
}
