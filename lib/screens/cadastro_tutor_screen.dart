import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';

class CadastroTutorScreen extends StatefulWidget {
  const CadastroTutorScreen({super.key});

  @override
  State<CadastroTutorScreen> createState() => _CadastroTutorScreenState();
}

class _CadastroTutorScreenState extends State<CadastroTutorScreen> {
  bool _obscure = true;
  bool _terms = false;

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
              const PvPushHeader(title: 'Criar conta de Tutor'),
              Text(
                'Preencha seus dados para começar a usar o PetVax.',
                style: AppTextStyles.meta(),
              ),
              const SizedBox(height: 26),
              // ── Dados pessoais ───────────────────────────────────────────
              _Section('Dados pessoais'),
              const SizedBox(height: 12),
              _Field(
                label: 'Nome completo',
                hint: 'João da Silva',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _Field(
                      label: 'CPF',
                      hint: '000.000.000-00',
                      icon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Field(
                      label: 'Telefone',
                      hint: '(11) 99999-9999',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Field(
                label: 'E-mail',
                hint: 'seu@email.com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 22),
              // ── Endereço ─────────────────────────────────────────────────
              _Section('Endereço'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _Field(
                      label: 'CEP',
                      hint: '00000-000',
                      icon: Icons.location_on_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Field(
                      label: 'UF',
                      hint: 'SP',
                      icon: Icons.map_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Field(
                label: 'Cidade',
                hint: 'São Paulo',
                icon: Icons.location_city_outlined,
              ),
              const SizedBox(height: 22),
              // ── Segurança ─────────────────────────────────────────────────
              _Section('Segurança'),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Senha',
                    style: AppTextStyles.sans(
                        size: 13,
                        weight: FontWeight.w800,
                        color: AppColors.ink),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: AppColors.line, width: 1.5),
                    ),
                    child: TextField(
                      obscureText: _obscure,
                      style: AppTextStyles.sans(size: 15),
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: AppTextStyles.sans(
                            size: 15, color: AppColors.faint),
                        prefixIcon: const Icon(Icons.lock_outline,
                            size: 20, color: AppColors.muted),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              setState(() => _obscure = !_obscure),
                          child: Icon(
                            _obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.muted,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Mín. 8 caracteres, uma letra maiúscula e um número.',
                style: AppTextStyles.meta(size: 12),
              ),
              const SizedBox(height: 24),
              // ── Termos ────────────────────────────────────────────────────
              GestureDetector(
                onTap: () => setState(() => _terms = !_terms),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _terms ? AppColors.deep : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color:
                              _terms ? AppColors.deep : AppColors.line,
                          width: 1.5,
                        ),
                      ),
                      child: _terms
                          ? const Icon(Icons.check,
                              size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.sans(
                              size: 13, color: AppColors.ink),
                          children: [
                            const TextSpan(text: 'Li e aceito os '),
                            TextSpan(
                              text: 'Termos de Uso',
                              style: AppTextStyles.sans(
                                size: 13,
                                weight: FontWeight.w800,
                                color: AppColors.deep,
                              ),
                            ),
                            const TextSpan(text: ' e a '),
                            TextSpan(
                              text: 'Política de Privacidade',
                              style: AppTextStyles.sans(
                                size: 13,
                                weight: FontWeight.w800,
                                color: AppColors.deep,
                              ),
                            ),
                            const TextSpan(text: ' do PetVax.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _terms
                      ? () =>
                          Navigator.pushReplacementNamed(context, '/home')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deep,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.line,
                    disabledForegroundColor: AppColors.muted,
                    textStyle: AppTextStyles.sans(
                      size: 16,
                      weight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Criar conta'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Já tem conta? ', style: AppTextStyles.meta()),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Entrar',
                      style: AppTextStyles.sans(
                        size: 14,
                        weight: FontWeight.w800,
                        color: AppColors.deep,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  const _Section(this.label);

  @override
  Widget build(BuildContext context) =>
      Text(label, style: AppTextStyles.eyebrow());
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.sans(
                size: 13,
                weight: FontWeight.w800,
                color: AppColors.ink),
          ),
          const SizedBox(height: 7),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.line, width: 1.5),
            ),
            child: TextField(
              keyboardType: keyboardType,
              style: AppTextStyles.sans(size: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    AppTextStyles.sans(size: 15, color: AppColors.faint),
                prefixIcon:
                    Icon(icon, size: 20, color: AppColors.muted),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      );
}
