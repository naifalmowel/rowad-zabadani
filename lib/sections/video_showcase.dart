import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../theme/app_colors.dart';

class VideoShowcase extends StatefulWidget {
  const VideoShowcase({super.key});

  @override
  State<VideoShowcase> createState() => _VideoShowcaseState();
}

class _VideoShowcaseState extends State<VideoShowcase> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> videos = const [
    {
      'title': 'الكاريزما الأولى على صعيد الدبكة',
      'tag': 'عرض رئيسي',
      'url': 'https://www.facebook.com/share/v/1C1atUWdQw/',
      'assetPath': 'assets/images/1.webp',
      'isVertical': true,
    },
    {
      'title': 'هيبتنا سبقتنا , والباقي مجرد تفاصيل',
      'tag': 'دبكة وشباب',
      'url': 'https://www.facebook.com/share/v/193TTWkqzF/',
      'assetPath': 'assets/images/2.webp',
      'isVertical': true,
    },
    {
      'title': 'شرارة بتولع الميدان... والدبكة',
      'tag': 'زفة العريس',
      'url': 'https://www.facebook.com/share/v/14pNBemfoHV/',
      'assetPath': 'assets/images/3.webp',
      'isVertical': false,
    },
    {
      'title': 'خطوة ورا خطوة , نحنا الأصل ..',
      'tag': 'أفراح',
      'url': 'https://www.facebook.com/share/v/19FtNkShWQ/',
      'assetPath': 'assets/images/4.webp',
      'isVertical': false,
    },
    {
      'title': 'فرحة الرّواد بزيرها..عريس',
      'tag': 'زفة العريس',
      'url': 'https://www.facebook.com/share/v/1EF3AXtcBR/',
      'assetPath': 'assets/images/5.webp',
      'isVertical': false,
    },
  ];

  Future<void> _playVideoExternal(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    final crossAxisCount = isMobile ? 1 : (size.width > 1200 ? 4 : 2);
    final displayedVideos = (!isMobile || _isExpanded) ? videos : videos.take(3).toList();

    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          // Section Heading
          Text(
            'شوفها بعينك.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اضغط على أي عرض لمشاهدة الدبكة كاملة بأعلى دقة وصوت 🔥',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              color: colors.gold,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 50),

          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            itemCount: displayedVideos.length,
            itemBuilder: (context, index) {
              final video = displayedVideos[index];
              final bool isVertical = video['isVertical'] ?? true;
              final double calculatedAspectRatio = isVertical ? 0.7 : 1.4;

              return InkWell(
                onTap: () => _playVideoExternal(video['url']!),
                child: AspectRatio(
                  aspectRatio: calculatedAspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: colors.isDark ? Colors.black38 : Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              video['assetPath']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: colors.surface,
                                child: Icon(Icons.movie_creation_outlined, color: colors.gold, size: 48),
                              ),
                            ),
                          ),
                          // Gradient Overlay
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, Color(0x770B0B0A), Color(0xDD0B0B0A)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          // Tag Badge
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7A2027),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                video['tag']!,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Floating Play Icon Button
                          Center(
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xDD7A2027),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                          // Title
                          Positioned(
                            bottom: 16,
                            left: 12,
                            right: 12,
                            child: Text(
                              video['title']!,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF3EBDD),
                                shadows: [
                                  Shadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 4)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (isMobile && videos.length > 3) ...[
            const SizedBox(height: 36),
            ElevatedButton.icon(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              icon: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white),
              label: Text(
                _isExpanded ? 'عرض أقل' : 'عرض المزيد من العروض (${videos.length - 3} عروض أخرى)',
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7A2027),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
