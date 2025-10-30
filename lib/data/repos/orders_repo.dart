import 'package:gas_user_app/core/services/network_service/api.dart';
import 'package:gas_user_app/core/services/network_service/error_handler.dart';
import 'package:gas_user_app/core/services/network_service/remote_api_service.dart';
import 'package:gas_user_app/data/models/app_response.dart';
import 'package:gas_user_app/data/models/order_model.dart';
import 'package:gas_user_app/data/models/paginated_model.dart';
import 'package:gas_user_app/data/models/review_model.dart';
import 'package:get/get.dart';

class OrderRepo extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<AppResponse<OrderModel>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    AppResponse<OrderModel> appResponse = AppResponse(success: false);

    try {
      final response = await apiService.request(
        url: Api.orders,
        method: Method.post,
        requiredToken: true,
        withLogging: true,
        params: orderData,
      );
      appResponse.success = true;
      // appResponse.data = OrderModel.fromJson(
      //   response.data['data']?['order'] ?? {},
      // );
      appResponse.successMessage = response.data['message'];
    } catch (e) {
      appResponse.success = false;
      appResponse.networkFailure = ErrorHandler.handle(e).failure;
    }
    return appResponse;
  }

  Future<AppResponse<PaginatedModel<OrderModel>>> getOrders({
    required int page,
    int pageSize = 10,
  }) async {
    AppResponse<PaginatedModel<OrderModel>> appResponse = AppResponse(
      success: false,
    );

    try {
      final response = await apiService.request(
        url: Api.myOrders,
        method: Method.get,
        requiredToken: true,
        withLogging: true,
        queryParameters: {'page': page, 'per_page': pageSize},
      );
      appResponse.success = true;
      appResponse.data = PaginatedModel<OrderModel>.fromJson(
        response.data ?? {},
        (e) => OrderModel.fromJson(e),
      );
      appResponse.successMessage = response.data['message'];
    } catch (e) {
      appResponse.success = false;
      appResponse.networkFailure = ErrorHandler.handle(e).failure;
    }
    return appResponse;
  }

  Future<AppResponse<OrderModel>> getOrderById(int orderId) async {
    AppResponse<OrderModel> appResponse = AppResponse(success: false);

    try {
      final response = await apiService.request(
        url: '${Api.orders}/$orderId',
        method: Method.get,
        requiredToken: true,
        withLogging: true,
      );

      appResponse.success = true;
      appResponse.data = OrderModel.fromJson(
        response.data?['data']?['order'] ?? {},
      );
      appResponse.successMessage = response.data['message'];
    } catch (e) {
      appResponse.success = false;
      appResponse.networkFailure = ErrorHandler.handle(e).failure;
    }

    return appResponse;
  }

  Future<AppResponse<void>> cancelOrder(int orderId) async {
    AppResponse<void> appResponse = AppResponse(success: false);

    try {
      final response = await apiService.request(
        url: '${Api.orders}/$orderId/cancel',
        method: Method.post,
        requiredToken: true,
        withLogging: true,
      );
      appResponse.success = true;
      appResponse.successMessage =
          response.data['message'] ?? 'Order cancelled successfully';
    } catch (e) {
      appResponse.success = false;
      appResponse.networkFailure = ErrorHandler.handle(e).failure;
    }
    return appResponse;
  }

  Future<AppResponse<void>> submitOrderReview(
    int orderId,
    ReviewModel review,
  ) async {
    AppResponse<void> appResponse = AppResponse(success: false);

    try {
      final response = await apiService.request(
        url: '${Api.orders}/$orderId/review',
        method: Method.post,
        requiredToken: true,
        withLogging: true,
        params: review.toJson(),
      );
      appResponse.success = true;
      appResponse.successMessage =
          response.data['message'] ?? 'Review submitted successfully';
    } catch (e) {
      appResponse.success = false;
      appResponse.networkFailure = ErrorHandler.handle(e).failure;
    }
    return appResponse;
  }
}
