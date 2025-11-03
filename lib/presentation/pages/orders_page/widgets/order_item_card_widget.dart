import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/order_status_enum.dart';
import 'package:gas_user_app/data/models/order_model.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';
import 'package:gas_user_app/presentation/pages/order_details_page/order_details_page.dart';
import 'package:gas_user_app/presentation/pages/orders_page/orders_controller.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/status_order_badge_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class OrderItemCardWidget extends GetView<OrdersPageController> {
  final OrderModel order;
  const OrderItemCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final totalAmount =
        (double.parse(order.totalAmount) + double.parse(order.deliveryFee))
            .toStringAsFixed(0);

    return InkWell(
      onTap: () => Get.to(() => OrderDetailsPage(), arguments: order.orderId),
      borderRadius: BorderRadius.circular(AppSize.s16),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.colorWhite,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        padding: const EdgeInsets.all(AppPadding.p20),
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.orderId}',
                        style: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.colorFontPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        order.orderDate,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.colorDoveGray600,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusOrderBadgeWidget(status: order.orderStatus),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              children: [
                Assets.icons.locationIcon.svg(
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    ColorManager.colorDoveGray600,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                Expanded(
                  child: Text(
                    order.address.address,
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.colorDoveGray600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Container(
              height: 1,
              color: ColorManager.colorGrey2.withValues(alpha: 0.1),
            ),
            const SizedBox(height: AppSize.s16),
            _buildPriceRow(
              'Subtotal',
              '${double.parse(order.totalAmount).toStringAsFixed(0)} ${'SP'.tr}',
            ),
            const SizedBox(height: AppSize.s8),
            _buildPriceRow(
              'DeliveryFee',
              '${double.parse(order.deliveryFee).toStringAsFixed(0)} ${'SP'.tr}',
            ),
            const SizedBox(height: AppSize.s8),
            _buildPriceRow('Total', '$totalAmount ${'SP'.tr}', isTotal: true),
            if (order.orderStatus == OrderStatus.pending) ...[
              const SizedBox(height: AppSize.s16),
              AppButton(
                onPressed: () =>
                    controller.showCancelConfirmation(context, order.orderId),
                text: 'CancelOrder'.tr,
                backgroundColor: ColorManager.colorWhite,
                border: Border.all(
                  width: 1,
                  color: ColorManager.colorSecondaryRed,
                ),
                fontColor: ColorManager.colorSecondaryRed,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.tr,
          style: TextStyle(
            fontSize: FontSize.s14,
            color: ColorManager.colorDoveGray600,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: FontSize.s14,
            color: isTotal
                ? ColorManager.colorFontPrimary
                : ColorManager.colorDoveGray600,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
