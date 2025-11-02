import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gas_user_app/data/repos/notification_repo.dart';
import 'package:get/get.dart';
import 'package:gas_user_app/core/services/cache_service.dart';
import 'package:gas_user_app/data/repos/users_repo.dart';

const homeTabIndex = 0;
const ordersTabIndex = 1;
const accountTabIndex = 2;

class MainController extends GetxController {
  final UsersRepo usersRepo = Get.find<UsersRepo>();
  final CacheService cacheService = Get.find<CacheService>();
  final NotificationRepo notificationRepo = Get.find<NotificationRepo>();
  ScrollController scrollController = ScrollController();
  final showNavBar = true.obs;
  PageController pageController = PageController(initialPage: homeTabIndex);
  final pageIndex = homeTabIndex.obs;
  RxInt notificationsCount = 0.obs;

  void changePage(int newIndex) {
    pageIndex.value = newIndex;
    pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void _scrollListener() async {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      await (0.3).delay();
      // Scrolling down
      if (showNavBar.value) {
        showNavBar.value = false;
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      await (0.3).delay();
      // Scrolling up
      if (!showNavBar.value) {
        showNavBar.value = true;
      }
    }
  }

  Future<void> fetchNotificationsCount() async {
    final response = await notificationRepo.getUnreadNotificationsCount();
    if (!response.success || response.data == null) {
      notificationsCount.value = 0;
      return;
    }
    notificationsCount.value = response.data!;
  }

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  Future<void> init() async {
    // usersRepo.checkUserLoggedInState();
    scrollController.addListener(_scrollListener);
    fetchNotificationsCount();
  }
}
