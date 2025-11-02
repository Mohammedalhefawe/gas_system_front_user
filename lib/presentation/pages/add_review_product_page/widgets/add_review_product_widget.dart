import 'package:flutter/material.dart';
import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:gas_user_app/presentation/custom_widgets/app_button.dart';
import 'package:gas_user_app/presentation/custom_widgets/custom_text_field.dart';
import 'package:gas_user_app/presentation/pages/add_review_product_page/add_review_product_controller.dart';
import 'package:gas_user_app/presentation/util/resources/color_manager.dart';
import 'package:gas_user_app/presentation/util/resources/values_manager.dart';
import 'package:get/get.dart';

class ContentAddReviewProductWidget extends StatelessWidget {
  const ContentAddReviewProductWidget({super.key, required this.controller});

  final AddReviewPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RateProduct'.tr, style: Get.textTheme.titleMedium),
              const SizedBox(height: AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => controller.setRating(index + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p4,
                      ),
                      child: Icon(
                        controller.rating.value >= index + 1
                            ? Icons.star
                            : Icons.star_border,
                        color: ColorManager.colorPrimary,
                        size: AppSize.s40,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSize.s16),
              CustomTextField(
                requiredField: true,
                title: 'Review'.tr,
                hint: 'EnterReview'.tr,
                textEditingController: controller.reviewController,
                textInputType: TextInputType.multiline,
                minLines: 3,
                maxLines: 3,
                fillColor: ColorManager.colorWhite,
                borderRadius: AppSize.s8,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'RequiredReview'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSize.s16),
              AppButton(
                loadingMode:
                    controller.loadingState.value == LoadingState.loading,
                onPressed: controller.submitReview,
                text: 'SubmitReview'.tr,
                backgroundColor: ColorManager.colorPrimary,
              ),
            ],
          ),
        ),
      );
    });
  }
}
