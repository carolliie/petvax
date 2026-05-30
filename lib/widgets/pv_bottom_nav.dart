import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'paw_icon.dart';
import 'syringe_icon.dart';

enum BottomNavRole { tutor, vet }

class PvBottomNav extends StatelessWidget {
  final BottomNavRole role;
  final String active;

  const PvBottomNav({
    super.key,
    this.role = BottomNavRole.tutor,
    this.active = 'home',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: AppColors.deep,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: role == BottomNavRole.tutor
            ? _tutorItems(context)
            : _vetItems(context),
      ),
    );
  }

  List<Widget> _tutorItems(BuildContext context) => [
        _NavItem(
          id: 'vac',
          active: active,
          child: SyringeIcon(size: 24, color: active == 'vac' ? Colors.white : const Color(0xFFC9AEE0)),
          onTap: () => _go(context, '/carteirinha'),
        ),
        _FabItem(),
        _NavItem(
          id: 'me',
          active: active,
          child: Icon(Icons.person_outline, size: 24, color: active == 'me' ? Colors.white : const Color(0xFFC9AEE0)),
          onTap: () => _go(context, '/perfil'),
        ),
      ];

  List<Widget> _vetItems(BuildContext context) => [
        _NavItem(
          id: 'agenda',
          active: active,
          child: Icon(Icons.calendar_today_outlined, size: 22, color: active == 'agenda' ? Colors.white : const Color(0xFFC9AEE0)),
          onTap: () {},
        ),
        _FabItem(),
        _NavItem(
          id: 'me',
          active: active,
          child: Icon(Icons.person_outline, size: 24, color: active == 'me' ? Colors.white : const Color(0xFFC9AEE0)),
          onTap: () {},
        ),
      ];

  void _go(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }
}

class _NavItem extends StatelessWidget {
  final String id;
  final String active;
  final Widget child;
  final VoidCallback onTap;

  const _NavItem({required this.id, required this.active, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(width: 44, height: 44, child: Center(child: child)),
    );
  }
}

class _FabItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != '/home') {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Container(
        width: 62,
        height: 62,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(child: PawIcon(size: 30, color: AppColors.deep)),
      ),
    );
  }
}
