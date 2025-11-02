import 'package:flutter/material.dart';
import 'package:gas_user_app/core/app_config/app_translation.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';

class ProfileDetailRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ProfileDetailRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppSize.s20, color: ColorManager.colorDoveGray600),
        const SizedBox(width: AppSize.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.colorDoveGray600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSize.s4),
              Text(
                value,
                textDirection: AppTranslations.isArabic
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.colorFontPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
