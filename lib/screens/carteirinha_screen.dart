import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_tag.dart';
import '../widgets/pv_avatar.dart';
import '../widgets/paw_icon.dart';
import '../widgets/syringe_icon.dart';

class CarteirinhaScreen extends StatelessWidget {
  const CarteirinhaScreen({super.key});

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
                    Text('Carteirinha de vacinação', style: AppTextStyles.h1(size: 26)),
                    const SizedBox(height: 14),
                    // Pet selector
                    Row(
                      children: [
                        _PetAvatar(name: 'Mingau', selected: true),
                        const SizedBox(width: 10),
                        _PetAvatar(name: 'Theo', selected: false),
                        const SizedBox(width: 10),
                        _PetAvatar(name: '+', selected: false),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Booklet card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          Container(
                            color: AppColors.deep,
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                            child: Row(
                              children: [
                                PvAvatar(
                                  size: 44,
                                  background: Colors.white.withValues(alpha: 0.18),
                                  child: PawIcon(size: 22, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Mingau', style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                                      Text('Gato · SRD · Fêmea · 3 anos', style: AppTextStyles.sans(size: 12, color: Colors.white.withValues(alpha: 0.85))),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    PawIcon(size: 16, color: Colors.white.withValues(alpha: 0.55)),
                                    const SizedBox(height: 2),
                                    Text('Nº 0421-MG', style: AppTextStyles.sans(size: 10, color: Colors.white.withValues(alpha: 0.7), weight: FontWeight.w700)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                            child: Column(
                              children: [
                                _VaxRow(nome: 'V4 (Quádrupla felina)', data: '10/03/25', prox: '10/03/26', status: TagVariant.green, statusLabel: 'Em dia'),
                                _VaxRow(nome: 'Antirrábica', data: '22/12/24', prox: '22/12/25', status: TagVariant.amber, statusLabel: 'Vence em breve'),
                                _VaxRow(nome: 'Leucemia felina (FeLV)', data: '15/01/25', prox: '15/01/26', status: TagVariant.green, statusLabel: 'Em dia'),
                                _VaxRow(nome: 'Giárdia', data: '03/08/24', prox: '03/08/25', status: TagVariant.red, statusLabel: 'Atrasada', last: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Exportar carteirinha (PDF)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.deep,
                          backgroundColor: AppColors.chip,
                          side: BorderSide.none,
                          textStyle: AppTextStyles.sans(size: 15, weight: FontWeight.w800, color: AppColors.deep),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
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

class _PetAvatar extends StatelessWidget {
  final String name;
  final bool selected;

  const _PetAvatar({required this.name, required this.selected});

  @override
  Widget build(BuildContext context) {
    final isPlus = name == '+';
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: isPlus ? Colors.white : AppColors.soft2,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? AppColors.deep : AppColors.line,
              width: selected ? 2.5 : 2,
            ),
          ),
          child: Center(
            child: isPlus
                ? const Icon(Icons.add, size: 22, color: AppColors.deep3)
                : PawIcon(size: 24, color: AppColors.deep),
          ),
        ),
        const SizedBox(height: 5),
        if (!isPlus)
          Text(
            name,
            style: AppTextStyles.sans(size: 11.5, weight: FontWeight.w800, color: selected ? AppColors.deep : AppColors.muted),
          ),
      ],
    );
  }
}

class _VaxRow extends StatelessWidget {
  final String nome;
  final String data;
  final String prox;
  final TagVariant status;
  final String statusLabel;
  final bool last;

  const _VaxRow({
    required this.nome,
    required this.data,
    required this.prox,
    required this.status,
    required this.statusLabel,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last ? null : Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(12)),
            child: Center(child: SyringeIcon(size: 19, color: AppColors.deep)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
                Text('Aplicada $data · próxima $prox', style: AppTextStyles.meta(size: 11.5)),
              ],
            ),
          ),
          PvTag(label: statusLabel, variant: status),
        ],
      ),
    );
  }
}
