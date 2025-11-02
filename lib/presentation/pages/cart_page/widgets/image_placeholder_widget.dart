import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  const ImagePlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.colorGrey1,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Center(
        child: Icon(
          Icons.gas_meter_rounded,
          size: AppSize.s34,
          color: ColorManager.colorGrey2,
        ),
      ),
    );
  }
}
