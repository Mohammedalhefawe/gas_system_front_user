import 'package:flutter/material.dart';
import 'package:gas_user_app/core/app_config/app_translation.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/terms_and_conditions_page.dart/terms_and_conditions_controller.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class TermsAndConditionsPage extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TermsAndConditionsController());
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorManager.colorGrey0,
        appBar: NormalAppBar(title: 'TermsAndConditions'.tr, backIcon: true),
        body: Obx(() {
          return _buildTermsAndConditions(context);
        }),
      ),
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    final terms = controller.termsContent;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSize.s8),

          // Terms Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppPadding.p20),
            decoration: BoxDecoration(color: ColorManager.colorWhite),
            child: Column(
              children: [
                Container(
                  width: AppSize.s60,
                  height: AppSize.s60,
                  decoration: BoxDecoration(
                    color: ColorManager.colorPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.description,
                    size: AppSize.s40,
                    color: ColorManager.colorPrimary,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Text(
                  'TermsAndConditions'.tr,
                  style: TextStyle(
                    fontSize: FontSize.s24,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.colorFontPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  "${'LastUpdated'.tr}${terms['lastUpdated']!}",
                  style: TextStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.colorDoveGray600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  "${'Version'.tr}${terms['version']!}",
                  style: TextStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.colorDoveGray600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSize.s8),

          // Terms Content Card
          _buildTermsContentCard(
            terms[AppTranslations.isArabic ? 'content_ar' : 'content_en']!,
          ),

          const SizedBox(height: AppSize.s20),
        ],
      ),
    );
  }

  Widget _buildTermsContentCard(String content) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.colorWhite),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TermsOfUse'.tr,
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
                color: ColorManager.colorFontPrimary,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Text(
              content,
              style: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.colorFontPrimary,
                height: 1.6,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: AppSize.s20),
            _buildAcceptanceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptanceSection() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.colorPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: ColorManager.colorPrimary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: AppSize.s20,
            color: ColorManager.colorPrimary,
          ),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Text(
              'TermsAcceptanceNote'.tr,
              style: TextStyle(
                fontSize: FontSize.s13,
                color: ColorManager.colorFontPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
