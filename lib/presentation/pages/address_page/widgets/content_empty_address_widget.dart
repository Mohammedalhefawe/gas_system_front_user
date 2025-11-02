import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/pages/address_page/address_page_controller.dart';
import 'package:gas_user_app/presentation/pages/address_page/select_location_page.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class ContentEmptyAddressPage extends StatelessWidget {
  const ContentEmptyAddressPage({super.key, required this.controller});

  final AddressListController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: AppSize.s60,
            color: ColorManager.colorDoveGray600,
          ),
          const SizedBox(height: AppSize.s16),
          Text(
            'NoAddresses'.tr,
            style: TextStyle(
              fontSize: FontSize.s18,
              color: ColorManager.colorDoveGray600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          GestureDetector(
            onTap: () => controller.setAddress(StatusLocation.add),
            child: Text(
              'AddAddressPrompt'.tr,
              style: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.colorDoveGray600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
