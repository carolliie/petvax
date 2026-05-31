import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';

class DadosPessoaisScreen extends StatefulWidget {
  const DadosPessoaisScreen({super.key});

  @override
  State<DadosPessoaisScreen> createState() => _DadosPessoaisScreenState();
}

class _DadosPessoaisScreenState extends State<DadosPessoaisScreen> {
  bool _editing = false;

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
                    PvPushHeader(
                      title: 'Dados pessoais',
                      right: GestureDetector(
                        onTap: () => setState(() => _editing = !_editing),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _editing ? AppColors.deep : AppColors.chip,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _editing ? 'Salvar' : 'Editar',
                            style: AppTextStyles.sans(
                              size: 13,
                              weight: FontWeight.w800,
                              color: _editing ? Colors.white : AppColors.deep,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ── Avatar ────────────────────────────────────────────────
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: AppColors.soft2,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.deep, width: 2.5),
                            ),
                            child: const Icon(Icons.person_outline,
                                size: 44, color: AppColors.deep3),
                          ),
                          if (_editing)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.deep,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt_outlined,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    // ── Dados pessoais ────────────────────────────────────────
                    _SectionLabel('Informações pessoais'),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'Nome completo',
                      value: 'Marina Costa',
                      icon: Icons.person_outline,
                      enabled: _editing,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _Field(
                            label: 'CPF',
                            value: '382.094.820-15',
                            icon: Icons.badge_outlined,
                            enabled: _editing,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: _Field(
                            label: 'Data nasc.',
                            value: '12/04/1990',
                            icon: Icons.cake_outlined,
                            enabled: _editing,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel('Contato'),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'E-mail',
                      value: 'marina.costa@email.com',
                      icon: Icons.mail_outline,
                      enabled: _editing,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'Telefone',
                      value: '(11) 98765-4321',
                      icon: Icons.phone_outlined,
                      enabled: _editing,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel('Endereço'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _Field(
                            label: 'CEP',
                            value: '01310-100',
                            icon: Icons.location_on_outlined,
                            enabled: _editing,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Field(
                            label: 'UF',
                            value: 'SP',
                            icon: Icons.map_outlined,
                            enabled: _editing,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'Cidade',
                      value: 'São Paulo',
                      icon: Icons.location_city_outlined,
                      enabled: _editing,
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'Rua / Bairro',
                      value: 'Av. Paulista, 1000 · Bela Vista',
                      icon: Icons.home_outlined,
                      enabled: _editing,
                    ),
                    if (_editing) ...[
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _editing = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deep,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                            textStyle: AppTextStyles.sans(
                                size: 15, weight: FontWeight.w800),
                          ),
                          child: const Text('Salvar alterações'),
                        ),
                      ),
                    ],
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTextStyles.eyebrow());
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool enabled;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.value,
    required this.icon,
    required this.enabled,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.sans(
                  size: 12, weight: FontWeight.w800, color: AppColors.muted)),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : AppColors.chip,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: enabled ? AppColors.deep : AppColors.line,
                width: enabled ? 1.8 : 1.5,
              ),
            ),
            child: TextField(
              enabled: enabled,
              keyboardType: keyboardType,
              controller: TextEditingController(text: value),
              style: AppTextStyles.sans(size: 14, weight: FontWeight.w700),
              decoration: InputDecoration(
                prefixIcon: Icon(icon,
                    size: 18,
                    color: enabled ? AppColors.deep3 : AppColors.faint),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 13),
                isDense: true,
              ),
            ),
          ),
        ],
      );
}
