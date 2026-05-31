import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/hatch_box.dart';

class NoticiaDetalheScreen extends StatelessWidget {
  const NoticiaDetalheScreen({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top actions bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 4, 22, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                    color: AppColors.line, width: 1.5),
                              ),
                              child: const Icon(Icons.chevron_left,
                                  color: AppColors.deep, size: 26),
                            ),
                          ),
                          const Spacer(),
                          _IconBtn(icon: Icons.bookmark_border_outlined),
                          const SizedBox(width: 8),
                          _IconBtn(icon: Icons.share_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Hero image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: HatchBox(
                          width: double.infinity,
                          height: 200,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 14,
                                left: 14,
                                child: const PvTag(
                                  label: 'Vacinação',
                                  variant: TagVariant.soft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Article content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Campanha de vacinação antirrábica gratuita em setembro',
                            style: AppTextStyles.h1(size: 26),
                          ),
                          const SizedBox(height: 12),
                          // Meta
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.chip,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.account_balance_outlined,
                                    size: 16, color: AppColors.deep3),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Secretaria de Saúde',
                                    style: AppTextStyles.sans(
                                        size: 13, weight: FontWeight.w800),
                                  ),
                                  Text(
                                    '29 mai. 2026 · 4 min de leitura',
                                    style: AppTextStyles.meta(size: 11.5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          const Divider(color: AppColors.line),
                          const SizedBox(height: 18),
                          // Highlight box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.chip,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.deep.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.campaign_outlined,
                                    color: AppColors.deep, size: 22),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'A campanha é gratuita, não exige agendamento e atende cães e gatos de qualquer porte. Procure a UBS mais próxima.',
                                    style: AppTextStyles.sans(
                                      size: 13,
                                      weight: FontWeight.w700,
                                      color: AppColors.deep,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          _Paragraph(
                            'A Secretaria Municipal de Saúde anunciou que a campanha de vacinação antirrábica gratuita para cães e gatos será realizada durante todo o mês de setembro, em todos os postos de saúde e parques da cidade.',
                          ),
                          const SizedBox(height: 14),
                          _SubTitle('Por que vacinar contra a raiva?'),
                          const SizedBox(height: 8),
                          _Paragraph(
                            'A raiva é uma doença viral fatal que pode ser transmitida aos seres humanos. A vacinação anual é a forma mais eficaz de proteger seu pet e toda a família. O vírus é transmitido pela saliva de animais infectados, geralmente através de mordidas.',
                          ),
                          const SizedBox(height: 14),
                          _Paragraph(
                            'Segundo dados da Secretaria, a cobertura vacinal precisa atingir no mínimo 80% dos animais da cidade para interromper a cadeia de transmissão. Em 2024, a campanha vacinou mais de 340 mil animais — o objetivo de 2025 é superar essa marca.',
                          ),
                          const SizedBox(height: 14),
                          _SubTitle('Locais e horários'),
                          const SizedBox(height: 8),
                          _Paragraph(
                            'A campanha ocorre de segunda a sexta-feira, das 8h às 16h, e aos sábados das 8h às 12h. Não é necessário agendamento. Basta levar o animal em uma caixa de transporte ou coleira e guia.',
                          ),
                          const SizedBox(height: 14),
                          _InfoTable(),
                          const SizedBox(height: 18),
                          _SubTitle('Quem pode ser vacinado?'),
                          const SizedBox(height: 8),
                          _Paragraph(
                            'Cães e gatos a partir de 3 meses de idade. Animais com estado de saúde comprometido, fêmeas prenhes ou em lactação devem ser avaliados pelo veterinário do posto antes da vacinação.',
                          ),
                          const SizedBox(height: 18),
                          // Tags
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              'Raiva',
                              'Vacinação gratuita',
                              'Setembro 2025',
                              'Saúde pública',
                            ]
                                .map((t) =>
                                    PvTag(label: t, variant: TagVariant.soft))
                                .toList(),
                          ),
                          const SizedBox(height: 24),
                          const Divider(color: AppColors.line),
                          const SizedBox(height: 18),
                          // Related
                          Text('Veja também',
                              style: AppTextStyles.sans(
                                  size: 13,
                                  weight: FontWeight.w800,
                                  color: AppColors.muted)),
                          const SizedBox(height: 12),
                          _RelatedCard(
                            category: 'Saúde',
                            title:
                                'Novo protocolo de vacinas para cães: o que mudou em 2025',
                            source: 'Conselho Federal de MV',
                          ),
                          const SizedBox(height: 10),
                          _RelatedCard(
                            category: 'Prevenção',
                            title:
                                'Leishmaniose: como proteger seu pet nas estações quentes',
                            source: 'VetNews',
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
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

class _IconBtn extends StatelessWidget {
  final IconData icon;
  const _IconBtn({required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColors.line, width: 1.5),
        ),
        child: Icon(icon, color: AppColors.deep3, size: 20),
      );
}

class _Paragraph extends StatelessWidget {
  final String text;
  const _Paragraph(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: AppTextStyles.sans(size: 14.5, weight: FontWeight.w500,
            color: const Color(0xFF4A3560)),
      );
}

class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.fraunces(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.deep,
        ),
      );
}

class _InfoTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const rows = [
      ('Parque Ibirapuera', 'Seg–Sex 8h–16h'),
      ('Parque Estadual', 'Seg–Sáb 8h–14h'),
      ('UBS Vila Mariana', 'Seg–Sex 8h–16h'),
      ('UBS Santo André', 'Seg–Sex 8h–17h'),
    ];
    return PvCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: rows.indexed.map(((int, (String, String)) e) {
          final (i, (local, horario)) = e;
          final isLast = i == rows.length - 1;
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: isLast
                ? null
                : const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColors.line))),
            child: Row(
              children: [
                const Icon(Icons.place_outlined,
                    size: 16, color: AppColors.deep3),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(local,
                      style: AppTextStyles.sans(
                          size: 13, weight: FontWeight.w700)),
                ),
                Text(horario, style: AppTextStyles.meta(size: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _RelatedCard extends StatelessWidget {
  final String category;
  final String title;
  final String source;
  const _RelatedCard(
      {required this.category, required this.title, required this.source});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: PvCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            HatchBox(
              width: 56,
              height: 56,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PvTag(label: category, variant: TagVariant.soft),
                  const SizedBox(height: 5),
                  Text(title,
                      style: AppTextStyles.sans(
                          size: 13, weight: FontWeight.w800),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(source, style: AppTextStyles.meta(size: 11.5)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 18, color: AppColors.faint),
          ],
        ),
      ),
    );
  }
}
