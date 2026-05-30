import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_avatar.dart';
import '../widgets/pv_tag.dart';

class ConsultaDetalheScreen extends StatelessWidget {
  const ConsultaDetalheScreen({super.key});

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
                    PvPushHeader(
                      title: 'Consulta',
                      right: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/agendar'),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(color: AppColors.line, width: 1.5),
                          ),
                          child: const Icon(Icons.calendar_today_outlined, color: AppColors.deep, size: 20),
                        ),
                      ),
                    ),
                    PvCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              PvAvatar(
                                size: 52,
                                child: const Icon(Icons.person_outline, size: 26, color: AppColors.deep),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dr. Francisco', style: AppTextStyles.h3(size: 17)),
                                    Text(
                                      'Veterinário geral · CRMV-SP 28.114',
                                      style: GoogleFonts.fraunces(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.muted),
                                    ),
                                  ],
                                ),
                              ),
                              PvTag(
                                label: 'Confirmada',
                                variant: TagVariant.green,
                                icon: const Icon(Icons.check, size: 11, color: Color(0xFF2F7D5B)),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(color: AppColors.line, height: 1),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                            children: const [
                              _InfoCell(icon: Icons.calendar_today_outlined, label: 'Data', value: '02/09/2025'),
                              _InfoCell(icon: Icons.access_time, label: 'Horário', value: '14:00h'),
                              _InfoCell(icon: Icons.favorite_border, label: 'Paciente', value: 'Mingau'),
                              _InfoCell(icon: Icons.location_on_outlined, label: 'Local', value: 'Av. Frei Vicente, 782'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text('Motivo', style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 8),
                    PvCard(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      child: Text(
                        'Avaliação de rotina e renovação da vacina antirrábica.',
                        style: AppTextStyles.sans(size: 13.5),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text('Anexos', style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 8),
                    const _AttachRow(icon: Icons.medication_outlined, title: 'Receita médica', sub: '2 medicamentos · 02/09'),
                    const SizedBox(height: 10),
                    const _AttachRow(icon: Icons.description_outlined, title: 'Relatório de consulta', sub: 'PDF · 02/09'),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined, size: 17),
                            label: const Text('Remarcar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.deep,
                              backgroundColor: AppColors.chip,
                              side: BorderSide.none,
                              textStyle: AppTextStyles.sans(size: 15, weight: FontWeight.w800),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_outlined, size: 17),
                            label: const Text('Ver rota'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deep,
                              foregroundColor: Colors.white,
                              textStyle: AppTextStyles.sans(size: 15, weight: FontWeight.w800),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCell({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: AppColors.deep3),
            const SizedBox(width: 5),
            Text(label.toUpperCase(), style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: AppColors.muted).copyWith(letterSpacing: 0.06 * 11)),
          ],
        ),
        const SizedBox(height: 3),
        Text(value, style: AppTextStyles.sans(size: 14.5, weight: FontWeight.w800)),
      ],
    );
  }
}

class _AttachRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String sub;

  const _AttachRow({required this.icon, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 20, color: AppColors.deep),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
                Text(sub, style: AppTextStyles.meta(size: 11.5)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.faint),
        ],
      ),
    );
  }
}
