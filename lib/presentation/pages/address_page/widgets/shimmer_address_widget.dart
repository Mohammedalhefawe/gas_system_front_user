import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAddressWidget extends StatelessWidget {
  const ShimmerAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s8),
        Expanded(
          child: ListView.separated(
            itemCount: 3, // Show 3 shimmer placeholders
            itemBuilder: (context, index) => _buildShimmerAddressItem(),
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSize.s8),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerAddressItem() {
    return Shimmer.fromColors(
      baseColor: ColorManager.colorGrey2.withValues(alpha: 0.3),
      highlightColor: ColorManager.colorGrey2.withValues(alpha: 0.1),
      child: Container(
        color: ColorManager.colorWhite,
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with address name placeholder
            Row(
              children: [
                Container(
                  width: AppSize.s26,
                  height: AppSize.s26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
                const SizedBox(width: AppSize.s12),
                Container(width: 120, height: 18, color: Colors.white),
              ],
            ),
            const SizedBox(height: AppSize.s12),
            // Address details placeholder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: AppSize.s4),
                Row(
                  children: [
                    Container(
                      width: AppSize.s16,
                      height: AppSize.s16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: AppSize.s6),
                    Container(width: 100, height: 14, color: Colors.white),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            // Divider placeholder
            Container(height: 1, color: Colors.white),
            const SizedBox(height: AppSize.s12),
            // Action buttons placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSize.s8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
