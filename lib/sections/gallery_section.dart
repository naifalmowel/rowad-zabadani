import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../theme/app_colors.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final List<Map<String, dynamic>> galleryItems = const [
    {'path': 'assets/images/l1.webp', 'isVertical': false},
    {'path': 'assets/images/v1.webp', 'isVertical': true},
    {'path': 'assets/images/v2.webp', 'isVertical': true},
    {'path': 'assets/images/l2.webp', 'isVertical': false},
    {'path': 'assets/images/v3.webp', 'isVertical': true},
    {'path': 'assets/images/v4.webp', 'isVertical': true},
    {'path': 'assets/images/l3.webp', 'isVertical': false},
    {'path': 'assets/images/v5.webp', 'isVertical': true},
    {'path': 'assets/images/v6.webp', 'isVertical': true},
    {'path': 'assets/images/v7.webp', 'isVertical': true},
    {'path': 'assets/images/v8.webp', 'isVertical': true},
  ];

  void _openLightbox(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => _LightboxDialog(
        items: galleryItems,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);
    final crossAxisCount = isMobile ? 2 : (size.width > 1200 ? 4 : 3);

    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'من ليالينا',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لمحات من أجمل الأعراس والافتتاحات والدبكات',
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
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: galleryItems.length,
            itemBuilder: (context, index) {
              final item = galleryItems[index];
              final bool isVertical = item['isVertical'] ?? true;
              final double aspectRatio = isVertical ? 0.75 : 1.35;

              return InkWell(
                onTap: () => _openLightbox(context, index),
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.border, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: colors.isDark ? Colors.black45 : Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.5),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            item['path'],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.35)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          // Subtle expand icon instead of text
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.open_in_full_rounded,
                                color: Colors.white,
                                size: 13,
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
        ],
      ),
    );
  }
}

class _LightboxDialog extends StatefulWidget {
  const _LightboxDialog({required this.items, required this.initialIndex});

  final List<Map<String, dynamic>> items;
  final int initialIndex;

  @override
  State<_LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<_LightboxDialog> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Semi-transparent background showing hint of content behind
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black.withValues(alpha: 0.85)),
          ),

          // PageView for swiping through images
          PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset(
                      widget.items[index]['path'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: 24,
            right: 24,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: const EdgeInsets.all(12),
              ),
              icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
              tooltip: 'إغلاق',
            ),
          ),

          // Counter Badge
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.items.length}',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Previous / Next Navigation Arrows
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: () {
                  if (_currentIndex > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black45,
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 24),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: () {
                  if (_currentIndex < widget.items.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black45,
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
