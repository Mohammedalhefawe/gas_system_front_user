import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/data/models/order_model.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';
import 'package:gas_user_app/presentation/pages/order_details_page/order_details_page.dart';
import 'package:gas_user_app/presentation/pages/orders_page/orders_controller.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/content_empty_orders_widget.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/shimmer_orders_page_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class OrdersPage extends GetView<OrdersPageController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersPageController());
    return Obx(() {
      if (controller.loadingState.value == LoadingState.loading) {
        return ShimmerOrdersPageWidget();
      }
      if (controller.loadingState.value == LoadingState.doneWithNoData) {
        return ContentEmptyOrdersPageWidget();
      }
      return _buildOrdersList();
    });
  }

  Widget _buildOrdersList() {
    return Column(
      children: [
        const SizedBox(height: AppSize.s16),
        Expanded(
          child: RefreshIndicator(
            onRefresh: controller.refreshOrders,
            color: ColorManager.colorPrimary,
            backgroundColor: ColorManager.colorWhite,
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverList.separated(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return _buildOrderCard(context, order);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSize.s8),
                ),
                if (controller.loadingMoreOrdersState.value ==
                    LoadingState.loading)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSize.s10,
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                SliverToBoxAdapter(child: SizedBox(height: AppSize.s8)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
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
                buildStatusBadge(order.orderStatus),
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
            if (order.orderStatus == 'pending') ...[
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

Widget buildStatusBadge(String status) {
  final Map<String, Map<String, dynamic>> statusMap = {
    'pending': {'color': ColorManager.colorPrimary, 'icon': Icons.access_time},
    'accepted': {'color': Colors.blue, 'icon': Icons.thumb_up_outlined},
    'rejected': {'color': Colors.red, 'icon': Icons.block},
    'on_the_way': {'color': Colors.orange, 'icon': Icons.delivery_dining},
    'completed': {'color': Colors.green, 'icon': Icons.check_circle_outline},
    'cancelled': {'color': Colors.red, 'icon': Icons.cancel_outlined},
  };

  final statusData =
      statusMap[status] ?? {'color': Colors.grey, 'icon': Icons.info_outline};

  final Color color = statusData['color'];
  final IconData icon = statusData['icon'];

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppPadding.p12,
      vertical: AppPadding.p8,
    ),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppSize.s20),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSize.s14, color: color),
        const SizedBox(width: AppSize.s4),
        Text(
          status.tr,
          style: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}
