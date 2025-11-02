import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class ContentEmptyCartWidget extends StatelessWidget {
  const ContentEmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: AppSize.s60,
            color: ColorManager.colorDoveGray600,
          ),
          const SizedBox(height: AppSize.s16),
          Text(
            'CartEmpty'.tr,
            style: TextStyle(
              fontSize: FontSize.s18,
              color: ColorManager.colorDoveGray600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            'AddItemsToCart'.tr,
            style: TextStyle(
              fontSize: FontSize.s14,
              color: ColorManager.colorDoveGray600,
            ),
          ),
        ],
      ),
    );
  }
}
