import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/paw_icon.dart';
import '../widgets/syringe_icon.dart';

class AgendarVacinaScreen extends StatefulWidget {
  const AgendarVacinaScreen({super.key});

  @override
  State<AgendarVacinaScreen> createState() => _AgendarVacinaScreenState();
}

class _AgendarVacinaScreenState extends State<AgendarVacinaScreen> {
  String _pet = 'Mingau';
  String _vacina = 'Antirrábica';
  int _selectedDay = 10;
  String? _selectedTime = '10:00';
  bool _confirmed = false;

  static const _vacinas = [
    'Antirrábica',
    'V4 (Quádrupla felina)',
    'Leucemia felina (FeLV)',
    'Giárdia',
    'V8 / V10 (Cão)',
  ];

  static final int _startOffset = DateTime(2025, 12, 1).weekday % 7;
  static final int _daysInMonth = DateTime(2026, 1, 0).day;
  static const _monthLabel = 'Dezembro 2025';
  static const _dayHeaders = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB'];
  static const _unavailable = {7, 14, 21, 28};
  static const _times = ['08:00', '09:00', '10:00', '11:00', '14:00', '15:30'];
  static const _occupied = {'09:00'};

  @override
  Widget build(BuildContext context) {
    if (_confirmed) return _SuccessView(pet: _pet, vacina: _vacina, day: _selectedDay, time: _selectedTime ?? '');

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const PvStatusBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 6, 22, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PvPushHeader(title: 'Agendar vacina'),
                    _petSelector(),
                    const SizedBox(height: 16),
                    _vacinaSelector(),
                    const SizedBox(height: 16),
                    _vetInfo(),
                    const SizedBox(height: 16),
                    _calendarSection(),
                    const SizedBox(height: 16),
                    _timeSection(),
                    const SizedBox(height: 16),
                    _noteField(),
                    const SizedBox(height: 24),
                    _confirmButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Pet selector ─────────────────────────────────────────────────────────

  Widget _petSelector() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Para qual pet?', style: AppTextStyles.label()),
          const SizedBox(height: 7),
          Row(children: [
            _PetChip(
                label: 'Mingau',
                selected: _pet == 'Mingau',
                onTap: () => setState(() => _pet = 'Mingau')),
            const SizedBox(width: 8),
            _PetChip(
                label: 'Theo',
                selected: _pet == 'Theo',
                onTap: () => setState(() => _pet = 'Theo')),
          ]),
        ],
      );

  // ── Vacina selector ───────────────────────────────────────────────────────

  Widget _vacinaSelector() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vacina', style: AppTextStyles.label()),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 4, 6, 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.line, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _vacina,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: AppColors.faint),
                style: AppTextStyles.sans(size: 14, weight: FontWeight.w800),
                items: _vacinas
                    .map((v) => DropdownMenuItem(
                          value: v,
                          child: Row(
                            children: [
                              SyringeIcon(size: 16, color: AppColors.deep3),
                              const SizedBox(width: 8),
                              Text(v),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _vacina = v!),
              ),
            ),
          ),
        ],
      );

  // ── Vet info ──────────────────────────────────────────────────────────────

  Widget _vetInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Veterinário responsável', style: AppTextStyles.label()),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.line, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.person_outline,
                      size: 18, color: AppColors.deep),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. Francisco',
                          style: AppTextStyles.sans(
                              size: 14, weight: FontWeight.w800)),
                      Text('Clínica VetCare · CRMV-SP 28.114',
                          style: AppTextStyles.meta(size: 11.5)),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: AppColors.faint),
              ],
            ),
          ),
        ],
      );

  // ── Calendar ──────────────────────────────────────────────────────────────

  Widget _calendarSection() {
    final totalCells = ((_startOffset + _daysInMonth) / 7).ceil() * 7;
    final cells = List<int?>.generate(totalCells, (i) {
      final day = i - _startOffset + 1;
      return (day >= 1 && day <= _daysInMonth) ? day : null;
    });
    final rows = cells.length ~/ 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data', style: AppTextStyles.label()),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line, width: 1.5),
          ),
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavBtn(icon: Icons.chevron_left, active: false),
                  Text(_monthLabel,
                      style: AppTextStyles.sans(
                          size: 14,
                          weight: FontWeight.w800,
                          color: AppColors.deep)),
                  _NavBtn(icon: Icons.chevron_right, active: true),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: _dayHeaders
                    .map((d) => Expanded(
                          child: Center(
                            child: Text(d,
                                style: AppTextStyles.sans(
                                    size: 10,
                                    weight: FontWeight.w800,
                                    color: AppColors.faint)),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                  rows,
                  (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: List.generate(7, (col) {
                            final day = cells[row * 7 + col];
                            return Expanded(
                              child: _DayCell(
                                day: day,
                                selected: day == _selectedDay,
                                past: day != null && day < 10,
                                unavailable:
                                    day != null && _unavailable.contains(day),
                                recommended: day != null && day == 22,
                                onTap: (d) =>
                                    setState(() => _selectedDay = d),
                              ),
                            );
                          }),
                        ),
                      )),
              const SizedBox(height: 6),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LegendDot(color: AppColors.deep, label: 'Disponível'),
                  const SizedBox(width: 16),
                  _LegendDot(color: AppColors.amber, label: 'Recomendado'),
                  const SizedBox(width: 16),
                  _LegendDot(color: AppColors.faint, label: 'Indisponível'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Time slots ────────────────────────────────────────────────────────────

  Widget _timeSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Horário', style: AppTextStyles.label()),
            const SizedBox(width: 8),
            Text('$_selectedDay de dezembro · Dr. Francisco',
                style: AppTextStyles.sans(
                    size: 12, color: AppColors.muted, weight: FontWeight.w600)),
          ]),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.4,
            children: _times.map((t) {
              final sel = t == _selectedTime;
              final occ = _occupied.contains(t);
              return GestureDetector(
                onTap: !occ ? () => setState(() => _selectedTime = t) : null,
                child: Opacity(
                  opacity: occ ? 0.4 : 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: sel ? AppColors.deep : Colors.white,
                      border: Border.all(
                          color: sel ? AppColors.deep : AppColors.line,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(t,
                            style: AppTextStyles.sans(
                                size: 13,
                                weight: FontWeight.w800,
                                color: sel ? Colors.white : AppColors.ink)),
                        if (occ)
                          Text('Ocupado',
                              style: AppTextStyles.sans(
                                  size: 9,
                                  weight: FontWeight.w800,
                                  color: AppColors.red)),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );

  // ── Note field ────────────────────────────────────────────────────────────

  Widget _noteField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Observações (opcional)', style: AppTextStyles.label()),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 13, 14, 48),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.line, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text('Ex: pet sensível a injeções, histórico de reações…',
                style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
          ),
        ],
      );

  // ── Confirm button ────────────────────────────────────────────────────────

  Widget _confirmButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => setState(() => _confirmed = true),
          icon: const Icon(Icons.check, size: 18),
          label: const Text('Confirmar agendamento'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deep,
            foregroundColor: Colors.white,
            textStyle:
                AppTextStyles.sans(size: 15, weight: FontWeight.w800),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
        ),
      );
}

// ─── Success view ─────────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  final String pet;
  final String vacina;
  final int day;
  final String time;
  const _SuccessView(
      {required this.pet, required this.vacina, required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 40, 22, 32),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: AppColors.greenBg, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle_outline,
                    color: AppColors.green, size: 44),
              ),
              const SizedBox(height: 20),
              Text('Vacina agendada!',
                  style: AppTextStyles.h1(size: 28),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Seu agendamento foi confirmado com sucesso.',
                style: AppTextStyles.meta(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PvCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _ConfirmRow(icon: Icons.pets, label: 'Pet', value: pet),
                    const Divider(color: AppColors.line, height: 22),
                    _ConfirmRow(
                        icon: Icons.vaccines_outlined,
                        label: 'Vacina',
                        value: vacina),
                    const Divider(color: AppColors.line, height: 22),
                    _ConfirmRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Data',
                        value: '$day de dezembro de 2025'),
                    const Divider(color: AppColors.line, height: 22),
                    _ConfirmRow(
                        icon: Icons.access_time_outlined,
                        label: 'Horário',
                        value: time),
                    const Divider(color: AppColors.line, height: 22),
                    _ConfirmRow(
                        icon: Icons.person_outline,
                        label: 'Veterinário',
                        value: 'Dr. Francisco · VetCare'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.chip,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_outlined,
                        size: 18, color: AppColors.deep3),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Você receberá um lembrete 1 dia antes do agendamento.',
                        style: AppTextStyles.meta(size: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deep,
                    foregroundColor: Colors.white,
                    textStyle:
                        AppTextStyles.sans(size: 15, weight: FontWeight.w800),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Ir para o início'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/carteirinha'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.deep,
                    backgroundColor: AppColors.chip,
                    side: BorderSide.none,
                    textStyle:
                        AppTextStyles.sans(size: 15, weight: FontWeight.w800),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Ver carteirinha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ConfirmRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: AppColors.chip, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: AppColors.deep3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyles.sans(
                        size: 11, weight: FontWeight.w700, color: AppColors.muted)),
                Text(value,
                    style: AppTextStyles.sans(
                        size: 13.5, weight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      );
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _PetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PetChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 9, 14, 9),
          decoration: BoxDecoration(
            color: selected ? AppColors.deep : Colors.white,
            border: Border.all(
                color: selected ? AppColors.deep : AppColors.line, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PawIcon(
                  size: 14,
                  color: selected ? Colors.white : AppColors.deep3),
              const SizedBox(width: 6),
              Text(label,
                  style: AppTextStyles.sans(
                      size: 13,
                      weight: FontWeight.w800,
                      color: selected ? Colors.white : AppColors.muted)),
            ],
          ),
        ),
      );
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final bool active;
  const _NavBtn({required this.icon, required this.active});

  @override
  Widget build(BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: active
              ? AppColors.chip
              : AppColors.chip.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon,
            size: 18, color: active ? AppColors.deep : AppColors.faint),
      );
}

class _DayCell extends StatelessWidget {
  final int? day;
  final bool selected;
  final bool past;
  final bool unavailable;
  final bool recommended;
  final Function(int) onTap;

  const _DayCell({
    this.day,
    required this.selected,
    required this.past,
    required this.unavailable,
    this.recommended = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (day == null) return const SizedBox(height: 36);

    Color bg = Colors.transparent;
    Color textColor = AppColors.ink;
    FontWeight weight = FontWeight.w600;

    if (selected) {
      bg = AppColors.deep;
      textColor = Colors.white;
      weight = FontWeight.w900;
    } else if (past || unavailable) {
      textColor = AppColors.faint;
    } else if (recommended) {
      bg = AppColors.amberBg;
      textColor = AppColors.amber;
      weight = FontWeight.w800;
    } else {
      weight = FontWeight.w700;
    }

    return GestureDetector(
      onTap: (!past && !unavailable) ? () => onTap(day!) : null,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$day',
                  style: AppTextStyles.sans(
                      size: 13.5, weight: weight, color: textColor)),
              if (recommended && !selected)
                Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.amber, shape: BoxShape.circle)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.meta(size: 11)),
        ],
      );
}
