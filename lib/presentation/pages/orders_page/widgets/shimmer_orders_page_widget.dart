import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrdersPageWidget extends StatelessWidget {
  const ShimmerOrdersPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.colorGrey2.withValues(alpha: 0.3),
      highlightColor: ColorManager.colorGrey2.withValues(alpha: 0.1),
      child: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 0) const SizedBox(height: AppSize.s16),

                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16,
                    ),
                    padding: const EdgeInsets.all(AppPadding.p20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.s16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  height: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: AppSize.s6),
                                Container(
                                  width: 80,
                                  height: 14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Container(
                              width: 70,
                              height: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: AppSize.s8),
                            Container(
                              width: 200,
                              height: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                        Container(height: 1, color: Colors.white),
                        const SizedBox(height: AppSize.s16),
                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSize.s8),
                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSize.s8),
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSize.s16),
                        Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSize.s8),
          ),
        ],
      ),
    );
  }
}
