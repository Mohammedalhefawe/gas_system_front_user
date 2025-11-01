import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyInfoController extends GetxController {
  final loadingState = LoadingState.loading.obs;
  final companyInfo = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCompanyInfo();
  }

  void _loadCompanyInfo() async {
    // Mock company data - in real app, this would come from API
    companyInfo.value = {
      'name': 'Gas Delivery Co.',
      'phone': '+963956012469',
      'email': 'info@gasdelivery.com',
      'address': '123 Main Street, City, Country',
    };

    loadingState.value = LoadingState.doneWithData;
  }

  void launchPhoneCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('Error'.tr, 'CannotMakeCall'.tr);
    }
  }

  void launchEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('Error'.tr, 'CannotSendEmail'.tr);
    }
  }
}
