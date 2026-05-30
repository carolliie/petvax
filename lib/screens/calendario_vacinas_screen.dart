import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';
import '../widgets/syringe_icon.dart';

class CalendarioVacinasScreen extends StatefulWidget {
  const CalendarioVacinasScreen({super.key});
  @override
  State<CalendarioVacinasScreen> createState() => _CalendarioVacinasScreenState();
}

class _CalendarioVacinasScreenState extends State<CalendarioVacinasScreen> {
  String _pet = 'Mingau';
  String _filter = 'Todas';

  static const _filters = ['Todas', 'Próximas', 'Atrasadas'];

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
                    const PvPushHeader(title: 'Calendário de Vacinas'),
                    // Pet selector
                    Row(
                      children: [
                        _PetBubble(name: 'Mingau', selected: _pet == 'Mingau', onTap: () => setState(() => _pet = 'Mingau')),
                        const SizedBox(width: 10),
                        _PetBubble(name: 'Theo', selected: _pet == 'Theo', onTap: () => setState(() => _pet = 'Theo')),
                        const SizedBox(width: 10),
                        _PetBubble(name: '+', selected: false, onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Status filters
                    Row(
                      children: _filters.map((f) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _filter = f),
                          child: _FilterChip(label: f, selected: _filter == f),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 20),
                    if (_filter == 'Todas' || _filter == 'Atrasadas') ...[
                      _SectionBadge(label: 'Atrasadas', count: 1, color: AppColors.red),
                      const SizedBox(height: 10),
                      _VaxCard(
                        nome: 'Giárdia',
                        pet: 'Mingau',
                        aplicada: '03/08/24',
                        proxima: '03/08/25',
                        variant: TagVariant.red,
                        statusLabel: 'Atrasada',
                        countdown: '−119 dias',
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (_filter == 'Todas' || _filter == 'Próximas') ...[
                      _SectionBadge(label: 'Dezembro 2025', count: 1, color: AppColors.amber),
                      const SizedBox(height: 10),
                      _VaxCard(
                        nome: 'Antirrábica',
                        pet: 'Mingau',
                        aplicada: '22/12/24',
                        proxima: '22/12/25',
                        variant: TagVariant.amber,
                        statusLabel: 'Vence em breve',
                        countdown: 'em 22 dias',
                      ),
                      const SizedBox(height: 20),
                      _SectionBadge(label: 'Janeiro 2026', count: 1, color: AppColors.green),
                      const SizedBox(height: 10),
                      _VaxCard(
                        nome: 'Leucemia felina (FeLV)',
                        pet: 'Mingau',
                        aplicada: '15/01/25',
                        proxima: '15/01/26',
                        variant: TagVariant.green,
                        statusLabel: 'Em dia',
                        countdown: 'em 46 dias',
                      ),
                      const SizedBox(height: 20),
                      _SectionBadge(label: 'Março 2026', count: 1, color: AppColors.green),
                      const SizedBox(height: 10),
                      _VaxCard(
                        nome: 'V4 (Quádrupla felina)',
                        pet: 'Mingau',
                        aplicada: '10/03/25',
                        proxima: '10/03/26',
                        variant: TagVariant.green,
                        statusLabel: 'Em dia',
                        countdown: 'em 109 dias',
                      ),
                    ],
                    const SizedBox(height: 24),
                    // Summary card
                    _SummaryCard(),
                  ],
                ),
              ),
            ),
            const PvBottomNav(active: 'vac'),
          ],
        ),
      ),
    );
  }
}

class _PetBubble extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _PetBubble({required this.name, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPlus = name == '+';
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: isPlus ? Colors.white : AppColors.soft2,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.deep : AppColors.line,
                width: selected ? 2.5 : 2,
              ),
            ),
            child: Center(
              child: isPlus
                  ? const Icon(Icons.add, size: 20, color: AppColors.deep3)
                  : PawIcon(size: 22, color: AppColors.deep),
            ),
          ),
          if (!isPlus) ...[
            const SizedBox(height: 4),
            Text(name, style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: selected ? AppColors.deep : AppColors.muted)),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.white,
        border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
    );
  }
}

class _SectionBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _SectionBadge({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.eyebrow()),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(99)),
          child: Text('$count', style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: color)),
        ),
      ],
    );
  }
}

class _VaxCard extends StatelessWidget {
  final String nome;
  final String pet;
  final String aplicada;
  final String proxima;
  final TagVariant variant;
  final String statusLabel;
  final String countdown;

  const _VaxCard({
    required this.nome, required this.pet, required this.aplicada,
    required this.proxima, required this.variant, required this.statusLabel,
    required this.countdown,
  });

  Color get _countdownColor => switch (variant) {
    TagVariant.red => AppColors.red,
    TagVariant.amber => AppColors.amber,
    _ => AppColors.muted,
  };

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(12)),
            child: Center(child: SyringeIcon(size: 20, color: AppColors.deep)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
                const SizedBox(height: 3),
                Row(children: [
                  PawIcon(size: 11, color: AppColors.muted),
                  const SizedBox(width: 4),
                  Text(pet, style: AppTextStyles.meta(size: 12)),
                ]),
                const SizedBox(height: 6),
                Row(children: [
                  _DateChip(label: 'Aplicada', date: aplicada),
                  const SizedBox(width: 8),
                  _DateChip(label: 'Próxima', date: proxima),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PvTag(label: statusLabel, variant: variant),
              const SizedBox(height: 6),
              Text(countdown, style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: _countdownColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final String date;
  const _DateChip({required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(8)),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.sans(size: 11, weight: FontWeight.w600, color: AppColors.muted),
          children: [
            TextSpan(text: '$label '),
            TextSpan(text: date, style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: AppColors.ink)),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PvCard(
      color: AppColors.chip,
      shadow: false,
      child: Row(
        children: [
          Expanded(child: _Stat(label: 'Em dia', value: '2', color: AppColors.green)),
          _Divider(),
          Expanded(child: _Stat(label: 'Vence em breve', value: '1', color: AppColors.amber)),
          _Divider(),
          Expanded(child: _Stat(label: 'Atrasadas', value: '1', color: AppColors.red)),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h1(size: 28, color: color)),
        const SizedBox(height: 2),
        Text(label, textAlign: TextAlign.center, style: AppTextStyles.sans(size: 11, weight: FontWeight.w700, color: AppColors.muted)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 44, color: AppColors.line);
  }
}
