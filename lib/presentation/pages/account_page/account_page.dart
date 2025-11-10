import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/pages/account_page/account_controller.dart';
import 'package:gas_user_app/presentation/pages/account_page/widgets/options_account_widget.dart';
import 'package:gas_user_app/presentation/pages/account_page/widgets/profile_card_widget.dart';
import 'package:gas_user_app/presentation/pages/account_page/widgets/shimmer_account_page_widget.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AccountController());
    return Obx(() {
      if (controller.loadingState.value == LoadingState.loading) {
        return ShimmerAccountPageWidget();
      }
      return _buildAccountContent();
    });
  }

  Widget _buildAccountContent() {
    final user = controller.user.value;
    if (user == null) return ShimmerAccountPageWidget();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: AppSize.s16),
              ProfileCardWidget(user: user),
              const SizedBox(height: AppSize.s20),
              OptionsSectionWidget(),
              const SizedBox(height: AppSize.s20),
            ],
          ),
        ),
      ],
    );
  }
}
