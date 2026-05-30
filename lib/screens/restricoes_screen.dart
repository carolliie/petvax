import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';

class RestricoesScreen extends StatefulWidget {
  const RestricoesScreen({super.key});
  @override
  State<RestricoesScreen> createState() => _RestricoesScreenState();
}

class _RestricoesScreenState extends State<RestricoesScreen> {
  String _pet = 'Mingau';
  String _sev = 'Todas';

  static const _restricoes = [
    (
      pet: 'Mingau',
      nome: 'Penicilina / Amoxicilina',
      tipo: 'Alergia medicamentosa',
      sev: 'Grave',
      nota: 'Reação cutânea severa registrada em 03/2024. Evitar todos os betalactâmicos.',
      registrado: '03/2024',
      medico: 'Dr. Francisco',
    ),
    (
      pet: 'Mingau',
      nome: 'Frango',
      tipo: 'Alergia alimentar',
      sev: 'Moderada',
      nota: 'Prurido e otite recorrente. Dieta hipoalergênica recomendada.',
      registrado: '06/2024',
      medico: 'Dra. Helena Sá',
    ),
    (
      pet: 'Mingau',
      nome: 'Sopro cardíaco grau II',
      tipo: 'Condição clínica',
      sev: 'Leve',
      nota: 'Monitorar antes de procedimentos com anestesia geral.',
      registrado: '01/2025',
      medico: 'Dr. Francisco',
    ),
    (
      pet: 'Theo',
      nome: 'Dipirona',
      tipo: 'Alergia medicamentosa',
      sev: 'Moderada',
      nota: 'Urticária registrada em 11/2023. Evitar AINEs.',
      registrado: '11/2023',
      medico: 'Dr. Felipe Braga',
    ),
    (
      pet: 'Theo',
      nome: 'Displasia coxofemoral',
      tipo: 'Condição ortopédica',
      sev: 'Moderada',
      nota: 'Diagnóstico por raio-X. Evitar exercícios de alto impacto.',
      registrado: '08/2025',
      medico: 'Dr. Felipe Braga',
    ),
  ];

  List get _filtered => _restricoes.where((r) {
    if (_pet != 'Todos' && r.pet != _pet) return false;
    if (_sev != 'Todas' && r.sev != _sev) return false;
    return true;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const PvStatusBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text('Restrições e alergias', style: AppTextStyles.h1(size: 25))),
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: AppColors.deep, borderRadius: BorderRadius.circular(14)),
                        child: const Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    // Pet selector
                    Row(children: [
                      _PetChip(name: 'Mingau', selected: _pet == 'Mingau', onTap: () => setState(() => _pet = 'Mingau')),
                      const SizedBox(width: 8),
                      _PetChip(name: 'Theo', selected: _pet == 'Theo', onTap: () => setState(() => _pet = 'Theo')),
                      const SizedBox(width: 8),
                      _PetChip(name: 'Todos', selected: _pet == 'Todos', onTap: () => setState(() => _pet = 'Todos'), noIcon: true),
                    ]),
                    const SizedBox(height: 12),
                    // Severity filter
                    Row(children: ['Todas', 'Grave', 'Moderada', 'Leve'].map((s) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _sev = s),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: _sev == s ? _sevColor(s) : Colors.white,
                            border: Border.all(color: _sev == s ? _sevColor(s) : AppColors.line, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(s, style: AppTextStyles.sans(size: 12, weight: FontWeight.w800, color: _sev == s ? Colors.white : AppColors.muted)),
                        ),
                      ),
                    )).toList()),
                    const SizedBox(height: 16),
                    // Summary
                    _summaryRow(),
                    const SizedBox(height: 14),
                    // List
                    ..._filtered.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _RestrCard(r: r),
                    )),
                    if (_filtered.isEmpty) _empty(),
                  ],
                ),
              ),
            ),
            const PvBottomNav(active: 'home'),
          ],
        ),
      ),
    );
  }

  Color _sevColor(String sev) => switch (sev) {
    'Grave'    => AppColors.red,
    'Moderada' => AppColors.amber,
    'Leve'     => AppColors.green,
    _          => AppColors.muted,
  };

  Widget _summaryRow() {
    final all = _sev == 'Todas' ? _restricoes.where((r) => _pet == 'Todos' || r.pet == _pet).toList() : null;
    if (all == null) return const SizedBox.shrink();
    final graves = all.where((r) => r.sev == 'Grave').length;
    final mods = all.where((r) => r.sev == 'Moderada').length;
    final leves = all.where((r) => r.sev == 'Leve').length;
    return Row(children: [
      _SevBadge(label: 'Graves', count: graves, color: AppColors.red),
      const SizedBox(width: 8),
      _SevBadge(label: 'Moderadas', count: mods, color: AppColors.amber),
      const SizedBox(width: 8),
      _SevBadge(label: 'Leves', count: leves, color: AppColors.green),
    ]);
  }

  Widget _empty() => Padding(
    padding: const EdgeInsets.only(top: 48),
    child: Center(child: Column(children: [
      Container(
        width: 72, height: 72,
        decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.check_circle_outline, size: 36, color: AppColors.green),
      ),
      const SizedBox(height: 16),
      Text('Nenhuma restrição', style: AppTextStyles.h3(size: 16)),
      const SizedBox(height: 8),
      Text('Não há restrições ou alergias\nregistradas para este filtro.', textAlign: TextAlign.center, style: AppTextStyles.meta()),
    ])),
  );
}

class _PetChip extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;
  final bool noIcon;
  const _PetChip({required this.name, required this.selected, required this.onTap, this.noIcon = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.white,
        border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (!noIcon) ...[
          PawIcon(size: 12, color: selected ? Colors.white : AppColors.deep3),
          const SizedBox(width: 5),
        ],
        Text(name, style: AppTextStyles.sans(size: 12.5, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
      ]),
    ),
  );
}

class _SevBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _SevBadge({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text('$count ', style: AppTextStyles.sans(size: 13, weight: FontWeight.w900, color: color)),
      Text(label, style: AppTextStyles.sans(size: 12, weight: FontWeight.w700, color: AppColors.muted)),
    ]),
  );
}

class _RestrCard extends StatefulWidget {
  final dynamic r;
  const _RestrCard({required this.r});
  @override
  State<_RestrCard> createState() => _RestrCardState();
}

class _RestrCardState extends State<_RestrCard> {
  bool _expanded = false;

  Color _sevColor(String sev) => switch (sev) {
    'Grave'    => AppColors.red,
    'Moderada' => AppColors.amber,
    _          => AppColors.green,
  };

  TagVariant _sevVariant(String sev) => switch (sev) {
    'Grave'    => TagVariant.red,
    'Moderada' => TagVariant.amber,
    _          => TagVariant.soft,
  };

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final color = _sevColor(r.sev);
    return PvCard(
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(11)),
              child: Icon(Icons.warning_amber_outlined, size: 20, color: color),
            ),
            const SizedBox(width: 11),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.nome, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
              Text(r.tipo, style: AppTextStyles.meta(size: 11.5)),
            ])),
            PvTag(label: r.sev, variant: _sevVariant(r.sev)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20, color: AppColors.faint),
            ),
          ]),
          if (r.nota.isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(r.nota, style: AppTextStyles.sans(size: 12.5, color: AppColors.muted)),
          ],
          if (_expanded) ...[
            const SizedBox(height: 10),
            const Divider(color: AppColors.line, height: 1),
            const SizedBox(height: 10),
            Row(children: [
              _Detail(icon: Icons.calendar_today_outlined, label: 'Registrado em ${r.registrado}'),
              const SizedBox(width: 12),
              _Detail(icon: Icons.person_outline, label: r.medico),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              PawIcon(size: 12, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(r.pet, style: AppTextStyles.meta(size: 12)),
            ]),
          ],
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Detail({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 13, color: AppColors.deep3),
    const SizedBox(width: 4),
    Text(label, style: AppTextStyles.meta(size: 11.5)),
  ]);
}
