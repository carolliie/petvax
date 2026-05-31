import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';
import '../widgets/pet_icon.dart';
import '../widgets/syringe_icon.dart';

enum _View { lista, calendario }

// ── Vaccine data model ────────────────────────────────────────────────────────

class _VaxData {
  final String nome;
  final String pet;
  final DateTime date;
  final TagVariant variant;
  final String statusLabel;
  final String countdown;
  final bool recommended;

  const _VaxData({
    required this.nome,
    required this.pet,
    required this.date,
    required this.variant,
    required this.statusLabel,
    required this.countdown,
    this.recommended = false,
  });
}

final _vacinas = [
  _VaxData(
    nome: 'Giárdia',
    pet: 'Mingau',
    date: DateTime(2025, 8, 3),
    variant: TagVariant.red,
    statusLabel: 'Atrasada',
    countdown: '−119 dias',
  ),
  _VaxData(
    nome: 'Antirrábica',
    pet: 'Mingau',
    date: DateTime(2025, 12, 22),
    variant: TagVariant.amber,
    statusLabel: 'Vence em breve',
    countdown: 'em 22 dias',
  ),
  _VaxData(
    nome: 'Leucemia felina (FeLV)',
    pet: 'Mingau',
    date: DateTime(2026, 1, 15),
    variant: TagVariant.green,
    statusLabel: 'Em dia',
    countdown: 'em 46 dias',
  ),
  _VaxData(
    nome: 'V4 (Quádrupla felina)',
    pet: 'Mingau',
    date: DateTime(2026, 3, 10),
    variant: TagVariant.green,
    statusLabel: 'Em dia',
    countdown: 'em 109 dias',
  ),
  _VaxData(
    nome: 'Calicivírus felino (FCV)',
    pet: 'Mingau',
    date: DateTime(2026, 1, 15),
    variant: TagVariant.soft,
    statusLabel: 'Recomendada',
    countdown: 'em 46 dias',
    recommended: true,
  ),
  _VaxData(
    nome: 'Herpesvírus felino (FHV-1)',
    pet: 'Mingau',
    date: DateTime(2026, 1, 15),
    variant: TagVariant.soft,
    statusLabel: 'Recomendada',
    countdown: 'em 46 dias',
    recommended: true,
  ),
  _VaxData(
    nome: 'Clamidiose felina',
    pet: 'Mingau',
    date: DateTime(2026, 3, 10),
    variant: TagVariant.soft,
    statusLabel: 'Recomendada',
    countdown: 'em 109 dias',
    recommended: true,
  ),
];

// ─────────────────────────────────────────────────────────────────────────────

class CalendarioVacinasScreen extends StatefulWidget {
  const CalendarioVacinasScreen({super.key});
  @override
  State<CalendarioVacinasScreen> createState() =>
      _CalendarioVacinasScreenState();
}

class _CalendarioVacinasScreenState extends State<CalendarioVacinasScreen> {
  String _pet = 'Mingau';
  String _filter = 'Todas';
  _View _view = _View.lista;
  void _setView(_View v) => setState(() => _view = v);

  static const _filters = ['Todas', 'Próximas', 'Atrasadas', 'Recomendadas'];

  List<_VaxData> get _filtered {
    List<_VaxData> list;
    switch (_filter) {
      case 'Atrasadas':
        list = _vacinas.where((v) => v.variant == TagVariant.red).toList();
      case 'Próximas':
        list = _vacinas
            .where((v) =>
                v.variant == TagVariant.amber || v.variant == TagVariant.green)
            .where((v) => !v.recommended)
            .toList();
      case 'Recomendadas':
        list = _vacinas.where((v) => v.recommended).toList();
      default:
        list = _vacinas;
    }
    return list;
  }

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
                    // Header with view toggle
                    PvPushHeader(
                      title: 'Calendário de Vacinas',
                      right: _ViewToggle(
                        view: _view,
                        onChanged: _setView,
                      ),
                    ),
                    // Pet selector (scrollable)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _PetBubble(
                              name: 'Mingau',
                              selected: _pet == 'Mingau',
                              onTap: () => setState(() => _pet = 'Mingau')),
                          const SizedBox(width: 10),
                          _PetBubble(
                              name: 'Theo',
                              selected: _pet == 'Theo',
                              onTap: () => setState(() => _pet = 'Theo')),
                          const SizedBox(width: 10),
                          _PetBubble(
                              name: '+', selected: false, onTap: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Filter chips (scrollable)
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        separatorBuilder: (_, i) =>
                            const SizedBox(width: 8),
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () =>
                              setState(() => _filter = _filters[i]),
                          child: _FilterChip(
                            label: _filters[i],
                            selected: _filter == _filters[i],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Animated view switch
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.04),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: KeyedSubtree(
                        key: ValueKey(_view),
                        child: _view == _View.lista
                            ? _ListaView(
                                filter: _filter,
                                data: _filtered,
                                onAgendar: () => Navigator.pushNamed(
                                    context, '/agendar-vacina'),
                              )
                            : _CalendarView(
                                data: _vacinas,
                                onAgendar: () => Navigator.pushNamed(
                                    context, '/agendar-vacina'),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
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

// ─── View toggle widget ───────────────────────────────────────────────────────

class _ViewToggle extends StatelessWidget {
  final _View view;
  final void Function(_View) onChanged;
  const _ViewToggle({required this.view, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.chip,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleBtn(
            icon: Icons.view_list_outlined,
            active: view == _View.lista,
            onTap: () => onChanged(_View.lista),
          ),
          const SizedBox(width: 2),
          _ToggleBtn(
            icon: Icons.calendar_month_outlined,
            active: view == _View.calendario,
            onTap: () => onChanged(_View.calendario),
          ),
        ],
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ToggleBtn(
      {required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: active ? AppColors.deep : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(icon,
            size: 17,
            color: active ? Colors.white : AppColors.muted),
      ),
    );
  }
}

// ─── List view ────────────────────────────────────────────────────────────────

class _ListaView extends StatelessWidget {
  final String filter;
  final List<_VaxData> data;
  final VoidCallback onAgendar;
  const _ListaView(
      {required this.filter,
      required this.data,
      required this.onAgendar});

  @override
  Widget build(BuildContext context) {
    // Group non-recommended by month
    final scheduled =
        data.where((v) => !v.recommended).toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    final recommended = data.where((v) => v.recommended).toList();

    // Group scheduled by month label
    final Map<String, List<_VaxData>> grouped = {};
    for (final v in scheduled) {
      final key = _monthKey(v.date);
      grouped.putIfAbsent(key, () => []).add(v);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in grouped.entries) ...[
          _SectionBadge(
            label: entry.key,
            count: entry.value.length,
            color: _sectionColor(entry.value),
          ),
          const SizedBox(height: 10),
          for (final v in entry.value) ...[
            _VaxCard(data: v, onAgendar: onAgendar),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
        ],
        if (filter == 'Todas' || filter == 'Recomendadas') ...[
          if (recommended.isNotEmpty) ...[
            _SectionBadge(
              label: 'Recomendadas pelo veterinário',
              count: recommended.length,
              color: AppColors.deep3,
            ),
            const SizedBox(height: 6),
            Text(
              'Vacinas indicadas pelo Dr. Francisco para o perfil de Mingau.',
              style: AppTextStyles.meta(size: 12),
            ),
            const SizedBox(height: 12),
            for (final v in recommended) ...[
              _RecoVaxCard(data: v, onAgendar: onAgendar),
              const SizedBox(height: 10),
            ],
          ],
        ],
      ],
    );
  }

  String _monthKey(DateTime d) {
    const months = [
      '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return '${months[d.month]} ${d.year}';
  }

  Color _sectionColor(List<_VaxData> items) {
    if (items.any((v) => v.variant == TagVariant.red)) return AppColors.red;
    if (items.any((v) => v.variant == TagVariant.amber)) return AppColors.amber;
    return AppColors.green;
  }
}

// ─── Calendar view ────────────────────────────────────────────────────────────

class _CalendarView extends StatefulWidget {
  final List<_VaxData> data;
  final VoidCallback onAgendar;
  const _CalendarView({required this.data, required this.onAgendar});

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  DateTime _month = DateTime(2025, 12);
  int? _selectedDay;

  static const _dayHeaders = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  static const _monthNames = [
    '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  List<_VaxData> _vaccinesForDay(int day) => widget.data
      .where((v) => v.date.year == _month.year && v.date.month == _month.month && v.date.day == day)
      .toList();

  Map<int, List<_VaxData>> get _monthVaccines {
    final map = <int, List<_VaxData>>{};
    for (final v in widget.data) {
      if (v.date.year == _month.year && v.date.month == _month.month) {
        map.putIfAbsent(v.date.day, () => []).add(v);
      }
    }
    return map;
  }

  void _prevMonth() => setState(() {
        _selectedDay = null;
        _month = DateTime(_month.year, _month.month - 1);
      });

  void _nextMonth() => setState(() {
        _selectedDay = null;
        _month = DateTime(_month.year, _month.month + 1);
      });

  @override
  Widget build(BuildContext context) {
    final startOffset = DateTime(_month.year, _month.month, 1).weekday % 7;
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final totalCells = ((startOffset + daysInMonth) / 7).ceil() * 7;
    final cells = List<int?>.generate(totalCells, (i) {
      final day = i - startOffset + 1;
      return (day >= 1 && day <= daysInMonth) ? day : null;
    });
    final rows = cells.length ~/ 7;
    final vaccines = _monthVaccines;
    final selected = _selectedDay;
    final selectedVaccines = selected != null ? _vaccinesForDay(selected) : <_VaxData>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.deep.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            children: [
              // Month navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MonthNavBtn(
                      icon: Icons.chevron_left, onTap: _prevMonth),
                  Text(
                    '${_monthNames[_month.month]} ${_month.year}',
                    style: AppTextStyles.sans(
                        size: 15,
                        weight: FontWeight.w800,
                        color: AppColors.deep),
                  ),
                  _MonthNavBtn(
                      icon: Icons.chevron_right, onTap: _nextMonth),
                ],
              ),
              const SizedBox(height: 14),
              // Day headers
              Row(
                children: _dayHeaders
                    .map((d) => Expanded(
                          child: Center(
                            child: Text(d,
                                style: AppTextStyles.sans(
                                    size: 11,
                                    weight: FontWeight.w800,
                                    color: AppColors.faint)),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 6),
              // Date grid
              ...List.generate(
                  rows,
                  (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: List.generate(7, (col) {
                            final day = cells[row * 7 + col];
                            if (day == null) {
                              return const Expanded(
                                  child: SizedBox(height: 44));
                            }
                            final dayVax = vaccines[day] ?? [];
                            final isSelected = day == _selectedDay;
                            return Expanded(
                              child: GestureDetector(
                                onTap: dayVax.isNotEmpty
                                    ? () => setState(() =>
                                        _selectedDay =
                                            isSelected ? null : day)
                                    : null,
                                child: _CalDay(
                                  day: day,
                                  vaccines: dayVax,
                                  selected: isSelected,
                                ),
                              ),
                            );
                          }),
                        ),
                      )),
              const SizedBox(height: 8),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Dot(AppColors.red),
                  const SizedBox(width: 4),
                  Text('Atrasada', style: AppTextStyles.meta(size: 11)),
                  const SizedBox(width: 14),
                  _Dot(AppColors.amber),
                  const SizedBox(width: 4),
                  Text('Próxima', style: AppTextStyles.meta(size: 11)),
                  const SizedBox(width: 14),
                  _Dot(AppColors.green),
                  const SizedBox(width: 4),
                  Text('Em dia', style: AppTextStyles.meta(size: 11)),
                  const SizedBox(width: 14),
                  _Dot(AppColors.deep3),
                  const SizedBox(width: 4),
                  Text('Recomendada', style: AppTextStyles.meta(size: 11)),
                ],
              ),
            ],
          ),
        ),
        // Selected day vaccines
        if (selected != null && selectedVaccines.isNotEmpty) ...[
          const SizedBox(height: 16),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vacinas em ${_monthNames[_month.month].toLowerCase()} $selected',
                  style: AppTextStyles.sans(
                      size: 13,
                      weight: FontWeight.w800,
                      color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                for (final v in selectedVaccines) ...[
                  _VaxCard(data: v, onAgendar: widget.onAgendar),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
        // Show months with vaccines if none in current month
        if (vaccines.isEmpty) ...[
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.circular(16)),
                  child: SyringeIcon(size: 26, color: AppColors.faint),
                ),
                const SizedBox(height: 12),
                Text('Sem vacinas neste mês',
                    style: AppTextStyles.sans(
                        size: 14,
                        weight: FontWeight.w800,
                        color: AppColors.muted)),
                const SizedBox(height: 4),
                Text('Use as setas para navegar entre os meses.',
                    style: AppTextStyles.meta(size: 12)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _CalDay extends StatelessWidget {
  final int day;
  final List<_VaxData> vaccines;
  final bool selected;
  const _CalDay(
      {required this.day,
      required this.vaccines,
      required this.selected});

  Color _dotColor(_VaxData v) => switch (v.variant) {
        TagVariant.red => AppColors.red,
        TagVariant.amber => AppColors.amber,
        TagVariant.green => AppColors.green,
        TagVariant.soft => AppColors.deep3,
      };

  @override
  Widget build(BuildContext context) {
    final hasVax = vaccines.isNotEmpty;
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$day',
            style: AppTextStyles.sans(
              size: 14,
              weight: hasVax ? FontWeight.w800 : FontWeight.w600,
              color: selected
                  ? Colors.white
                  : hasVax
                      ? AppColors.deep
                      : AppColors.ink,
            ),
          ),
          if (hasVax)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: vaccines
                  .take(3)
                  .map((v) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: _Dot(
                          selected ? Colors.white.withValues(alpha: 0.85) : _dotColor(v),
                          size: 5,
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;
  const _Dot(this.color, {this.size = 6});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class _MonthNavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MonthNavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: AppColors.chip,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 20, color: AppColors.deep),
        ),
      );
}

// ─── Shared widgets ───────────────────────────────────────────────────────────

class _PetBubble extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _PetBubble(
      {required this.name, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPlus = name == '+';
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
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
                  : PetIcon(
                      size: 24,
                      color: AppColors.deep,
                      kind: name == 'Mingau' ? PetKind.cat : PetKind.dog,
                    ),
            ),
          ),
          if (!isPlus) ...[
            const SizedBox(height: 4),
            Text(name,
                style: AppTextStyles.sans(
                    size: 11,
                    weight: FontWeight.w800,
                    color: selected ? AppColors.deep : AppColors.muted)),
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
        border: Border.all(
            color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: AppTextStyles.sans(
              size: 13,
              weight: FontWeight.w800,
              color: selected ? Colors.white : AppColors.muted)),
    );
  }
}

class _SectionBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _SectionBadge(
      {required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(label.toUpperCase(),
              style: AppTextStyles.eyebrow(),
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(99)),
          child: Text('$count',
              style: AppTextStyles.sans(
                  size: 11, weight: FontWeight.w800, color: color)),
        ),
      ],
    );
  }
}

class _VaxCard extends StatelessWidget {
  final _VaxData data;
  final VoidCallback onAgendar;

  const _VaxCard({required this.data, required this.onAgendar});

  Color get _countdownColor => switch (data.variant) {
        TagVariant.red => AppColors.red,
        TagVariant.amber => AppColors.amber,
        _ => AppColors.muted,
      };

  bool get _needsAction =>
      data.variant == TagVariant.red || data.variant == TagVariant.amber;

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.chip,
                    borderRadius: BorderRadius.circular(12)),
                child:
                    Center(child: SyringeIcon(size: 20, color: AppColors.deep)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.nome,
                        style: AppTextStyles.sans(
                            size: 14, weight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Row(children: [
                      PawIcon(size: 11, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text(data.pet, style: AppTextStyles.meta(size: 12)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PvTag(label: data.statusLabel, variant: data.variant),
                  const SizedBox(height: 5),
                  Text(data.countdown,
                      style: AppTextStyles.sans(
                          size: 11,
                          weight: FontWeight.w800,
                          color: _countdownColor)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              _DateChip(
                  label: 'Aplicada',
                  date: _fmt(data.date.subtract(const Duration(days: 365)))),
              _DateChip(label: 'Próxima', date: _fmt(data.date)),
            ],
          ),
          if (_needsAction) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAgendar,
                icon: const Icon(Icons.calendar_today_outlined, size: 14),
                label: const Text('Agendar agora'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deep,
                  foregroundColor: Colors.white,
                  textStyle:
                      AppTextStyles.sans(size: 12.5, weight: FontWeight.w800),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year.toString().substring(2)}';
}

class _RecoVaxCard extends StatelessWidget {
  final _VaxData data;
  final VoidCallback onAgendar;
  const _RecoVaxCard({required this.data, required this.onAgendar});

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.deep.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                      color: AppColors.deep.withValues(alpha: 0.15)),
                ),
                child: Center(
                    child: SyringeIcon(size: 18, color: AppColors.deep3)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.nome,
                        style: AppTextStyles.sans(
                            size: 14, weight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Icon(Icons.event_outlined,
                          size: 12, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Ideal: ${_fmt(data.date)}',
                          style: AppTextStyles.meta(size: 11.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const PvTag(label: 'Recomendada', variant: TagVariant.soft),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _desc(data.nome),
            style: AppTextStyles.sans(
                size: 13, weight: FontWeight.w600, color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onAgendar,
              icon: const Icon(Icons.add_circle_outline, size: 16),
              label: const Text('Agendar para a data ideal'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.deep,
                backgroundColor: AppColors.chip,
                side: BorderSide.none,
                textStyle:
                    AppTextStyles.sans(size: 13, weight: FontWeight.w800),
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _desc(String nome) {
    if (nome.contains('Calici')) {
      return 'Indicada para gatos com acesso à rua ou contato com outros felinos.';
    }
    if (nome.contains('Herpes')) {
      return 'Previne rinotraqueíte viral felina. Reforçado após quadro de infecção respiratória.';
    }
    return 'Recomendada para gatos que frequentam abrigos ou ambientes coletivos.';
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
      decoration: BoxDecoration(
          color: AppColors.chip, borderRadius: BorderRadius.circular(8)),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.sans(
              size: 11, weight: FontWeight.w600, color: AppColors.muted),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
                text: date,
                style: AppTextStyles.sans(
                    size: 11,
                    weight: FontWeight.w800,
                    color: AppColors.ink)),
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
          Expanded(
              child: _Stat(
                  label: 'Em dia', value: '2', color: AppColors.green)),
          _VertDivider(),
          Expanded(
              child: _Stat(
                  label: 'Vence em breve', value: '1', color: AppColors.amber)),
          _VertDivider(),
          Expanded(
              child:
                  _Stat(label: 'Atrasadas', value: '1', color: AppColors.red)),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Stat(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h1(size: 28, color: color)),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: AppTextStyles.sans(
                size: 11, weight: FontWeight.w700, color: AppColors.muted)),
      ],
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 44, color: AppColors.line);
}
