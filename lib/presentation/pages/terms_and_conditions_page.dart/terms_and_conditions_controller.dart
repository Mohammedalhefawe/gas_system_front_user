import 'package:gas_user_app/data/enums/loading_state_enum.dart';
import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {
  final loadingState = LoadingState.loading.obs;
  final termsContent = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTermsAndConditions();
  }

  void _loadTermsAndConditions() async {
    // Mock terms data - in real app, this would come from API
    termsContent.value = {
      'lastUpdated': '2025-11-1',
      'version': '1.0',
      'content_en': '''
1. Acceptance of Terms
By using the Gas Delivery App, you accept and agree to be bound by the terms and conditions set forth in this agreement.

2. User Responsibilities
- You must provide accurate and complete registration information
- You are responsible for maintaining the confidentiality of your account
- You agree to use the service for lawful purposes only

3. Service Usage
- The app is dedicated for booking and delivering gas cylinders
- Users must provide accurate delivery addresses
- Delivery times are estimates and may vary depending on circumstances

4. Payment Terms
- Prices are subject to change without prior notice

5. Safety Guidelines
- Ensure proper ventilation when handling gas cylinders
- Do not smoke or use open flame sources near gas cylinders
- Store cylinders in an upright position in well-ventilated areas

6. Cancellation Policy
- Orders can be cancelled as long as the order has not been accepted or before you are contacted by the delivery worker to confirm the order
- Repeated cancellations may affect your account status

7. Liability
- We are not liable for damages resulting from improper use of gas products
- Users must follow all provided safety instructions
- The company reserves the right to refuse service

8. Privacy
- Your personal information is protected according to the privacy policy
- We collect only necessary data for service provision
- Data is not shared with third parties without your consent

9. Modifications
- Terms may be updated periodically
- Continued use after changes constitutes acceptance
- Users will be notified of significant changes

10. Contact
For inquiries about these terms, please contact us through the app or customer service channels.
''',
      'content_ar': '''
1. قبول الشروط والأحكام
باستخدامك تطبيق توصيل الغاز، فإنك تقبل وتوافق على الالتزام بالشروط والأحكام الواردة في هذه الاتفاقية.

2. مسؤوليات المستخدم
- يجب تقديم معلومات تسجيل دقيقة وكاملة
- أنت مسؤول عن الحفاظ على سرية حسابك
- توافق على استخدام الخدمة للأغراض القانونية فقط

3. استخدام الخدمة
- التطبيق مخصص لحجز وتوصيل اسطوانات الغاز
- يجب على المستخدمين تقديم عناوين توصيل دقيقة
- أوقات التوصيل تقديرية وقد تختلف حسب الظروف

4. شروط الدفع
- الأسعار قابلة للتغيير دون إشعار مسبق

5. إرشادات السلامة
- تأكد من التهوية المناسبة عند التعامل مع اسطوانات الغاز
- لا تدخن أو تستخدم مصادر لهب مكشوفة بالقرب من اسطوانات الغاز
- قم بتخزين الاسطوانات في وضع قائم في أماكن جيدة التهوية

6. سياسة الإلغاء
- يمكن إلغاء الطلبات طالما لم يتم قبول الطلب او قبل الاتصال بك من قبل عامل التوصيل لتاكيد الطلب    
- التكرار في الإلغاء قد يؤثر على حالة حسابك

7. المسؤولية
- نحن لسنا مسؤولين عن الأضرار الناتجة عن الاستخدام غير السليم لمنتجات الغاز
- يجب على المستخدمين اتباع جميع تعليمات السلامة المقدمة
- تحتفظ الشركة بالحق في رفض تقديم الخدمة

8. الخصوصية
- معلوماتك الشخصية محمية وفقًا لسياسة الخصوصية
- نجمع فقط البيانات الضرورية لتقديم الخدمة
- لا يتم مشاركة البيانات مع أطراف ثالثة دون موافقتك

9. التعديلات
- قد يتم تحديث الشروط بشكل دوري
- الاستمرار في الاستخدام بعد التغييرات يعني القبول بها
- سيتم إخطار المستخدمين بالتغييرات الهامة

10. التواصل
للاستفسارات حول هذه الشروط، يرجى التواصل معنا عبر التطبيق أو قنوات خدمة العملاء.
''',
    };

    loadingState.value = LoadingState.doneWithData;
  }
}
