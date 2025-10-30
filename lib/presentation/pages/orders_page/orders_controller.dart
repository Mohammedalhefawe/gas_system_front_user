import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/data/models/order_model.dart';
import 'package:gas_user_app/data/repos/delivery_fee_repo.dart';
import 'package:gas_user_app/data/repos/orders_repo.dart';
import 'package:gas_user_app/presentation/custom_widgets/custom_toasts.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class OrdersPageController extends GetxController {
  final OrderRepo orderRepo = Get.find<OrderRepo>();
  final DeliveryFeeRepo deliveryFeeRepo = Get.find<DeliveryFeeRepo>();
  final orders = <OrderModel>[].obs;
  final loadingState = LoadingState.idle.obs;
  final loadingMoreOrdersState = LoadingState.idle.obs;
  final currentPage = 1.obs;
  final lastPage = 1.obs;
  final hasMorePages = false.obs;
  final ScrollController scrollController = ScrollController();
  RxInt deliveryFee = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders(page: 1);
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      loadMoreOrders();
    }
  }

  Future<void> fetchOrders({required int page, int pageSize = 10}) async {
    if (loadingState.value == LoadingState.loading) return;
    loadingState.value = LoadingState.loading;

    final response = await orderRepo.getOrders(page: page, pageSize: pageSize);
    if (!response.success || response.data == null) {
      loadingState.value = LoadingState.hasError;
      CustomToasts(
        message: response.getErrorMessage(),
        type: CustomToastType.error,
      ).show();
      return;
    }

    if (page == 1) {
      orders.clear();
    }
    orders.addAll(response.data!.data);
    currentPage.value = response.data!.currentPage;
    lastPage.value = response.data!.lastPage;
    hasMorePages.value = currentPage.value < lastPage.value;

    loadingState.value = orders.isEmpty
        ? LoadingState.doneWithNoData
        : LoadingState.doneWithData;
  }

  Future<void> loadMoreOrders() async {
    if (loadingMoreOrdersState.value == LoadingState.loading ||
        !hasMorePages.value) {
      return;
    }

    loadingMoreOrdersState.value = LoadingState.loading;

    final nextPage = currentPage.value + 1;
    final response = await orderRepo.getOrders(page: nextPage);

    if (!response.success || response.data == null) {
      loadingMoreOrdersState.value = LoadingState.hasError;
      return;
    }

    orders.addAll(response.data!.data);
    currentPage.value = response.data!.currentPage;
    lastPage.value = response.data!.lastPage;
    hasMorePages.value = currentPage.value < lastPage.value;

    loadingMoreOrdersState.value = LoadingState.doneWithData;
  }

  Future<void> refreshOrders() async {
    orders.clear();
    currentPage.value = 1;
    lastPage.value = 1;
    hasMorePages.value = false;
    loadingState.value = LoadingState.idle;
    loadingMoreOrdersState.value = LoadingState.idle;
    await fetchOrders(page: 1);
  }

  Future<void> cancelOrder(int orderId) async {
    loadingState.value = LoadingState.loading;
    final response = await orderRepo.cancelOrder(orderId);
    if (!response.success) {
      loadingState.value = LoadingState.hasError;
      CustomToasts(
        message: response.getErrorMessage(),
        type: CustomToastType.error,
      ).show();
      return;
    }
    await refreshOrders();
    CustomToasts(
      message: response.successMessage ?? 'OrderCancelled'.tr,
      type: CustomToastType.success,
    ).show();
  }

  void showCancelConfirmation(BuildContext context, int orderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        title: Text(
          'CancelOrder'.tr,
          style: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeight.w600,
            color: ColorManager.colorFontPrimary,
          ),
        ),
        content: Text(
          'CancelOrderPrompt'.tr,
          style: TextStyle(
            fontSize: FontSize.s14,
            color: ColorManager.colorDoveGray600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'No'.tr,
              style: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.colorDoveGray600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cancelOrder(orderId);
            },
            child: Text(
              'Yes'.tr,
              style: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.colorPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
