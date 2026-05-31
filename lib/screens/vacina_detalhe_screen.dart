import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/syringe_icon.dart';

class VacinaDetalheScreen extends StatelessWidget {
  const VacinaDetalheScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PvStatusBar(),
              PvPushHeader(
                title: 'Detalhes da vacina',
                right: const PvTag(label: 'Vence em breve', variant: TagVariant.amber),
              ),
              // Hero card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.deep, AppColors.deep3],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: SyringeIcon(size: 26, color: Colors.white)),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Antirrábica',
                      style: GoogleFonts.fraunces(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vacina obrigatória · Protocolo anual',
                      style: AppTextStyles.sans(
                        size: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 28,
                      runSpacing: 10,
                      children: [
                        _HeroStat(label: 'Aplicada em', value: '22/12/2024'),
                        _HeroStat(label: 'Próxima dose', value: '22/12/2025'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Alert
              Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(
                  color: AppColors.amberBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.amber.withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule_outlined, color: AppColors.amber, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Próxima dose em 28 dias',
                            style: AppTextStyles.sans(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: const Color(0xFF9C6A1C),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Agende com antecedência para garantir disponibilidade.',
                            style: AppTextStyles.sans(size: 12, color: AppColors.amber),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Info card
              PvCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.pets,
                      label: 'Pet',
                      value: 'Mingau · Gato SRD · Fêmea',
                    ),
                    const Divider(color: AppColors.line, height: 22),
                    _InfoRow(
                      icon: Icons.medical_information_outlined,
                      label: 'Lote / fabricante',
                      value: 'RVF-2024-3812 · MSD Saúde Animal',
                    ),
                    const Divider(color: AppColors.line, height: 22),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Clínica',
                      value: 'Clínica VetCare Bom Retiro',
                    ),
                    const Divider(color: AppColors.line, height: 22),
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Veterinário',
                      value: 'Dr. Francisco Alves · CRMV 12.345',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Observações
              PvCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Observações',
                      style: AppTextStyles.sans(
                        size: 12.5,
                        weight: FontWeight.w800,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mingau apresentou leve reação local (inchaço no ponto de aplicação) que regrediu em 24h. Não há contraindicações para doses futuras.',
                      style: AppTextStyles.sans(size: 14, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/agendar'),
                  icon: const Icon(Icons.calendar_month_outlined, size: 18),
                  label: const Text('Agendar próxima dose'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deep,
                    foregroundColor: Colors.white,
                    textStyle: AppTextStyles.sans(
                      size: 15,
                      weight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text('Exportar comprovante'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.deep,
                    backgroundColor: AppColors.chip,
                    side: BorderSide.none,
                    textStyle: AppTextStyles.sans(
                      size: 15,
                      weight: FontWeight.w800,
                      color: AppColors.deep,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.sans(
              size: 11,
              weight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.fraunces(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.chip,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: AppColors.deep3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.sans(
                    size: 11,
                    weight: FontWeight.w700,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: AppTextStyles.sans(size: 13.5, weight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      );
}
