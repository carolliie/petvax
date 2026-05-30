import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_chip.dart';
import '../widgets/paw_icon.dart';
import '../widgets/hatch_box.dart';

class CadastroPetScreen extends StatelessWidget {
  const CadastroPetScreen({super.key});

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
                    const PvPushHeader(title: 'Cadastrar pet'),
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              HatchBox(
                                width: 96,
                                height: 96,
                                borderRadius: BorderRadius.circular(48),
                                child: Center(child: PawIcon(size: 40, color: AppColors.deep3)),
                              ),
                              Positioned(
                                right: -2,
                                bottom: -2,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: AppColors.deep,
                                    borderRadius: BorderRadius.circular(11),
                                    border: Border.all(color: AppColors.bg, width: 3),
                                  ),
                                  child: const Icon(Icons.camera_alt_outlined, size: 17, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Foto do pet', style: AppTextStyles.meta(size: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _Field(label: 'Nome', placeholder: 'Ex: Mingau'),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Espécie', style: AppTextStyles.label()),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            PvChip(label: 'Gato', selected: true, leading: PawIcon(size: 14, color: Colors.white)),
                            const SizedBox(width: 8),
                            const PvChip(label: 'Cão'),
                            const SizedBox(width: 8),
                            const PvChip(label: 'Outro'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _Field(label: 'Raça', placeholder: 'SRD')),
                        const SizedBox(width: 12),
                        Expanded(child: _DropField(label: 'Sexo', value: 'Fêmea')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _DropField(label: 'Nascimento', value: 'dd/mm/aaaa', icon: Icons.calendar_today_outlined)),
                        const SizedBox(width: 12),
                        Expanded(child: _Field(label: 'Peso', placeholder: 'kg')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _Field(
                      label: 'Microchip',
                      labelSuffix: ' (opcional)',
                      placeholder: 'Número de identificação',
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check, size: 19),
                        label: const Text('Salvar pet'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deep,
                          foregroundColor: Colors.white,
                          textStyle: AppTextStyles.sans(size: 15, weight: FontWeight.w800, color: Colors.white),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
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

class _Field extends StatelessWidget {
  final String label;
  final String? labelSuffix;
  final String placeholder;

  const _Field({required this.label, this.labelSuffix, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppTextStyles.label(),
            children: labelSuffix != null
                ? [TextSpan(text: labelSuffix, style: AppTextStyles.sans(size: 12.5, color: AppColors.faint))]
                : null,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.line, width: 1.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(placeholder, style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
        ),
      ],
    );
  }
}

class _DropField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DropField({required this.label, required this.value, this.icon = Icons.keyboard_arrow_down});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label()),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.line, width: 1.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
              Icon(icon, size: 16, color: AppColors.faint),
            ],
          ),
        ),
      ],
    );
  }
}
