import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/add_review_product_page/add_review_product_controller.dart';
import 'package:gas_user_app/presentation/pages/add_review_product_page/widgets/add_review_product_widget.dart';
import 'package:get/get.dart';

class AddReviewPage extends GetView<AddReviewPageController> {
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: NormalAppBar(title: 'AddReview'.tr, backIcon: true),
        body: ContentAddReviewProductWidget(controller: controller),
      ),
    );
  }
}
