import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pet_icon.dart';

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
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ─────────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Perfil', style: AppTextStyles.h1(size: 26)),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/configuracoes'),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.line, width: 1.5),
                            ),
                            child: const Icon(Icons.settings_outlined,
                                size: 19, color: AppColors.deep3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Perfil compacto ───────────────────────────────────
                    PvCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Avatar
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/dados-pessoais'),
                            child: Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.soft2,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.line, width: 1.5),
                                  ),
                                  child: const Icon(Icons.person_outline,
                                      size: 30, color: AppColors.deep3),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: AppColors.chip,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                    child: const Icon(Icons.edit_outlined,
                                        size: 10, color: AppColors.deep3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Marina Costa',
                                    style: AppTextStyles.sans(
                                        size: 16, weight: FontWeight.w800)),
                                const SizedBox(height: 2),
                                Text('marina.costa@email.com',
                                    style: AppTextStyles.meta(size: 12),
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 4),
                                Row(children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 12, color: AppColors.faint),
                                  const SizedBox(width: 3),
                                  Text('São Paulo, SP',
                                      style: AppTextStyles.sans(
                                          size: 11.5,
                                          weight: FontWeight.w600,
                                          color: AppColors.faint)),
                                ]),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/dados-pessoais'),
                            child: const Icon(Icons.chevron_right,
                                size: 18, color: AppColors.faint),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // ── Meus pets ─────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meus pets', style: AppTextStyles.eyebrow()),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/cadastro-pet'),
                          child: Text('+ Adicionar',
                              style: AppTextStyles.sans(
                                  size: 12,
                                  weight: FontWeight.w800,
                                  color: AppColors.deep3)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _PetCard(
                            name: 'Mingau',
                            species: 'Gato · 3 anos',
                            kind: PetKind.cat,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _PetCard(
                            name: 'Theo',
                            species: 'Labrador · 5 anos',
                            kind: PetKind.dog,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Menu ─────────────────────────────────────────────
                    Text('Conta', style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 4),
                    _MenuItem(icon: Icons.person_outline,          label: 'Dados pessoais',       onTap: () => Navigator.pushNamed(context, '/dados-pessoais')),
                    _MenuItem(icon: Icons.vaccines_outlined,        label: 'Carteirinha',           onTap: () => Navigator.pushNamed(context, '/carteirinha')),
                    _MenuItem(icon: Icons.calendar_today_outlined,  label: 'Consultas',             onTap: () => Navigator.pushNamed(context, '/consultas')),
                    _MenuItem(icon: Icons.description_outlined,     label: 'Documentos e receitas', onTap: () => Navigator.pushNamed(context, '/receitas')),
                    _MenuItem(icon: Icons.settings_outlined,        label: 'Configurações',         onTap: () => Navigator.pushNamed(context, '/configuracoes'), last: true),
                    const SizedBox(height: 20),

                    // ── Sair ──────────────────────────────────────────────
                    GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.redBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.red.withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout, size: 17,
                                color: AppColors.red),
                            const SizedBox(width: 7),
                            Text('Sair da conta',
                                style: AppTextStyles.sans(
                                    size: 14,
                                    weight: FontWeight.w800,
                                    color: AppColors.red)),
                          ],
                        ),
                      ),
                    ),
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

// ─── Pet card simples ─────────────────────────────────────────────────────────

class _PetCard extends StatelessWidget {
  final String name;
  final String species;
  final PetKind kind;
  const _PetCard({required this.name, required this.species, required this.kind});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/carteirinha'),
        child: PvCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.soft2,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: PetIcon(size: 24, color: AppColors.deep3, kind: kind)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: AppTextStyles.sans(
                            size: 13.5, weight: FontWeight.w800)),
                    Text(species,
                        style: AppTextStyles.meta(size: 11),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 15, color: AppColors.faint),
            ],
          ),
        ),
      );
}

// ─── Menu item ─────────────────────────────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool last;
  const _MenuItem({required this.icon, required this.label, required this.onTap, this.last = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: last
                ? null
                : const Border(bottom: BorderSide(color: AppColors.line)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.chip,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: AppColors.deep3),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(label,
                    style: AppTextStyles.sans(
                        size: 14, weight: FontWeight.w700)),
              ),
              const Icon(Icons.chevron_right, size: 17, color: AppColors.faint),
            ],
          ),
        ),
      );
}
