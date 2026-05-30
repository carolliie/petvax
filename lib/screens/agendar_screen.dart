import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/paw_icon.dart';

class AgendarScreen extends StatefulWidget {
  const AgendarScreen({super.key});
  @override
  State<AgendarScreen> createState() => _AgendarScreenState();
}

class _AgendarScreenState extends State<AgendarScreen> {
  String _pet = 'Mingau';
  int _selectedDay = 2;
  String? _selectedTime = '14:00';

  // September 2025: Sep 1 = Monday. Dart weekday: Mon=1, Sun=7.
  // In Sun-first calendar (Sun=0): offset = weekday % 7 = 1 % 7 = 1
  static final int _startOffset = DateTime(2025, 9, 1).weekday % 7;
  static final int _daysInMonth = DateTime(2025, 10, 0).day; // 30
  static const _monthLabel = 'Setembro 2025';
  static const _dayHeaders = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB'];
  static const _times = ['08:00', '09:30', '11:00', '14:00', '15:30', '17:00'];
  // Weekends are marked unavailable for this vet
  static const _unavailable = {7, 14, 21, 28}; // Sundays
  static const _occupied = {'09:30'}; // Booked slot for selected day

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
                padding: const EdgeInsets.fromLTRB(22, 6, 22, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PvPushHeader(title: 'Agendar consulta'),
                    _petSelector(),
                    const SizedBox(height: 16),
                    _vetSelector(),
                    const SizedBox(height: 16),
                    _calendarSection(),
                    const SizedBox(height: 16),
                    _timeSection(),
                    const SizedBox(height: 16),
                    _reasonField(),
                    const SizedBox(height: 24),
                    _confirmButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _petSelector() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Para qual pet?', style: AppTextStyles.label()),
      const SizedBox(height: 7),
      Row(children: [
        _PetChip(label: 'Mingau', selected: _pet == 'Mingau', onTap: () => setState(() => _pet = 'Mingau')),
        const SizedBox(width: 8),
        _PetChip(label: 'Theo', selected: _pet == 'Theo', onTap: () => setState(() => _pet = 'Theo')),
      ]),
    ],
  );

  Widget _vetSelector() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Veterinário', style: AppTextStyles.label()),
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
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.person_outline, size: 18, color: AppColors.deep),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Francisco', style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
                Text('Veterinário geral · CRMV-SP 28.114', style: AppTextStyles.meta(size: 11.5)),
              ],
            )),
            const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.faint),
          ],
        ),
      ),
    ],
  );

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
              // Month navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavBtn(icon: Icons.chevron_left, active: false),
                  Text(_monthLabel, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800, color: AppColors.deep)),
                  _NavBtn(icon: Icons.chevron_right, active: true),
                ],
              ),
              const SizedBox(height: 14),
              // Day headers
              Row(
                children: _dayHeaders.map((d) => Expanded(
                  child: Center(
                    child: Text(d, style: AppTextStyles.sans(size: 10, weight: FontWeight.w800, color: AppColors.faint)),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8),
              // Date grid
              ...List.generate(rows, (row) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: List.generate(7, (col) {
                    final day = cells[row * 7 + col];
                    return Expanded(child: _DayCell(
                      day: day,
                      selected: day == _selectedDay,
                      past: day != null && day < 2,
                      unavailable: day != null && _unavailable.contains(day),
                      onTap: (d) => setState(() => _selectedDay = d),
                    ));
                  }),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timeSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Text('Horário', style: AppTextStyles.label()),
        const SizedBox(width: 8),
        Text('$_selectedDay de setembro · Dr. Francisco', style: AppTextStyles.sans(size: 12, color: AppColors.muted, weight: FontWeight.w600)),
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
                  border: Border.all(color: sel ? AppColors.deep : AppColors.line, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: sel ? Colors.white : AppColors.ink)),
                    if (occ)
                      Text('Ocupado', style: AppTextStyles.sans(size: 9, weight: FontWeight.w800, color: AppColors.red)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );

  Widget _reasonField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Motivo da consulta', style: AppTextStyles.label()),
      const SizedBox(height: 7),
      Container(
        padding: const EdgeInsets.fromLTRB(14, 13, 14, 48),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.line, width: 1.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text('Descreva o motivo da consulta…', style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
      ),
    ],
  );

  Widget _confirmButton(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.check, size: 18),
      label: const Text('Confirmar agendamento'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deep,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.sans(size: 15, weight: FontWeight.w800),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    ),
  );
}

class _PetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PetChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 9, 14, 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.white,
        border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PawIcon(size: 14, color: selected ? Colors.white : AppColors.deep3),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
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
    width: 32, height: 32,
    decoration: BoxDecoration(
      color: active ? AppColors.chip : AppColors.chip.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Icon(icon, size: 18, color: active ? AppColors.deep : AppColors.faint),
  );
}

class _DayCell extends StatelessWidget {
  final int? day;
  final bool selected;
  final bool past;
  final bool unavailable;
  final Function(int) onTap;

  const _DayCell({this.day, required this.selected, required this.past, required this.unavailable, required this.onTap});

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
              Text('$day', style: AppTextStyles.sans(size: 13.5, weight: weight, color: textColor)),
              if (unavailable && !selected)
                Container(width: 4, height: 4, decoration: BoxDecoration(color: AppColors.faint, shape: BoxShape.circle)),
            ],
          ),
        ),
      ),
    );
  }
}
