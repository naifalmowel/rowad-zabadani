import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildSocialButton({
    required FaIconData icon,
    required String tooltip,
    required String url,
    required AppColors colors,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surface,
        border: Border.all(
          color: colors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.isDark ? Colors.black38 : Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: IconButton(
        icon: FaIcon(
          icon,
          color: iconColor ?? colors.textPrimary,
          size: 20,
        ),
        tooltip: tooltip,
        onPressed: () => _launchURL(url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      color: colors.isDark ? const Color(0xFF070706) : const Color(0xFFECE8DF),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.webp',
            height: 60,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.stars,
              color: colors.gold,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'فرقة روّاد الزبداني',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'الدبكة إلها ناسها',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: colors.gold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.instagram,
                tooltip: 'انستغرام',
                url: 'https://www.instagram.com/rowad_alzabadani?stkn=Z2x5bTRxbnRjMmQ2',
                iconColor: const Color(0xFFE4405F),
                colors: colors,
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.facebook,
                tooltip: 'فيسبوك',
                url: 'https://www.facebook.com/share/1D95bG82Dw/',
                iconColor: const Color(0xFF1877F2),
                colors: colors,
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.youtube,
                tooltip: 'يوتيوب',
                url: 'https://youtube.com/@rowadalzabadani?si=x2pGGOmOJEWfbH5U',
                iconColor: const Color(0xFFFF0000),
                colors: colors,
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.whatsapp,
                tooltip: 'واتساب',
                url: 'https://wa.me/963936522543?text=${Uri.encodeComponent("مرحبا، بدي استفسر عن حجز فرقة روّاد الزبداني لمناسبتي.")}',
                iconColor: const Color(0xFF25D366),
                colors: colors,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: colors.divider),
          const SizedBox(height: 16),
          Text(
            '© 2026 فرقة روّاد الزبداني. جميع الحقوق محفوظة.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
