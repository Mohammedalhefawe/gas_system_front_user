import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/address_page/address_page_controller.dart';
import 'package:gas_user_app/presentation/pages/address_page/select_location_page.dart';
import 'package:gas_user_app/presentation/pages/address_page/widgets/content_data_address_widget.dart';
import 'package:gas_user_app/presentation/pages/address_page/widgets/content_empty_address_widget.dart';
import 'package:gas_user_app/presentation/pages/address_page/widgets/content_error_address_widget.dart';
import 'package:gas_user_app/presentation/pages/address_page/widgets/shimmer_address_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:get/get.dart';

class AddressListPage extends GetView<AddressListController> {
  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Addresses'.tr, backIcon: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.setAddress(StatusLocation.add, address: null);
        },
        backgroundColor: ColorManager.colorPrimary,
        child: Assets.icons.locationIcon.svg(
          colorFilter: const ColorFilter.mode(
            ColorManager.colorWhite,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.loadingState.value == LoadingState.loading) {
          return ShimmerAddressWidget();
        }
        if (controller.loadingState.value == LoadingState.hasError) {
          return ContentErrorAddressPage(controller: controller);
        }
        if (controller.addresses.isEmpty) {
          return ContentEmptyAddressPage(controller: controller);
        }
        return ContentWithDataAddressPage(controller: controller);
      }),
    );
  }
}
