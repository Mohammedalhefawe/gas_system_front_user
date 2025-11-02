import 'package:flutter/material.dart';
import 'package:gas_user_app/data/models/user_model.dart';
import 'package:gas_user_app/presentation/pages/account_page/widgets/profile_details_row_widget.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class ProfileCardWidget extends StatelessWidget {
  final UserModel user;
  const ProfileCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
        color: ColorManager.colorWhite,
        borderRadius: BorderRadius.circular(AppSize.s20),
        boxShadow: [
          BoxShadow(
            color: ColorManager.colorBlack.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Header
          Row(
            children: [
              Container(
                width: AppSize.s60,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.colorDoveGray100,
                  border: Border.all(
                    color: ColorManager.colorDoveGray300,
                    width: 2,
                  ),
                ),
                child: Assets.images.user.image(),
              ),
              const SizedBox(width: AppSize.s16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.colorFontPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSize.s4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8,
                        vertical: AppPadding.p4,
                      ),
                      decoration: BoxDecoration(
                        color: user.isVerified
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            user.isVerified ? Icons.verified : Icons.pending,
                            size: AppSize.s12,
                            color: user.isVerified
                                ? Colors.green
                                : Colors.orange,
                          ),
                          const SizedBox(width: AppSize.s4),
                          Text(
                            user.isVerified ? 'Verified'.tr : 'Verified'.tr,
                            style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w600,
                              color: user.isVerified
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSize.s20),

          // Divider
          Container(
            height: 1,
            color: ColorManager.colorGrey2.withValues(alpha: 0.3),
          ),

          const SizedBox(height: AppSize.s16),

          // Phone Number
          ProfileDetailRowWidget(
            icon: Icons.phone_android_outlined,
            label: 'phone'.tr,
            value: user.phoneNumber,
          ),
        ],
      ),
    );
  }
}
