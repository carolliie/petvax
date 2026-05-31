import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';

class ReceitaDetalheScreen extends StatelessWidget {
  const ReceitaDetalheScreen({super.key});

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
                title: 'Receita médica',
                right: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _HeaderBtn(icon: Icons.download_outlined),
                    const SizedBox(width: 8),
                    _HeaderBtn(icon: Icons.share_outlined),
                  ],
                ),
              ),
              // ── Hero ──────────────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.medication_outlined,
                              size: 26, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tratamento dermatológico',
                                style: GoogleFonts.fraunces(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(children: [
                                PawIcon(size: 11, color: Colors.white.withValues(alpha: 0.75)),
                                const SizedBox(width: 4),
                                Text('Mingau',
                                    style: AppTextStyles.sans(
                                        size: 12.5,
                                        color: Colors.white.withValues(alpha: 0.85))),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 10,
                      children: const [
                        _HeroStat(label: 'Emitida em', value: '18/08/2025'),
                        _HeroStat(label: 'Válida até', value: '18/11/2025'),
                        _HeroStat(label: 'Dias restantes', value: '50'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Validity alert
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: AppColors.greenBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: AppColors.green.withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_outlined,
                        color: AppColors.green, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Receita vigente · 50 dias restantes',
                      style: AppTextStyles.sans(
                          size: 13,
                          weight: FontWeight.w800,
                          color: const Color(0xFF2F7D5B)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Vet card
              PvCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.chip,
                      child: const Icon(Icons.person_outline,
                          color: AppColors.deep3, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dra. Helena Sá',
                              style: AppTextStyles.sans(
                                  size: 14, weight: FontWeight.w800)),
                          Text('Dermatologista veterinária · CRMV 9.876',
                              style: AppTextStyles.meta(size: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        size: 18, color: AppColors.faint),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // ── Medicamentos ──────────────────────────────────────────────
              _SectionTitle(
                  icon: Icons.medication_outlined, label: 'Medicamentos'),
              const SizedBox(height: 12),
              _MedCard(
                nome: 'Apoquel 5,4 mg',
                tipo: 'Antiprurígínico',
                dosagem: '1 comprimido',
                frequencia: '2x ao dia',
                duracao: '30 dias',
                instrucoes:
                    'Administrar com alimento para reduzir irritação gástrica. Evitar uso conjunto com outros imunossupressores.',
                color: AppColors.deep,
              ),
              const SizedBox(height: 10),
              _MedCard(
                nome: 'Ômega 3 Vetplus',
                tipo: 'Suplemento',
                dosagem: '1 cápsula (500 mg)',
                frequencia: '1x ao dia',
                duracao: 'Uso contínuo',
                instrucoes:
                    'Pode ser administrado junto à ração ou aberto sobre o alimento. Armazenar em local fresco e seco.',
                color: AppColors.green,
              ),
              const SizedBox(height: 10),
              _MedCard(
                nome: 'Shampoo Dermovet',
                tipo: 'Dermatológico tópico',
                dosagem: 'Aplicação tópica',
                frequencia: '2x por semana',
                duracao: '4 semanas',
                instrucoes:
                    'Molhar bem o pelo, aplicar o shampoo e aguardar 5 minutos de contato antes de enxaguar. Evitar contato com olhos.',
                color: AppColors.amber,
              ),
              const SizedBox(height: 18),
              // ── Recomendações ─────────────────────────────────────────────
              _SectionTitle(
                  icon: Icons.tips_and_updates_outlined,
                  label: 'Recomendações'),
              const SizedBox(height: 12),
              PvCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _RecoItem(
                      icon: Icons.no_food_outlined,
                      text:
                          'Evitar alimentos ultra-processados e com corantes artificiais durante o tratamento.',
                    ),
                    SizedBox(height: 12),
                    _RecoItem(
                      icon: Icons.shower_outlined,
                      text:
                          'Banhos excessivos ressecam a pele — limitar a 2 banhos por semana com o shampoo prescrito.',
                    ),
                    SizedBox(height: 12),
                    _RecoItem(
                      icon: Icons.grass_outlined,
                      text:
                          'Evitar passeios em gramados tratados com agrotóxicos ou areia de praia por 30 dias.',
                    ),
                    SizedBox(height: 12),
                    _RecoItem(
                      icon: Icons.monitor_weight_outlined,
                      text:
                          'Monitorar o peso semanalmente. O Apoquel pode aumentar o apetite em alguns animais.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // ── Próximas consultas ────────────────────────────────────────
              _SectionTitle(
                  icon: Icons.calendar_today_outlined,
                  label: 'Próximas consultas'),
              const SizedBox(height: 12),
              _ConsultaCard(
                tipo: 'Retorno dermatológico',
                data: '18/09/2025',
                hora: '14:00',
                vet: 'Dra. Helena Sá',
                local: 'Clínica VetCare Bom Retiro',
                nota: 'Avaliar resposta ao tratamento. Levar fotos do progresso da pele.',
              ),
              const SizedBox(height: 10),
              _ConsultaCard(
                tipo: 'Exame de sangue de controle',
                data: '02/10/2025',
                hora: '08:30',
                vet: 'Dr. Francisco',
                local: 'Laboratório PetLab',
                nota: 'Jejum de 8 horas. Hemograma completo + perfil bioquímico.',
              ),
              const SizedBox(height: 18),
              // ── Tratamentos ───────────────────────────────────────────────
              _SectionTitle(
                  icon: Icons.healing_outlined,
                  label: 'Tratamentos em andamento'),
              const SizedBox(height: 12),
              PvCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _TreatRow(
                      nome: 'Imunoterapia alérgica',
                      descricao: 'Série de injeções subcutâneas semanais para dessensibilização aos alérgenos identificados no painel alérgico.',
                      duracao: '6–12 meses',
                      variant: TagVariant.amber,
                    ),
                    const Divider(color: AppColors.line, height: 24),
                    _TreatRow(
                      nome: 'Dieta de eliminação',
                      descricao: 'Proteína hidrolisada por 8 semanas para identificar alergias alimentares como causa secundária.',
                      duracao: '8 semanas',
                      variant: TagVariant.soft,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // ── Procedimentos cirúrgicos ──────────────────────────────────
              _SectionTitle(
                  icon: Icons.medical_services_outlined,
                  label: 'Procedimentos cirúrgicos'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.chip,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.greenBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.check_circle_outline,
                          color: AppColors.green, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Nenhum procedimento cirúrgico indicado para este tratamento.',
                        style: AppTextStyles.sans(
                            size: 13.5,
                            weight: FontWeight.w600,
                            color: AppColors.muted),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // ── Assinatura ────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.line, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assinatura digital',
                        style: AppTextStyles.sans(
                            size: 12,
                            weight: FontWeight.w800,
                            color: AppColors.muted)),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.verified_user_outlined,
                          size: 16, color: AppColors.green),
                      const SizedBox(width: 6),
                      Text(
                        'Documento autenticado · Receituário nº 2025-08-4412',
                        style: AppTextStyles.sans(
                            size: 12,
                            weight: FontWeight.w700,
                            color: AppColors.muted),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Helper widgets ───────────────────────────────────────────────────────────

class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  const _HeaderBtn({required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.line, width: 1.5),
        ),
        child: Icon(icon, size: 18, color: AppColors.deep3),
      );
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.sans(
                  size: 10,
                  weight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.65))),
          const SizedBox(height: 2),
          Text(value,
              style: GoogleFonts.fraunces(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
        ],
      );
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.chip,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: AppColors.deep3),
          ),
          const SizedBox(width: 8),
          Flexible(child: Text(label, style: AppTextStyles.h3(size: 16))),
        ],
      );
}

class _MedCard extends StatefulWidget {
  final String nome;
  final String tipo;
  final String dosagem;
  final String frequencia;
  final String duracao;
  final String instrucoes;
  final Color color;

  const _MedCard({
    required this.nome,
    required this.tipo,
    required this.dosagem,
    required this.frequencia,
    required this.duracao,
    required this.instrucoes,
    required this.color,
  });

  @override
  State<_MedCard> createState() => _MedCardState();
}

class _MedCardState extends State<_MedCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.medication_outlined,
                    size: 22, color: widget.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.nome,
                        style: AppTextStyles.sans(
                            size: 14, weight: FontWeight.w800)),
                    Text(widget.tipo, style: AppTextStyles.meta(size: 12)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 22,
                    color: AppColors.faint),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _Pill(widget.dosagem, Icons.scale_outlined),
              _Pill(widget.frequencia, Icons.repeat_outlined),
              _Pill(widget.duracao, Icons.timer_outlined),
            ],
          ),
          if (_expanded) ...[
            const SizedBox(height: 12),
            const Divider(color: AppColors.line, height: 1),
            const SizedBox(height: 12),
            Text('Instruções de uso',
                style: AppTextStyles.sans(
                    size: 12, weight: FontWeight.w800, color: AppColors.muted)),
            const SizedBox(height: 6),
            Text(widget.instrucoes,
                style: AppTextStyles.sans(size: 13.5, weight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Pill(this.label, this.icon);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
        decoration: BoxDecoration(
            color: AppColors.chip, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: AppColors.muted),
            const SizedBox(width: 4),
            Text(label,
                style: AppTextStyles.sans(
                    size: 11.5, weight: FontWeight.w700, color: AppColors.ink)),
          ],
        ),
      );
}

class _RecoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _RecoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: AppColors.chip,
                borderRadius: BorderRadius.circular(9)),
            child: Icon(icon, size: 16, color: AppColors.deep3),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(text,
                  style:
                      AppTextStyles.sans(size: 13.5, weight: FontWeight.w600)),
            ),
          ),
        ],
      );
}

class _ConsultaCard extends StatelessWidget {
  final String tipo;
  final String data;
  final String hora;
  final String vet;
  final String local;
  final String nota;

  const _ConsultaCard({
    required this.tipo,
    required this.data,
    required this.hora,
    required this.vet,
    required this.local,
    required this.nota,
  });

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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.deep,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      data.split('/')[0],
                      style: GoogleFonts.fraunces(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    Text(
                      _monthAbbr(data.split('/')[1]),
                      style: AppTextStyles.sans(
                          size: 10,
                          weight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tipo,
                        style: AppTextStyles.sans(
                            size: 14, weight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Icon(Icons.access_time,
                          size: 13, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text(hora, style: AppTextStyles.meta(size: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.person_outline,
                          size: 13, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(vet,
                              style: AppTextStyles.meta(size: 12),
                              overflow: TextOverflow.ellipsis)),
                    ]),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Icon(Icons.place_outlined,
                          size: 13, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(local,
                              style: AppTextStyles.meta(size: 12),
                              overflow: TextOverflow.ellipsis)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          if (nota.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.chip,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      size: 14, color: AppColors.deep3),
                  const SizedBox(width: 6),
                  Expanded(
                      child: Text(nota,
                          style: AppTextStyles.sans(
                              size: 12,
                              weight: FontWeight.w600,
                              color: AppColors.ink))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _monthAbbr(String m) {
    const months = {
      '01': 'JAN', '02': 'FEV', '03': 'MAR', '04': 'ABR',
      '05': 'MAI', '06': 'JUN', '07': 'JUL', '08': 'AGO',
      '09': 'SET', '10': 'OUT', '11': 'NOV', '12': 'DEZ',
    };
    return months[m] ?? m;
  }
}

class _TreatRow extends StatelessWidget {
  final String nome;
  final String descricao;
  final String duracao;
  final TagVariant variant;

  const _TreatRow({
    required this.nome,
    required this.descricao,
    required this.duracao,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(nome,
                      style: AppTextStyles.sans(
                          size: 14, weight: FontWeight.w800))),
              PvTag(label: duracao, variant: variant),
            ],
          ),
          const SizedBox(height: 6),
          Text(descricao,
              style: AppTextStyles.sans(
                  size: 13, weight: FontWeight.w600, color: AppColors.muted)),
        ],
      );
}
