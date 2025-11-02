import 'package:flutter/material.dart';
import 'package:gas_user_app/core/app_config/app_translation.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/company_info_page/company_info_controller.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class CompanyInfoPage extends GetView<CompanyInfoController> {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CompanyInfoController());
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorManager.colorGrey0,
        appBar: NormalAppBar(title: 'CompanyInfo'.tr, backIcon: true),
        body: Obx(() {
          return _buildCompanyInfo(context);
        }),
      ),
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {
    final company = controller.companyInfo;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSize.s8),

          // Company Header Card
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
                    Icons.business,
                    size: AppSize.s40,
                    color: ColorManager.colorPrimary,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Text(
                  company['name']!,
                  textDirection: AppTranslations.isArabic
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  style: TextStyle(
                    fontSize: FontSize.s24,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.colorFontPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  'GasDeliveryCompany'.tr,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.colorDoveGray600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSize.s8),

          // Company Description Card
          _buildInfoCard(
            title: 'AboutUs'.tr,
            children: [
              Text(
                "DescriptionCompany".tr,
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.colorFontPrimary,
                  height: 1.6,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          const SizedBox(height: AppSize.s8),

          // Contact Information Card
          _buildInfoCard(
            title: 'ContactInformation'.tr,
            children: [
              _buildContactRow(
                Icons.phone,
                'Phone'.tr,
                company['phone']!,
                onTap: () => controller.launchPhoneCall(company['phone']!),
              ),
              _buildContactRow(
                Icons.email,
                'Email'.tr,
                company['email']!,
                onTap: () => controller.launchEmail(company['email']!),
              ),
              _buildContactRow(
                Icons.location_on,
                'Address'.tr,
                company['address']!,
              ),
            ],
          ),

          const SizedBox(height: AppSize.s8),

          // Action Buttons Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppPadding.p20),
            decoration: BoxDecoration(color: ColorManager.colorWhite),
            child: Column(
              children: [
                AppButton(
                  onPressed: () =>
                      controller.launchPhoneCall(company['phone']!),
                  text: 'CallUs'.tr,
                  backgroundColor: ColorManager.colorPrimary,
                  fontColor: ColorManager.colorWhite,
                  icon: Icon(Icons.phone, color: ColorManager.colorWhite),
                ),
                const SizedBox(height: AppSize.s12),
                AppButton(
                  onPressed: () => controller.launchEmail(company['email']!),
                  text: 'SendEmail'.tr,
                  backgroundColor: ColorManager.colorWhite,
                  border: Border.all(
                    width: 1,
                    color: ColorManager.colorPrimary,
                  ),
                  fontColor: ColorManager.colorPrimary,
                  icon: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: ColorManager.colorPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSize.s20),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.colorWhite),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
                color: ColorManager.colorFontPrimary,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: AppSize.s22, color: ColorManager.colorPrimary),
            const SizedBox(width: AppSize.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManager.colorDoveGray600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text(
                    value,
                    textDirection: AppTranslations.isArabic
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      color: onTap != null
                          ? ColorManager.colorPrimary
                          : ColorManager.colorFontPrimary,
                      fontWeight: onTap != null
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: AppSize.s16,
                color: ColorManager.colorDoveGray300,
              ),
          ],
        ),
      ),
    );
  }
}
