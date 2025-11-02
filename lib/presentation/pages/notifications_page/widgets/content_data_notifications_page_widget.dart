import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/notifications_page_controller.dart';
import 'package:gas_user_app/presentation/pages/notifications_page/widgets/item_notification_widget.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';

class ContentWithDataNotificationsWidget extends StatelessWidget {
  const ContentWithDataNotificationsWidget({
    super.key,
    required this.controller,
  });

  final NotificationsPageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: controller.refreshNotifications,
            color: ColorManager.colorPrimary,
            backgroundColor: ColorManager.colorWhite,
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverList.separated(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return NotificationItemWidget(
                      controller: controller,
                      notification: notification,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSize.s8),
                ),
                if (controller.loadingMoreNotificationsState.value ==
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
}
