import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  Future<void> _launchWhatsApp() async {
    const phone = "963936522543";
    final message = Uri.encodeComponent("مرحبا، بدي استفسر عن حجز فرقة روّاد الزبداني لمناسبتي.");
    final url = Uri.parse("https://wa.me/$phone?text=$message");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _makeCall() async {
    final url = Uri.parse("tel:+963936522543");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF7A2027), Color(0xFF3A0F12)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 25,
                spreadRadius: 3,
              )
            ],
          ),
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'خلّي فرحتكم على إيقاع الروّاد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: isMobile ? 28 : 44,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFF3EBDD),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'احكيلنا عن مناسبتك، واترك الباقي علينا لنولعك الساحة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: isMobile ? 16 : 20,
                  color: const Color(0xFFF3EBDD).withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: _launchWhatsApp,
                    icon: const Icon(Icons.chat, color: Colors.white, size: 22),
                    label: const Text(
                      'احجز الفرقة على واتساب',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _makeCall,
                    icon: const Icon(Icons.phone, color: Color(0xFF7A2027), size: 22),
                    label: const Text(
                      'اتصل فينا مباشرة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF7A2027),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3EBDD),
                      foregroundColor: const Color(0xFF7A2027),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                '+963 936 522 543',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF3EBDD),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
