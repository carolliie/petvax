import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_tag.dart';
import '../widgets/pet_icon.dart';
import '../widgets/syringe_icon.dart';

class _VaxEntry {
  final String nome;
  final String data;
  final String prox;
  final TagVariant status;
  final String statusLabel;
  const _VaxEntry({
    required this.nome,
    required this.data,
    required this.prox,
    required this.status,
    required this.statusLabel,
  });
}

const _mingauVacinas = [
  _VaxEntry(nome: 'V4 (Quádrupla felina)',   data: '10/03/25', prox: '10/03/26', status: TagVariant.green, statusLabel: 'Em dia'),
  _VaxEntry(nome: 'Antirrábica',              data: '22/12/24', prox: '22/12/25', status: TagVariant.amber, statusLabel: 'Vence em breve'),
  _VaxEntry(nome: 'Leucemia felina (FeLV)',   data: '15/01/25', prox: '15/01/26', status: TagVariant.green, statusLabel: 'Em dia'),
  _VaxEntry(nome: 'Giárdia',                  data: '03/08/24', prox: '03/08/25', status: TagVariant.red,   statusLabel: 'Atrasada'),
];

class CarteirinhaScreen extends StatefulWidget {
  const CarteirinhaScreen({super.key});
  @override
  State<CarteirinhaScreen> createState() => _CarteirinhaScreenState();
}

class _CarteirinhaScreenState extends State<CarteirinhaScreen> {
  String _pet = 'Mingau';

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
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ─────────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(child: Text('Carteirinha', style: AppTextStyles.h1(size: 26))),
                        _IconBtn(icon: Icons.download_outlined, onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Pet selector — círculos simples ─────────────────────
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _PetBubble(
                            name: 'Mingau',
                            kind: PetKind.cat,
                            selected: _pet == 'Mingau',
                            onTap: () => setState(() => _pet = 'Mingau'),
                          ),
                          const SizedBox(width: 12),
                          _PetBubble(
                            name: 'Theo',
                            kind: PetKind.dog,
                            selected: _pet == 'Theo',
                            onTap: () => setState(() => _pet = 'Theo'),
                          ),
                          const SizedBox(width: 12),
                          _PetBubble(name: '+', kind: PetKind.generic, selected: false,
                              onTap: () => Navigator.pushNamed(context, '/cadastro-pet')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ── CTA análise prévia ──────────────────────────────────
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/enviar-carteirinha'),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                        decoration: BoxDecoration(
                          color: AppColors.chip,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.deep3.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.deep3.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Icon(Icons.document_scanner_outlined,
                                  size: 20, color: AppColors.deep3),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Análise prévia para veterinário',
                                      style: AppTextStyles.sans(
                                          size: 13.5, weight: FontWeight.w800)),
                                  Text('Envie fotos ou PDF para revisão',
                                      style: AppTextStyles.meta(size: 12)),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                size: 18, color: AppColors.faint),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Carteirinha ─────────────────────────────────────────
                    _Booklet(pet: _pet, vacinas: _mingauVacinas),
                    const SizedBox(height: 18),

                    // ── Ações ───────────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_outlined, size: 16),
                            label: const Text('Exportar PDF'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.deep3,
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: AppColors.line, width: 1.5),
                              textStyle: AppTextStyles.sans(size: 13, weight: FontWeight.w800),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/agendar-vacina'),
                            icon: const Icon(Icons.add_circle_outline, size: 16),
                            label: const Text('Agendar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.deep,
                              backgroundColor: AppColors.chip,
                              side: BorderSide.none,
                              textStyle: AppTextStyles.sans(size: 13, weight: FontWeight.w800),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
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

// ─── Pet bubble simples ───────────────────────────────────────────────────────

class _PetBubble extends StatelessWidget {
  final String name;
  final PetKind kind;
  final bool selected;
  final VoidCallback onTap;
  const _PetBubble({required this.name, required this.kind, required this.selected, required this.onTap});

  bool get _isPlus => name == '+';

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: selected ? AppColors.deep.withValues(alpha: 0.12) : AppColors.soft2,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.deep : AppColors.line,
                  width: selected ? 2 : 1.5,
                ),
              ),
              child: Center(
                child: _isPlus
                    ? const Icon(Icons.add, size: 20, color: AppColors.deep3)
                    : PetIcon(
                        size: 26,
                        color: selected ? AppColors.deep : AppColors.deep3,
                        kind: kind,
                      ),
              ),
            ),
            if (!_isPlus) ...[
              const SizedBox(height: 4),
              Text(name,
                  style: AppTextStyles.sans(
                      size: 11,
                      weight: FontWeight.w700,
                      color: selected ? AppColors.deep : AppColors.muted)),
            ],
          ],
        ),
      );
}

// ─── Booklet ──────────────────────────────────────────────────────────────────

class _Booklet extends StatelessWidget {
  final String pet;
  final List<_VaxEntry> vacinas;
  const _Booklet({required this.pet, required this.vacinas});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Column(
        children: [
          // Header suave
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            color: AppColors.deep3,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: PetIcon(
                      size: 26,
                      color: Colors.white,
                      kind: pet == 'Mingau' ? PetKind.cat : PetKind.dog,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pet,
                          style: GoogleFonts.fraunces(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      Text(
                        pet == 'Mingau' ? 'Gato · SRD · Fêmea · 3 anos' : 'Labrador · Macho · 5 anos',
                        style: AppTextStyles.sans(
                            size: 12,
                            color: Colors.white.withValues(alpha: 0.80)),
                      ),
                    ],
                  ),
                ),
                Text('Nº 0421',
                    style: AppTextStyles.sans(
                        size: 10,
                        weight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.65))),
              ],
            ),
          ),
          // Lista de vacinas
          Container(
            color: Colors.white,
            child: Column(
              children: [
                for (int i = 0; i < vacinas.length; i++)
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/vacina-detalhe'),
                    child: _VaxRow(entry: vacinas[i], isLast: i == vacinas.length - 1),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Linha de vacina simplificada ─────────────────────────────────────────────

class _VaxRow extends StatelessWidget {
  final _VaxEntry entry;
  final bool isLast;
  const _VaxRow({required this.entry, this.isLast = false});

  Color get _accent => switch (entry.status) {
        TagVariant.green => AppColors.green,
        TagVariant.amber => AppColors.amber,
        TagVariant.red   => AppColors.red,
        TagVariant.soft  => AppColors.deep3,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: _accent, width: 3),
          bottom: isLast ? BorderSide.none : const BorderSide(color: AppColors.line),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: SyringeIcon(size: 18, color: _accent)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.nome,
                    style: AppTextStyles.sans(size: 13.5, weight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('Aplicada ${entry.data} · Próxima ${entry.prox}',
                    style: AppTextStyles.meta(size: 11.5)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PvTag(label: entry.statusLabel, variant: entry.status),
        ],
      ),
    );
  }
}

// ─── Botão de ícone ───────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.line, width: 1.5),
          ),
          child: Icon(icon, size: 19, color: AppColors.deep3),
        ),
      );
}
