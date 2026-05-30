import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';

class ProcedimentosScreen extends StatefulWidget {
  const ProcedimentosScreen({super.key});
  @override
  State<ProcedimentosScreen> createState() => _ProcedimentosScreenState();
}

class _ProcedimentosScreenState extends State<ProcedimentosScreen> {
  String _filter = 'Todos';
  String _pet = 'Mingau';

  static const _filters = ['Todos', 'Cirurgias', 'Tratamentos', 'Terapias', 'Exames'];

  static const _procedures = [
    (
      tipo: 'Cirurgias',
      nome: 'Castração',
      vet: 'Dr. Francisco',
      clinica: 'Clínica VetCenter',
      data: '10/03/2025',
      status: 'Concluído',
      duracao: '1 sessão',
      pet: 'Mingau',
      obs: 'Pós-operatório sem intercorrências.',
    ),
    (
      tipo: 'Terapias',
      nome: 'Fisioterapia — reabilitação pós-fratura',
      vet: 'Dra. Carla Mendes',
      clinica: 'Centro VidaPet',
      data: '15/09/2025',
      status: 'Em andamento',
      duracao: '3/10 sessões',
      pet: 'Theo',
      obs: '',
    ),
    (
      tipo: 'Tratamentos',
      nome: 'Tratamento dermatológico',
      vet: 'Dra. Helena Sá',
      clinica: 'Clínica VidaPet',
      data: '18/08/2025',
      status: 'Em andamento',
      duracao: '30 dias',
      pet: 'Mingau',
      obs: 'Usar shampoo a cada 3 dias.',
    ),
    (
      tipo: 'Exames',
      nome: 'Ecocardiograma',
      vet: 'Dr. Francisco',
      clinica: 'Av. Frei Vicente, 782',
      data: '02/09/2025',
      status: 'Agendado',
      duracao: '1 sessão',
      pet: 'Mingau',
      obs: 'Monitoramento do sopro cardíaco grau II.',
    ),
    (
      tipo: 'Cirurgias',
      nome: 'Limpeza dentária (profilaxia)',
      vet: 'Dra. Helena Sá',
      clinica: 'Clínica VidaPet',
      data: '20/01/2025',
      status: 'Concluído',
      duracao: '1 sessão',
      pet: 'Theo',
      obs: '',
    ),
    (
      tipo: 'Exames',
      nome: 'Hemograma completo',
      vet: 'Dr. Francisco',
      clinica: 'Av. Frei Vicente, 782',
      data: '12/08/2025',
      status: 'Concluído',
      duracao: '1 sessão',
      pet: 'Mingau',
      obs: 'Resultados normais para a espécie.',
    ),
  ];

  List get _filtered => _filter == 'Todos'
      ? _procedures
      : _procedures.where((p) => p.tipo == _filter).toList();

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
                    Row(
                      children: [
                        Expanded(child: Text('Procedimentos', style: AppTextStyles.h1(size: 27))),
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: AppColors.deep, borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.add, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Cirurgias, tratamentos, terapias e exames', style: AppTextStyles.meta()),
                    const SizedBox(height: 14),
                    // Pet selector
                    Row(
                      children: [
                        _PetTab(name: 'Mingau', selected: _pet == 'Mingau', onTap: () => setState(() => _pet = 'Mingau')),
                        const SizedBox(width: 8),
                        _PetTab(name: 'Theo', selected: _pet == 'Theo', onTap: () => setState(() => _pet = 'Theo')),
                        const SizedBox(width: 8),
                        _PetTab(name: 'Todos', selected: _pet == 'Todos', onTap: () => setState(() => _pet = 'Todos')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Type filters
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filters.map((f) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _filter = f),
                            child: _TypeChip(
                              label: f,
                              selected: _filter == f,
                              icon: _iconFor(f),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Stats row
                    const SizedBox(height: 14),
                    _StatsRow(items: _filtered),
                    const SizedBox(height: 14),
                    // List
                    ..._filtered.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ProcCard(p: p),
                    )),
                    if (_filtered.isEmpty) _EmptyState(filter: _filter),
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

  IconData _iconFor(String tipo) => switch (tipo) {
    'Cirurgias'    => Icons.cut_outlined,
    'Tratamentos'  => Icons.medication_outlined,
    'Terapias'     => Icons.self_improvement_outlined,
    'Exames'       => Icons.biotech_outlined,
    _              => Icons.medical_services_outlined,
  };
}

class _PetTab extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;
  const _PetTab({required this.name, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.deep : Colors.white,
          border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (name != 'Todos') ...[
              PawIcon(size: 12, color: selected ? Colors.white : AppColors.deep3),
              const SizedBox(width: 5),
            ],
            Text(name, style: AppTextStyles.sans(size: 12, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData icon;
  const _TypeChip({required this.label, required this.selected, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.white,
        border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: selected ? Colors.white : AppColors.muted),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List items;
  const _StatsRow({required this.items});

  @override
  Widget build(BuildContext context) {
    final concluidos = items.where((p) => p.status == 'Concluído').length;
    final andamento = items.where((p) => p.status == 'Em andamento').length;
    final agendados = items.where((p) => p.status == 'Agendado').length;

    return Row(
      children: [
        _StatBadge(label: 'Concluídos', count: concluidos, color: AppColors.green),
        const SizedBox(width: 8),
        _StatBadge(label: 'Em andamento', count: andamento, color: AppColors.amber),
        const SizedBox(width: 8),
        _StatBadge(label: 'Agendados', count: agendados, color: AppColors.deep),
      ],
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatBadge({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$count ', style: AppTextStyles.sans(size: 13, weight: FontWeight.w900, color: color)),
          Text(label, style: AppTextStyles.sans(size: 12, weight: FontWeight.w700, color: AppColors.muted)),
        ],
      ),
    );
  }
}

class _ProcCard extends StatelessWidget {
  final dynamic p;
  const _ProcCard({required this.p});

  @override
  Widget build(BuildContext context) {
    final statusVariant = switch (p.status) {
      'Concluído'    => TagVariant.green,
      'Em andamento' => TagVariant.amber,
      _              => TagVariant.soft,
    };

    final typeIcon = switch (p.tipo) {
      'Cirurgias'   => Icons.cut_outlined,
      'Tratamentos' => Icons.medication_outlined,
      'Terapias'    => Icons.self_improvement_outlined,
      'Exames'      => Icons.biotech_outlined,
      _             => Icons.medical_services_outlined,
    };

    final typeColor = switch (p.tipo) {
      'Cirurgias'   => AppColors.red,
      'Tratamentos' => AppColors.amber,
      'Terapias'    => AppColors.green,
      'Exames'      => AppColors.deep3,
      _             => AppColors.deep,
    };

    return PvCard(
      padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(typeIcon, size: 22, color: typeColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.nome, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text(
                      '${p.vet} · ${p.clinica}',
                      style: GoogleFonts.fraunces(fontSize: 12.5, fontStyle: FontStyle.italic, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              PvTag(label: p.status, variant: statusVariant),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.line, height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              _InfoPill(icon: Icons.calendar_today_outlined, label: p.data),
              const SizedBox(width: 8),
              _InfoPill(icon: Icons.repeat_outlined, label: p.duracao),
              const SizedBox(width: 8),
              _InfoPill(icon: Icons.pets_outlined, label: p.pet),
            ],
          ),
          if (p.obs.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 13, color: AppColors.deep3),
                  const SizedBox(width: 6),
                  Expanded(child: Text(p.obs, style: AppTextStyles.sans(size: 12, color: AppColors.muted))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.deep3),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.sans(size: 11.5, weight: FontWeight.w700, color: AppColors.muted)),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.medical_services_outlined, size: 36, color: AppColors.deep3),
            ),
            const SizedBox(height: 16),
            Text('Nenhum registro', style: AppTextStyles.h3(size: 16)),
            const SizedBox(height: 8),
            Text('Nenhum(a) "$filter" registrado(a)\npara este pet.', textAlign: TextAlign.center, style: AppTextStyles.meta()),
          ],
        ),
      ),
    );
  }
}
