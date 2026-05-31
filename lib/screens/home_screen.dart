import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/stetho_icon.dart';
import '../widgets/pet_icon.dart';

// ── Serviços do carrossel ─────────────────────────────────────────────────────

class _Svc {
  final IconData icon;
  final String label;
  final Color color;
  final String route;
  const _Svc(this.icon, this.label, this.color, this.route);
}

const _services = [
  _Svc(Icons.vaccines_outlined,         'Calendário\nde Vacinas',   AppColors.deep,   '/calendario-vacinas'),
  _Svc(Icons.document_scanner_outlined, 'Análise\nPrévia',          AppColors.green,  '/enviar-carteirinha'),
  _Svc(Icons.smart_toy_outlined,        'PetBot',                   AppColors.deep3,  '/petbot'),
  _Svc(Icons.medication_outlined,       'Receitas\nMédicas',        AppColors.green,  '/receitas'),
  _Svc(Icons.healing_outlined,          'Procedimentos',            AppColors.amber,  '/procedimentos'),
  _Svc(Icons.warning_amber_outlined,    'Restrições\ne Alergias',   AppColors.red,    '/restricoes'),
  _Svc(Icons.newspaper_outlined,        'Notícias',                 AppColors.deep3,  '/noticias'),
];

// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showPopup = true;

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
                    padding: const EdgeInsets.only(top: 4, bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Conteúdo com padding lateral ────────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá! Bem-vindo ao PetVax',
                                style: AppTextStyles.h1(size: 24),
                              ),
                              Text(
                                'Cuide da saúde do seu pet com facilidade.',
                                style: AppTextStyles.meta(),
                              ),
                              const SizedBox(height: 18),

                              // ── Cards de menu ──────────────────────────────
                              Row(
                                children: [
                                  Expanded(
                                    child: _MenuCard(
                                      label: 'Meus Pets',
                                      sublabel: 'Cadastro',
                                      color: AppColors.soft,
                                      onTap: () => Navigator.pushNamed(
                                          context, '/cadastro-pet'),
                                      child: _PetPairIcon(),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _MenuCard(
                                      label: 'Carteirinha',
                                      sublabel: 'Vacinas',
                                      color: AppColors.chip,
                                      onTap: () => Navigator.pushNamed(
                                          context, '/carteirinha'),
                                      child: StethoIcon(
                                        size: 58,
                                        color: AppColors.deep3,
                                        strokeWidth: 2.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // ── Próxima consulta ──────────────────────────
                              _SectionHeader(
                                title: 'Próxima consulta',
                                actionLabel: 'Ver todas',
                                onAction: () => Navigator.pushNamed(
                                    context, '/consultas'),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/consulta-detalhe'),
                                child: PvCard(
                                  padding: const EdgeInsets.fromLTRB(
                                      16, 14, 16, 14),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Dr. Francisco',
                                                style:
                                                    AppTextStyles.h3(size: 16)),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Veterinário geral',
                                              style: GoogleFonts.fraunces(
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.italic,
                                                  color: AppColors.muted),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(children: [
                                              const Icon(
                                                  Icons.location_on_outlined,
                                                  size: 13,
                                                  color: AppColors.deep3),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  'Av. Frei Vicente, 782',
                                                  style: AppTextStyles.sans(
                                                      size: 12,
                                                      color: AppColors.muted),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '02/09',
                                              style: GoogleFonts.fraunces(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.deep),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppColors.chip,
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                              ),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                        Icons.access_time,
                                                        size: 12,
                                                        color: AppColors.deep3),
                                                    const SizedBox(width: 4),
                                                    Text('14:00h',
                                                        style:
                                                            AppTextStyles.sans(
                                                                size: 12,
                                                                weight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: AppColors
                                                                    .deep3)),
                                                  ]),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _SectionHeader(title: 'Serviços'),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),

                        // ── Carrossel full-width ─────────────────────────────
                        SizedBox(
                          height: 112,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.only(left: 22, right: 10),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: _services.length,
                            itemBuilder: (context, i) {
                              final s = _services[i];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, s.route),
                                  child: Container(
                                    width: 92,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: s.color
                                              .withValues(alpha: 0.18),
                                          width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 34,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            color: s.color
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(s.icon,
                                              size: 18, color: s.color),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          s.label,
                                          style: AppTextStyles.sans(
                                              size: 11,
                                              weight: FontWeight.w800,
                                              color: AppColors.ink),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // ── Notícias ─────────────────────────────────────────
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(22, 20, 22, 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionHeader(
                                title: 'Notícias',
                                actionLabel: 'Ver todas',
                                onAction: () => Navigator.pushNamed(
                                    context, '/noticias'),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/noticia-detalhe'),
                                child: PvCard(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        child: Container(
                                          width: 56,
                                          height: 56,
                                          color: AppColors.soft2,
                                          child: CustomPaint(
                                              painter: _HatchPainter()),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Campanha antirrábica gratuita em setembro',
                                              style: AppTextStyles.sans(
                                                  size: 13,
                                                  weight: FontWeight.w800),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              'Secretaria de Saúde · há 2 dias',
                                              style:
                                                  AppTextStyles.meta(size: 11.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right,
                                          size: 16, color: AppColors.faint),
                                    ],
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
                const PvBottomNav(active: 'home'),
              ],
            ),

            // ── PetBot popup ──────────────────────────────────────────────────
            if (_showPopup)
              Positioned(
                right: 16,
                bottom: 94,
                child: _PetBotPopup(
                  onDismiss: () => setState(() => _showPopup = false),
                  onTap: () => Navigator.pushNamed(context, '/petbot'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Par de ícones cat+dog ────────────────────────────────────────────────────

class _PetPairIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dog (ligeiramente à direita e atrás)
          Positioned(
            right: 0,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.deep.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child:
                  Center(child: PetIcon(size: 26, color: AppColors.deep3, kind: PetKind.dog)),
            ),
          ),
          // Cat (ligeiramente à esquerda e à frente)
          Positioned(
            left: 0,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.deep.withValues(alpha: 0.20),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.soft, width: 2),
              ),
              child:
                  Center(child: PetIcon(size: 26, color: AppColors.deep, kind: PetKind.cat)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────

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
              child: Text(actionLabel!,
                  style: AppTextStyles.sans(
                      size: 13,
                      weight: FontWeight.w800,
                      color: AppColors.deep3)),
            ),
        ],
      );
}

// ─── Menu card ────────────────────────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  const _MenuCard({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 148,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.deep.withValues(alpha: 0.12),
                blurRadius: 16,
                spreadRadius: -4,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: child)),
              const SizedBox(height: 8),
              Text(label,
                  style: AppTextStyles.sans(
                      size: 14,
                      weight: FontWeight.w800,
                      color: AppColors.deep)),
              Text(sublabel,
                  style: AppTextStyles.sans(
                      size: 11.5,
                      weight: FontWeight.w600,
                      color: AppColors.muted)),
            ],
          ),
        ),
      );
}

// ─── PetBot popup — compacto ──────────────────────────────────────────────────

class _PetBotPopup extends StatelessWidget {
  final VoidCallback onDismiss;
  final VoidCallback onTap;
  const _PetBotPopup({required this.onDismiss, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 210,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.line),
          boxShadow: [
            BoxShadow(
              color: AppColors.deep.withValues(alpha: 0.14),
              blurRadius: 20,
              spreadRadius: -6,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.chip,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_outlined,
                  size: 16, color: AppColors.deep3),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Antirrábica de Mingau vence em 22/12!',
                style: AppTextStyles.sans(
                    size: 12, weight: FontWeight.w700, color: AppColors.ink),
                maxLines: 2,
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.close, size: 14, color: AppColors.faint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.deep.withValues(alpha: 0.08)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.butt;
    for (double i = -size.height; i < size.width + size.height; i += 12) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), p);
    }
  }

  @override
  bool shouldRepaint(_HatchPainter old) => false;
}
