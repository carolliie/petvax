import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/paw_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 40, 26, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.deep,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(child: PawIcon(size: 30, color: Colors.white)),
              ),
              const SizedBox(height: 26),
              Text('Bem-vindo ao\nPetVax', style: AppTextStyles.h1(size: 34)),
              const SizedBox(height: 8),
              Text(
                'Faça login para cuidar do seu pet.',
                style: AppTextStyles.meta(),
              ),
              const SizedBox(height: 36),
              _Field(
                label: 'E-mail',
                hint: 'seu@email.com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              _Field(
                label: 'Senha',
                hint: '••••••••',
                icon: Icons.lock_outline,
                obscure: _obscure,
                suffix: GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Esqueci a senha',
                  style: AppTextStyles.sans(
                    size: 13,
                    weight: FontWeight.w800,
                    color: AppColors.deep3,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deep,
                    foregroundColor: Colors.white,
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
                  child: const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 18),
              Row(children: [
                const Expanded(child: Divider(color: AppColors.line)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text('ou', style: AppTextStyles.meta()),
                ),
                const Expanded(child: Divider(color: AppColors.line)),
              ]),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata_outlined, size: 26),
                  label: const Text('Entrar com Google'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.ink,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.line, width: 1.5),
                    textStyle: AppTextStyles.sans(
                      size: 15,
                      weight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem conta? ', style: AppTextStyles.meta()),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/cadastro-tutor'),
                    child: Text(
                      'Criar conta',
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

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _Field({
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.sans(
                size: 13, weight: FontWeight.w800, color: AppColors.ink),
          ),
          const SizedBox(height: 7),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.line, width: 1.5),
            ),
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboardType,
              style: AppTextStyles.sans(size: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.sans(size: 15, color: AppColors.faint),
                prefixIcon: Icon(icon, size: 20, color: AppColors.muted),
                suffixIcon: suffix,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      );
}
