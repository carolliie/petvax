import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_avatar.dart';
import '../widgets/paw_icon.dart';

class PerfilTutorScreen extends StatelessWidget {
  const PerfilTutorScreen({super.key});

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Perfil', style: AppTextStyles.h1(size: 27)),
                        const Icon(Icons.settings_outlined, size: 22, color: AppColors.deep),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        PvAvatar(
                          size: 66,
                          child: const Icon(Icons.person_outline, size: 32, color: AppColors.deep),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marina Costa', style: AppTextStyles.h3(size: 19)),
                            Text('marina.costa@email.com', style: AppTextStyles.meta()),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 13, color: AppColors.deep3),
                                const SizedBox(width: 5),
                                Text('São Paulo, SP', style: AppTextStyles.sans(size: 12, weight: FontWeight.w700, color: AppColors.muted)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Meus pets', style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _PetCard(name: 'Mingau', species: 'Gato')),
                        const SizedBox(width: 12),
                        Expanded(child: _PetCard(name: 'Theo', species: 'Cão')),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Conta', style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 2),
                    const _SettingRow(icon: Icons.person_outline, label: 'Dados pessoais'),
                    _SettingRow(icon: Icons.notifications_outlined, label: 'Notificações', value: 'Ativas'),
                    const _SettingRow(icon: Icons.description_outlined, label: 'Documentos e exames'),
                    const _SettingRow(icon: Icons.lock_outline, label: 'Privacidade'),
                    const _SettingRow(icon: Icons.logout, label: 'Sair', danger: true),
                  ],
                ),
              ),
            ),
            const PvBottomNav(active: 'me'),
          ],
        ),
      ),
    );
  }
}

class _PetCard extends StatelessWidget {
  final String name;
  final String species;

  const _PetCard({required this.name, required this.species});

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: const EdgeInsets.all(13),
      child: Row(
        children: [
          PvAvatar(size: 42, child: PawIcon(size: 20, color: AppColors.deep)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.sans(size: 14, weight: FontWeight.w800)),
              Text(species, style: AppTextStyles.meta(size: 11.5)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool danger;

  const _SettingRow({required this.icon, required this.label, this.value, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: danger ? AppColors.redBg : AppColors.chip,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: danger ? AppColors.red : AppColors.deep),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.sans(size: 14.5, weight: FontWeight.w800, color: danger ? AppColors.red : AppColors.ink),
            ),
          ),
          if (value != null) Text(value!, style: AppTextStyles.meta(size: 13)),
          if (!danger) const Icon(Icons.chevron_right, size: 18, color: AppColors.faint),
        ],
      ),
    );
  }
}
