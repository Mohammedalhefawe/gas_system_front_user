import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/pages/account_page/account_controller.dart';
import 'package:gas_user_app/presentation/pages/company_info_page/company_info_page.dart';
import 'package:gas_user_app/presentation/pages/terms_and_conditions_page.dart/terms_and_conditions_page.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/navigation_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class OptionsSectionWidget extends GetView<AccountController> {
  const OptionsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
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
          _buildOptionItem(
            icon: Assets.icons.languageIcon,
            text: 'change_language'.tr,
            description: 'ChangeAppLanguage'.tr,
            onTap: () => controller.showLanguageDialog(Get.context!),
          ),
          _buildDivider(),
          _buildOptionItem(
            icon: Assets.icons.locationIcon,
            text: 'my_addresses'.tr,
            description: 'ManageYourAddresses'.tr,
            onTap: () => Get.toNamed(AppRoutes.addressRoute),
          ),
          _buildDivider(),
          _buildOptionItem(
            icon: Assets.icons.helpIcon,
            text: 'AboutCompany'.tr,
            description: 'ReadAboutCompany'.tr,
            onTap: () {
              Get.to(() => CompanyInfoPage());
            },
          ),
          _buildDivider(),
          _buildOptionItem(
            icon: Assets.icons.summaryIcon,
            text: 'terms_conditions'.tr,
            description: 'ReadTermsConditions'.tr,
            onTap: () {
              Get.to(() => TermsAndConditionsPage());
            },
          ),
          _buildDivider(),
          _buildOptionItem(
            icon: Assets.icons.logoutIcon,
            text: 'logout'.tr,
            description: 'SignOutFromAccount'.tr,
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () => controller.showLogoutConfirmation(Get.context!),
          ),
        ],
      ),
    );
  }
}

Widget _buildOptionItem({
  required SvgGenImage icon,
  required String text,
  required String description,
  Color textColor = Colors.black,
  Color? iconColor,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppSize.s12),
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Row(
        children: [
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            decoration: BoxDecoration(
              color: textColor == Colors.red
                  ? Colors.red.withValues(alpha: 0.1)
                  : ColorManager.colorPrimary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon.svg(
                width: AppSize.s20,
                colorFilter: ColorFilter.mode(
                  textColor == Colors.red
                      ? Colors.red
                      : ColorManager.colorPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSize.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: FontSize.s13,
                    color: ColorManager.colorDoveGray600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: AppSize.s16,
            color: ColorManager.colorDoveGray600,
          ),
        ],
      ),
    ),
  );
}

Widget _buildDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
    child: Divider(
      height: 1,
      color: ColorManager.colorGrey2.withValues(alpha: 0.3),
    ),
  );
}
