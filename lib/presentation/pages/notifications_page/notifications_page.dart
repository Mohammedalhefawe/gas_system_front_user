import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/widgets/content_data_notifications_page_widget.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/widgets/content_empty_notifications_page_widget.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/widgets/content_error_notifications_page_widget.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/widgets/shimmer_notifications_page_widget.dart';
import 'package:get/get.dart';
import 'notifications_page_controller.dart';

class NotificationsScreen extends GetView<NotificationsPageController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Notifications'.tr, backIcon: true),
      body: Obx(() {
        if (controller.loadingNotificationsState.value ==
            LoadingState.loading) {
          return ShimmerNotificationsWidget();
        }
        if (controller.loadingNotificationsState.value ==
            LoadingState.hasError) {
          return ContentErrorNotificationsWidget(controller: controller);
        }
        if (controller.notifications.isEmpty) {
          return ContentEmptyNotificationsWidget();
        }
        return ContentWithDataNotificationsWidget(controller: controller);
      }),
    );
  }
}
