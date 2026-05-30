import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/paw_icon.dart';
import '../widgets/stetho_icon.dart';
import '../widgets/pet_duo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const PvStatusBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 4, 22, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Faça o cadastro do seu pet ou acesse a carteirinha de vacinação',
                          style: AppTextStyles.h1(size: 25),
                        ),
                        const SizedBox(height: 16),
                        // Main menu cards
                        Row(
                          children: [
                            Expanded(child: _MenuCard(
                              label: 'Cadastro',
                              onTap: () => Navigator.pushNamed(context, '/cadastro-pet'),
                              child: PetDuo(width: 128, strokeWidth: 5, bg: AppColors.soft),
                            )),
                            const SizedBox(width: 13),
                            Expanded(child: _MenuCard(
                              label: 'Carteirinha',
                              onTap: () => Navigator.pushNamed(context, '/carteirinha'),
                              child: StethoIcon(size: 66, color: Colors.white, strokeWidth: 2.4),
                            )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Consultas section
                        _SectionHeader(
                          title: 'Consultas',
                          actionLabel: 'Ver todas',
                          onAction: () => Navigator.pushNamed(context, '/consultas'),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/consulta-detalhe'),
                          child: PvCard(
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(child: Text('Dr. Francisco', style: AppTextStyles.h3(size: 17))),
                                        const Icon(Icons.more_horiz, size: 18, color: AppColors.faint),
                                      ]),
                                      const SizedBox(height: 1),
                                      Text('Veterinário geral', style: GoogleFonts.fraunces(fontSize: 13.5, fontStyle: FontStyle.italic, color: AppColors.muted)),
                                      const SizedBox(height: 7),
                                      Row(children: [
                                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.deep3),
                                        const SizedBox(width: 5),
                                        Text('Av. Frei Vicente, 782', style: AppTextStyles.sans(size: 12.5, color: AppColors.muted)),
                                      ]),
                                    ],
                                  ),
                                ),
                                Column(children: [
                                  Text('02/09', style: GoogleFonts.fraunces(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.deep)),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(color: AppColors.deep, borderRadius: BorderRadius.circular(999)),
                                    child: Row(children: [
                                      const Icon(Icons.access_time, size: 13, color: Colors.white),
                                      const SizedBox(width: 5),
                                      Text('14:00h', style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: Colors.white)),
                                    ]),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Serviços rápidos
                        Text('Serviços', style: AppTextStyles.h2()),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _ServiceCard(icon: Icons.vaccines_outlined, label: 'Calendário\nde Vacinas', color: AppColors.deep, route: '/calendario-vacinas'),
                              const SizedBox(width: 10),
                              _ServiceCard(icon: Icons.medication_outlined, label: 'Receitas\nMédicas', color: AppColors.green, route: '/receitas'),
                              const SizedBox(width: 10),
                              _ServiceCard(icon: Icons.healing_outlined, label: 'Procedimentos', color: AppColors.amber, route: '/procedimentos'),
                              const SizedBox(width: 10),
                              _ServiceCard(icon: Icons.warning_amber_outlined, label: 'Restrições\ne Alergias', color: AppColors.red, route: '/restricoes'),
                              const SizedBox(width: 10),
                              _ServiceCard(icon: Icons.newspaper_outlined, label: 'Notícias', color: AppColors.deep3, route: '/noticias'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Notícias section
                        _SectionHeader(
                          title: 'Notícias',
                          actionLabel: 'Ver todas',
                          onAction: () => Navigator.pushNamed(context, '/noticias'),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/noticias'),
                          child: PvCard(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    width: 60, height: 60,
                                    color: AppColors.soft2,
                                    child: CustomPaint(painter: _HatchPainter()),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Campanha de vacinação antirrábica gratuita em setembro',
                                      style: AppTextStyles.sans(size: 13.5, weight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 3),
                                    Text('Secretaria de Saúde · há 2 dias', style: AppTextStyles.meta(size: 12)),
                                  ],
                                )),
                                const Icon(Icons.chevron_right, size: 18, color: AppColors.faint),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
                const PvBottomNav(active: 'home'),
              ],
            ),
            const Positioned(right: 16, bottom: 94, child: _PetBotPopup()),
          ],
        ),
      ),
    );
  }
}

// ─── Section header with optional action link ───────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: AppTextStyles.h2()),
      if (actionLabel != null)
        GestureDetector(
          onTap: onAction,
          child: Text(actionLabel!, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: AppColors.deep3)),
        ),
    ],
  );
}

// ─── Menu card (Cadastro / Carteirinha) ─────────────────────────────────────

class _MenuCard extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback? onTap;
  const _MenuCard({required this.label, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 158,
      decoration: BoxDecoration(
        color: AppColors.soft,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deep.withValues(alpha: 0.6),
            blurRadius: 22, spreadRadius: -16, offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(child: Opacity(opacity: 0.95, child: child)),
          Positioned(
            right: 12, top: 14, bottom: 14,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(label, style: GoogleFonts.fraunces(fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.deep)),
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Quick service card ──────────────────────────────────────────────────────

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String route;
  const _ServiceCard({required this.icon, required this.label, required this.color, required this.route});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.20), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(11)),
            child: Icon(icon, size: 21, color: color),
          ),
          const SizedBox(height: 10),
          Text(label, style: AppTextStyles.sans(size: 12, weight: FontWeight.w800, color: AppColors.ink)),
        ],
      ),
    ),
  );
}

// ─── PetBot popup ───────────────────────────────────────────────────────────

class _PetBotPopup extends StatelessWidget {
  const _PetBotPopup();

  @override
  Widget build(BuildContext context) => Container(
    width: 236,
    padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.line),
      boxShadow: [BoxShadow(color: AppColors.deep.withValues(alpha: 0.5), blurRadius: 30, spreadRadius: -12, offset: const Offset(0, 16))],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Olá! Sou o PetBot!', style: GoogleFonts.fraunces(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.deep)),
            const Icon(Icons.close, size: 16, color: AppColors.muted),
          ],
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: AppTextStyles.sans(size: 12.5, color: AppColors.ink),
            children: [
              const TextSpan(text: 'Comunico que a vacina Antirrábica de '),
              TextSpan(text: 'Mingau', style: AppTextStyles.sans(size: 12.5, weight: FontWeight.w800, color: AppColors.deep)),
              const TextSpan(text: ' vence dia '),
              TextSpan(text: '22/12/2025', style: AppTextStyles.sans(size: 12.5, weight: FontWeight.w800, color: AppColors.deep)),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text('Vacine seu gatinho!', style: AppTextStyles.sans(size: 12.5, weight: FontWeight.w800))),
            Stack(children: [
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(color: AppColors.soft, shape: BoxShape.circle),
                child: Center(child: PawIcon(size: 18, color: AppColors.deep)),
              ),
              Positioned(
                right: -3, bottom: -3,
                child: Container(
                  width: 16, height: 16,
                  decoration: BoxDecoration(color: AppColors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                  child: const Icon(Icons.check, size: 9, color: Colors.white),
                ),
              ),
            ]),
          ],
        ),
      ],
    ),
  );
}

// ─── Hatch pattern painter ───────────────────────────────────────────────────

class _HatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF543075).withValues(alpha: 0.10)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.butt;
    for (double i = -size.height; i < size.width + size.height; i += 14) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), p);
    }
  }
  @override
  bool shouldRepaint(_HatchPainter old) => false;
}
