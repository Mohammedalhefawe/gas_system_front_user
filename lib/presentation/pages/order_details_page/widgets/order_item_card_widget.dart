import 'package:flutter/material.dart';
import 'package:gas_user_app/data/models/order_model.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class OrderItemsCardWidget extends StatelessWidget {
  final OrderItemModel item;
  const OrderItemsCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.colorGrey0,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
          color: ColorManager.colorGrey2.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.product.productName,
                  style: TextStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.colorFontPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${double.parse(item.subtotal).toStringAsFixed(0)} ${'SP'.tr}',
                style: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.colorPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'Quantity'.tr}: ${item.quantity}',
                style: TextStyle(
                  fontSize: FontSize.s13,
                  color: ColorManager.colorDoveGray600,
                ),
              ),
              Text(
                '${'each'.tr} ${double.parse(item.unitPrice).toStringAsFixed(0)} ${'SP'.tr}',
                style: TextStyle(
                  fontSize: FontSize.s13,
                  color: ColorManager.colorDoveGray600,
                ),
              ),
            ],
          ),
          if (item.productNotes != null) ...[
            const SizedBox(height: AppSize.s8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: ColorManager.colorWhite,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Text(
                '${'Notes'.tr}: ${item.productNotes}',
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.colorDoveGray600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
