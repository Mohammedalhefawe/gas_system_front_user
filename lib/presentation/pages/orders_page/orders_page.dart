import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/pages/orders_page/orders_controller.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/content_data_orders_widget.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/content_empty_orders_widget.dart';
import 'package:gas_user_app/presentation/pages/orders_page/widgets/shimmer_orders_page_widget.dart';
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
      return ContentDataOrdersWidget();
    });
  }
}
