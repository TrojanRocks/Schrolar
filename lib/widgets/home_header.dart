import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  static const String _logoSvg = '''
<svg width="28" height="28" viewBox="0 0 28 28" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#F58529"/>
      <stop offset="50%" stop-color="#DD2A7B"/>
      <stop offset="100%" stop-color="#515BD4"/>
    </linearGradient>
  </defs>
  <rect x="2" y="2" rx="8" ry="8" width="24" height="24" fill="url(#g)"/>
  <circle cx="24" cy="8" r="5" fill="white"/>
  <circle cx="9" cy="7.5" r="1.7" fill="white" opacity="0.9"/>
</svg>
''';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          SvgPicture.string(_logoSvg),
          const SizedBox(width: 8),
          const Text('EduShorts'),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        IconButton(onPressed: () => Navigator.of(context).pushNamed('/settings'), icon: const Icon(Icons.settings_outlined)),
        IconButton(onPressed: () => Navigator.of(context).pushNamed('/profile'), icon: const Icon(Icons.person_outline)),
      ],
    );
  }
}
