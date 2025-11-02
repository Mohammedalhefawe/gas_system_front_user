import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/custom_widgets/normal_app_bar.dart';
import 'package:gas_user_app/presentation/pages/add_review_order_page/add_review_order_controller.dart';
import 'package:gas_user_app/presentation/pages/add_review_order_page/widgets/content_add_review_order_widget.dart';
import 'package:get/get.dart';

class AddReviewOrderPage extends GetView<AddReviewOrderPageController> {
  const AddReviewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: NormalAppBar(title: 'AddReview'.tr, backIcon: true),
        body: ContentAddReviewWidget(controller: controller),
      ),
    );
  }
}
