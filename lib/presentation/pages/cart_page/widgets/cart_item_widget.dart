import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gas_user_app/data/models/cart_item_model.dart';
import 'package:gas_user_app/presentation/pages/cart_page/cart_page_controller.dart';
import 'package:gas_user_app/presentation/pages/cart_page/widgets/image_placeholder_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.controller,
    required this.item,
  });

  final CartController controller;
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final totalItemPrice = item.product.price * item.quantity;

    return Container(
      color: ColorManager.colorWhite,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            Row(
              children: [
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: ColorManager.colorGrey5,
                  ),
                  child:
                      item.product.imageUrl != null &&
                          item.product.imageUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            item.product.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                ImagePlaceholderWidget(),
                          ),
                        )
                      : ImagePlaceholderWidget(),
                ),
                const SizedBox(width: AppSize.s12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.productName,
                                style: TextStyle(
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.colorFontPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppSize.s4),
                              Text(
                                item.product.description,
                                style: TextStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.colorDoveGray600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          // Remove item button
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Assets.icons.deleteIcon.svg(width: 22),
                              onPressed: () =>
                                  controller.removeFromCart(item.product.id),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.product.price.toStringAsFixed(0)} ${'SP'.tr}',
                            style: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.colorPrimary,
                            ),
                          ),
                          SizedBox(height: AppSize.s12),
                          // Quantity Controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Quantity controls with separated buttons
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Decrement button
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorManager.colorGrey4,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppSize.s6,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          AppSize.s6,
                                        ),
                                        onTap: item.quantity > 1
                                            ? () => controller.updateQuantity(
                                                item.product.id,
                                                item.quantity - 1,
                                              )
                                            : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            AppPadding.p4,
                                          ),
                                          child: Icon(
                                            Icons.remove_rounded,
                                            size: AppSize.s18,
                                            color: item.quantity > 1
                                                ? ColorManager.colorFontPrimary
                                                : ColorManager.colorDoveGray600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Quantity display
                                  Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorManager.colorFontPrimary,
                                      ),
                                    ),
                                  ),

                                  // Increment button
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorManager.colorGrey4,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppSize.s6,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          AppSize.s6,
                                        ),
                                        onTap: () => controller.updateQuantity(
                                          item.product.id,
                                          item.quantity + 1,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            AppPadding.p4,
                                          ),
                                          child: Icon(
                                            Icons.add_rounded,
                                            size: AppSize.s18,
                                            color:
                                                ColorManager.colorFontPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: AppSize.s12),

                              // Total price for this item
                              Text(
                                '${totalItemPrice.toStringAsFixed(0)} ${'SP'.tr}',
                                style: TextStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.colorDoveGray600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
