import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    final services = [
      {
        'title': 'الأعراس',
        'desc': 'بدك ليلة ما حدا ينساها؟ نحنا جاهزين.',
        'image': 'assets/images/s1.webp',
      },
      {
        'title': 'الزفّة',
        'desc': 'من أول خطوة... بدها تكون على أصولها وجو يزلزل الساحة.',
        'image': 'assets/images/s2.webp',
      },
      {
        'title': 'الافتتاحات',
        'desc': 'عندك افتتاح جديد؟ خلّيه يبلّش بصوت الدبكةوالزفة.',
        'image': 'assets/images/s3.webp',
      },
      {
        'title': 'الحفلات والمناسبات',
        'desc': 'أي مناسبة إلها جو... ونحنا منعرف كيف نعمل الجو الصح.',
        'image': 'assets/images/s4.webp',
      },
    ];

    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            'وين بدك إيانا؟',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 3,
            width: 60,
            color: colors.gold,
          ),
          const SizedBox(height: 50),
          // Cards Layout
          isMobile
              ? Column(
                  children: services.map((s) => _buildCard(s, true, colors)).toList(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return _buildCard(services[index], false, colors);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, String> service, bool isMobile, AppColors colors) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 20 : 0),
      height: isMobile ? 220 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: colors.isDark ? Colors.black45 : Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                service['image']!,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient Overlay for text contrast
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Color(0xE60B0B0A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    service['title']!,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC49A5A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['desc']!,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15,
                      color: Color(0xFFF3EBDD),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
