import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  bool _pushVacinas = true;
  bool _pushConsultas = true;
  bool _pushAlertas = false;
  bool _pushNoticias = false;
  bool _compartilharDados = true;

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
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PvPushHeader(title: 'Configurações'),

                    // ── Notificações ─────────────────────────────────────────
                    _Section('Notificações'),
                    _Toggle(
                      icon: Icons.vaccines_outlined,
                      label: 'Lembretes de vacina',
                      subtitle: 'Avise 30, 7 e 1 dia antes do vencimento',
                      value: _pushVacinas,
                      onChanged: (v) => setState(() => _pushVacinas = v),
                    ),
                    _Toggle(
                      icon: Icons.calendar_today_outlined,
                      label: 'Lembretes de consulta',
                      subtitle: 'Notificação 1 dia antes da consulta',
                      value: _pushConsultas,
                      onChanged: (v) => setState(() => _pushConsultas = v),
                    ),
                    _Toggle(
                      icon: Icons.notifications_outlined,
                      label: 'Alertas da PetVax',
                      subtitle: 'Campanhas e avisos de saúde pública',
                      value: _pushAlertas,
                      onChanged: (v) => setState(() => _pushAlertas = v),
                    ),
                    _Toggle(
                      icon: Icons.newspaper_outlined,
                      label: 'Notícias e artigos',
                      subtitle: 'Conteúdo de saúde animal em destaque',
                      value: _pushNoticias,
                      onChanged: (v) => setState(() => _pushNoticias = v),
                      last: true,
                    ),
                    const SizedBox(height: 20),

                    // ── Privacidade ───────────────────────────────────────────
                    _Section('Privacidade'),
                    _Toggle(
                      icon: Icons.share_outlined,
                      label: 'Compartilhar dados com veterinários',
                      subtitle: 'Permite acesso à carteirinha pelo vet autorizado',
                      value: _compartilharDados,
                      onChanged: (v) => setState(() => _compartilharDados = v),
                    ),
                    _SettingRow(
                      icon: Icons.history_outlined,
                      label: 'Gerenciar histórico',
                      onTap: () {},
                      last: true,
                    ),
                    const SizedBox(height: 20),

                    // ── Sobre o app ───────────────────────────────────────────
                    _Section('Sobre o aplicativo'),
                    _SettingRow(
                      icon: Icons.info_outline,
                      label: 'Versão',
                      value: '1.0.0',
                      onTap: null,
                    ),
                    _SettingRow(
                      icon: Icons.description_outlined,
                      label: 'Termos de uso',
                      onTap: () {},
                    ),
                    _SettingRow(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Política de privacidade',
                      onTap: () {},
                    ),
                    _SettingRow(
                      icon: Icons.star_outline,
                      label: 'Avaliar o PetVax',
                      onTap: () {},
                      last: true,
                    ),
                    const SizedBox(height: 20),

                    // ── Suporte ───────────────────────────────────────────────
                    _Section('Suporte'),
                    _SettingRow(
                      icon: Icons.help_outline,
                      label: 'Central de ajuda',
                      onTap: () {},
                    ),
                    _SettingRow(
                      icon: Icons.chat_bubble_outline,
                      label: 'Fale conosco',
                      onTap: () {},
                      last: true,
                    ),
                    const SizedBox(height: 20),

                    // ── Conta ─────────────────────────────────────────────────
                    _Section('Conta'),
                    _SettingRow(
                      icon: Icons.logout,
                      label: 'Sair da conta',
                      onTap: () => _confirmLogout(context),
                      danger: true,
                    ),
                    _SettingRow(
                      icon: Icons.delete_outline,
                      label: 'Excluir conta',
                      onTap: () => _confirmDelete(context),
                      danger: true,
                      last: true,
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

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Sair da conta?', style: AppTextStyles.h3()),
        content: Text(
          'Você precisará fazer login novamente para acessar seus dados.',
          style: AppTextStyles.sans(size: 14, weight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: AppTextStyles.sans(size: 14, color: AppColors.muted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Excluir conta?', style: AppTextStyles.h3()),
        content: Text(
          'Todos os dados dos seus pets, vacinas e consultas serão removidos permanentemente. Esta ação não pode ser desfeita.',
          style: AppTextStyles.sans(size: 14, weight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: AppTextStyles.sans(size: 14, color: AppColors.muted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

// ─── Section label ─────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String label;
  const _Section(this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label, style: AppTextStyles.eyebrow()),
      );
}

// ─── Toggle row ────────────────────────────────────────────────────────────────

class _Toggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool last;

  const _Toggle({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.chip,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: AppColors.deep),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyles.sans(
                        size: 14, weight: FontWeight.w800)),
                Text(subtitle, style: AppTextStyles.meta(size: 12)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.deep,
          ),
        ],
      ),
    );
  }
}

// ─── Setting row ───────────────────────────────────────────────────────────────

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool danger;
  final bool last;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.label,
    this.value,
    this.danger = false,
    this.last = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: danger ? AppColors.redBg : AppColors.chip,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, size: 18,
                  color: danger ? AppColors.red : AppColors.deep),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(label,
                  style: AppTextStyles.sans(
                      size: 14.5,
                      weight: FontWeight.w800,
                      color: danger ? AppColors.red : AppColors.ink)),
            ),
            if (value != null)
              Text(value!, style: AppTextStyles.meta(size: 13)),
            if (value == null && onTap != null && !danger)
              const Icon(Icons.chevron_right, size: 18, color: AppColors.faint),
          ],
        ),
      ),
    );
  }
}
