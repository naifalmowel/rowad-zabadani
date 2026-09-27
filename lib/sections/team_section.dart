import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  Future<void> _watchTeamVideo() async {
    final url = Uri.parse('https://youtube.com/shorts/ACjxJvKcWss');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.border, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: colors.isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: isMobile
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildVideoThumbnail(context),
                    const SizedBox(height: 32),
                    _buildContent(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildContent(context),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 5,
                      child: _buildVideoThumbnail(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_fire_department_rounded, color: colors.gold, size: 28),
            const SizedBox(width: 8),
            Text(
              'عز وفخر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.gold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'هالشباب اللي بيرفعوا الراس بالعلالي',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF7A2027).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF7A2027).withValues(alpha: 0.4)),
          ),
          child: Text(
            '🔥 لما ندوس ع الأرض... بنزلزلها!',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.gold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'شباب تربينا على صوت الطبل والمجوز الأصيل، عشقنا الدبكة وورثناها أبا عن جد من قلب الزبداني. ما عنا لغة رسمية ولا حكي صفّ كلام... نحن فعل بالساحة، من أول زقفة لآخر دبكة، منعرف كيف نخلي الصالة كلها تقوم وتدبك وما حدا يقعد!',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: colors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: _watchTeamVideo,
          icon: const Icon(Icons.play_circle_filled_rounded, color: Colors.white, size: 24),
          label: const Text(
            'شاهد فيديو التعرف على الشباب',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7A2027),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoThumbnail(BuildContext context) {
    final colors = AppColors.of(context);

    return InkWell(
      onTap: _watchTeamVideo,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Dark background fill
              Container(color: Colors.black),
              // Uncropped image using contain so no team member is cropped out
              Center(
                child: Image.asset(
                  'assets/images/6.webp',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              // Cinematic Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Bottom caption banner
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colors.gold.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        'اضغط لمشاهدة فيديو الشباب',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: colors.gold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
