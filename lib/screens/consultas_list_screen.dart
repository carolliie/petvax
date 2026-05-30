import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';

class ConsultasListScreen extends StatefulWidget {
  const ConsultasListScreen({super.key});
  @override
  State<ConsultasListScreen> createState() => _ConsultasListScreenState();
}

class _ConsultasListScreenState extends State<ConsultasListScreen> {
  String _tab = 'Próximas';

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
                        Expanded(child: Text('Consultas', style: AppTextStyles.h1(size: 27))),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/agendar'),
                          child: Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: AppColors.deep, borderRadius: BorderRadius.circular(14)),
                            child: const Icon(Icons.add, color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Search
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.line, width: 1.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(children: [
                        const Icon(Icons.search, size: 18, color: AppColors.faint),
                        const SizedBox(width: 8),
                        Text('Buscar consulta…', style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
                      ]),
                    ),
                    const SizedBox(height: 14),
                    // Tabs
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: ['Próximas', 'Anteriores', 'Canceladas'].map((t) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _tab = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                              decoration: BoxDecoration(
                                color: _tab == t ? AppColors.deep : Colors.white,
                                border: Border.all(color: _tab == t ? AppColors.deep : AppColors.line, width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(t, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: _tab == t ? Colors.white : AppColors.muted)),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (_tab == 'Próximas') _buildProximas(context)
                    else if (_tab == 'Anteriores') _buildAnteriores(context)
                    else _buildEmpty(),
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

  Widget _buildProximas(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionLabel(label: 'Setembro 2025', count: 2),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/consulta-detalhe'),
        child: _ConsultaCard(
          nome: 'Dr. Francisco', esp: 'Veterinário geral · Mingau',
          data: '02/09', hora: '14:00h', local: 'Av. Frei Vicente, 782',
          status: 'Confirmada',
        ),
      ),
      const SizedBox(height: 10),
      _ConsultaCard(
        nome: 'Dra. Helena Sá', esp: 'Dermatologia · Theo',
        data: '18/09', hora: '09:30h', local: 'Clínica VidaPet',
        status: 'Pendente',
      ),
      const SizedBox(height: 18),
      _SectionLabel(label: 'Outubro 2025', count: 1),
      const SizedBox(height: 10),
      _ConsultaCard(
        nome: 'Dr. Felipe Braga', esp: 'Ortopedia · Theo',
        data: '08/10', hora: '10:00h', local: 'Hospital VetCenter',
        status: 'Pendente',
      ),
      const SizedBox(height: 18),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/agendar'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.line, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_circle_outline, size: 18, color: AppColors.deep),
              const SizedBox(width: 8),
              Text('Agendar nova consulta', style: AppTextStyles.sans(size: 14, weight: FontWeight.w800, color: AppColors.deep)),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildAnteriores(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionLabel(label: 'Agosto 2025', count: 2),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/consulta-detalhe'),
        child: _ConsultaCard(
          nome: 'Dr. Francisco', esp: 'Retorno · Mingau',
          data: '12/08', hora: '15:00h', local: 'Av. Frei Vicente, 782',
          status: 'Realizada',
        ),
      ),
      const SizedBox(height: 10),
      _ConsultaCard(
        nome: 'Dra. Helena Sá', esp: 'Dermatologia · Theo',
        data: '05/08', hora: '09:30h', local: 'Clínica VidaPet',
        status: 'Realizada',
      ),
      const SizedBox(height: 18),
      _SectionLabel(label: 'Junho 2025', count: 1),
      const SizedBox(height: 10),
      _ConsultaCard(
        nome: 'Dr. Francisco', esp: 'Rotina · Mingau',
        data: '15/06', hora: '14:00h', local: 'Av. Frei Vicente, 782',
        status: 'Realizada',
      ),
      const SizedBox(height: 18),
      _SectionLabel(label: 'Março 2025', count: 1),
      const SizedBox(height: 10),
      _ConsultaCard(
        nome: 'Dr. Francisco', esp: 'Pós-operatório · Mingau',
        data: '20/03', hora: '11:00h', local: 'Av. Frei Vicente, 782',
        status: 'Realizada',
      ),
    ],
  );

  Widget _buildEmpty() => Padding(
    padding: const EdgeInsets.only(top: 48),
    child: Center(
      child: Column(
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.event_busy_outlined, size: 36, color: AppColors.deep3),
          ),
          const SizedBox(height: 16),
          Text('Nenhuma consulta cancelada', style: AppTextStyles.h3(size: 16)),
          const SizedBox(height: 8),
          Text('Consultas canceladas\naparecerão aqui.', textAlign: TextAlign.center, style: AppTextStyles.meta()),
        ],
      ),
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final int count;
  const _SectionLabel({required this.label, required this.count});

  @override
  Widget build(BuildContext context) => Row(children: [
    Text(label.toUpperCase(), style: AppTextStyles.eyebrow()),
    const SizedBox(width: 8),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(99)),
      child: Text('$count', style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: AppColors.deep)),
    ),
  ]);
}

class _ConsultaCard extends StatelessWidget {
  final String nome, esp, data, hora, status;
  final String? local;
  const _ConsultaCard({required this.nome, required this.esp, required this.data, required this.hora, required this.status, this.local});

  @override
  Widget build(BuildContext context) {
    final variant = switch (status) {
      'Confirmada' => TagVariant.green,
      'Pendente'   => TagVariant.amber,
      'Realizada'  => TagVariant.soft,
      _            => TagVariant.soft,
    };

    return PvCard(
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome, style: AppTextStyles.h3(size: 16)),
                  Text(esp, style: GoogleFonts.fraunces(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.muted)),
                ],
              )),
              PvTag(label: status, variant: variant),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            _Pill(icon: Icons.calendar_today_outlined, label: data),
            const SizedBox(width: 10),
            _Pill(icon: Icons.access_time, label: hora),
            if (local != null) ...[
              const SizedBox(width: 10),
              Expanded(child: _Pill(icon: Icons.location_on_outlined, label: local!)),
            ],
          ]),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Pill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 13, color: AppColors.deep3),
      const SizedBox(width: 4),
      Flexible(child: Text(label, style: AppTextStyles.sans(size: 12, weight: FontWeight.w700, color: AppColors.muted), overflow: TextOverflow.ellipsis)),
    ],
  );
}
