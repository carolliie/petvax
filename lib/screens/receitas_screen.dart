import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/paw_icon.dart';

class ReceitasScreen extends StatefulWidget {
  const ReceitasScreen({super.key});
  @override
  State<ReceitasScreen> createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  String _tab = 'Vigentes';

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
                    Text('Receitas médicas', style: AppTextStyles.h1(size: 27)),
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
                        Text('Buscar receita…', style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
                      ]),
                    ),
                    const SizedBox(height: 14),
                    // Tabs
                    Row(children: ['Vigentes', 'Vencidas'].map((t) => Padding(
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
                    )).toList()),
                    const SizedBox(height: 18),
                    if (_tab == 'Vigentes') ...[
                      _RecipeCard(
                        titulo: 'Tratamento dermatológico',
                        vet: 'Dra. Helena Sá', data: '18/08/25',
                        validade: '18/11/25', diasRestantes: 50,
                        pet: 'Mingau',
                        itens: const ['Apoquel 5,4mg', 'Ômega 3', 'Shampoo medic.'],
                        posologia: 'Apoquel: 1 comp. 2x ao dia. Ômega 3: 1 cáps. por dia.',
                      ),
                    ] else ...[
                      _RecipeCard(
                        titulo: 'Antiparasitário',
                        vet: 'Dr. Francisco', data: '02/06/25',
                        vencida: true, pet: 'Mingau',
                        itens: const ['Bravecto', 'Vermífugo'],
                        posologia: 'Bravecto: dose única. Vermífugo: 1 comp. por dia por 3 dias.',
                      ),
                      const SizedBox(height: 10),
                      _RecipeCard(
                        titulo: 'Pós-operatório',
                        vet: 'Dr. Francisco', data: '10/03/25',
                        vencida: true, pet: 'Mingau',
                        itens: const ['Meloxicam 0,5mg', 'Amoxicilina 50mg'],
                        posologia: 'Meloxicam: 1 comp. 1x ao dia. Amoxicilina: 1 comp. 2x ao dia por 7 dias.',
                      ),
                      const SizedBox(height: 10),
                      _RecipeCard(
                        titulo: 'Tratamento otite',
                        vet: 'Dra. Helena Sá', data: '01/04/25',
                        vencida: true, pet: 'Theo',
                        itens: const ['Otomax', 'Clorexidina'],
                        posologia: 'Otomax: 5 gotas 2x ao dia por 10 dias.',
                      ),
                    ],
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
}

class _RecipeCard extends StatefulWidget {
  final String titulo, vet, data, pet, posologia;
  final String? validade;
  final int? diasRestantes;
  final bool vencida;
  final List<String> itens;

  const _RecipeCard({
    required this.titulo, required this.vet, required this.data,
    required this.pet, required this.itens, required this.posologia,
    this.validade, this.diasRestantes, this.vencida = false,
  });

  @override
  State<_RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<_RecipeCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: widget.vencida ? AppColors.chip : AppColors.greenBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.medication_outlined, size: 22, color: widget.vencida ? AppColors.muted : AppColors.green),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.titulo, style: AppTextStyles.sans(size: 14.5, weight: FontWeight.w800)),
                Text('${widget.vet} · ${widget.data}', style: AppTextStyles.meta(size: 12)),
              ],
            )),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 22, color: AppColors.faint),
            ),
          ]),
          const SizedBox(height: 10),
          // Pet + tags
          Row(children: [
            Row(children: [
              PawIcon(size: 12, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(widget.pet, style: AppTextStyles.meta(size: 12)),
            ]),
            const SizedBox(width: 10),
            ...widget.itens.take(2).map((m) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: PvTag(label: m, variant: TagVariant.soft),
            )),
            if (widget.itens.length > 2)
              PvTag(label: '+${widget.itens.length - 2}', variant: TagVariant.soft),
          ]),
          const SizedBox(height: 8),
          // Validity
          Row(children: [
            Icon(Icons.access_time, size: 13, color: widget.vencida ? AppColors.red : AppColors.green),
            const SizedBox(width: 5),
            Text(
              widget.vencida
                  ? 'Validade expirada'
                  : 'Válida até ${widget.validade} · ${widget.diasRestantes} dias restantes',
              style: AppTextStyles.sans(size: 12, weight: FontWeight.w700, color: widget.vencida ? AppColors.red : AppColors.green),
            ),
          ]),
          // Expanded detail
          if (_expanded) ...[
            const SizedBox(height: 12),
            const Divider(color: AppColors.line, height: 1),
            const SizedBox(height: 12),
            Text('Posologia', style: AppTextStyles.label()),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(12)),
              child: Text(widget.posologia, style: AppTextStyles.sans(size: 13, color: AppColors.ink)),
            ),
            const SizedBox(height: 12),
            Text('Medicamentos', style: AppTextStyles.label()),
            const SizedBox(height: 6),
            Wrap(spacing: 6, runSpacing: 6,
              children: widget.itens.map((m) => PvTag(label: m, variant: TagVariant.soft)).toList(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/receita-detalhe'),
                icon: const Icon(Icons.open_in_new_outlined, size: 16),
                label: const Text('Ver receita completa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deep,
                  foregroundColor: Colors.white,
                  textStyle: AppTextStyles.sans(size: 13.5, weight: FontWeight.w800),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined, size: 16),
                label: const Text('Baixar PDF'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deep,
                  side: const BorderSide(color: AppColors.line),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              )),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, size: 16),
                label: const Text('Compartilhar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deep,
                  side: const BorderSide(color: AppColors.line),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              )),
            ]),
          ],
        ],
      ),
    );
  }
}
