import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/cross_paw.dart';
import '../widgets/pet_duo.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lilac,
      body: SafeArea(
        child: Column(
          children: [
            const PvStatusBar(),
            Expanded(
              child: Stack(
                children: [
                  // Título
                  Padding(
                    padding: const EdgeInsets.fromLTRB(26, 10, 26, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Use a ', style: AppTextStyles.h1(size: 30)),
                            Text(
                              'PetVax',
                              style: GoogleFonts.fraunces(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: AppColors.deep,
                                letterSpacing: -0.36,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CrossPaw(size: 96),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                'para ter as vacinas de seu pet em mãos.',
                                style: AppTextStyles.h1(size: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Ilustração
                  Positioned(
                    bottom: 160,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: PetDuo(
                        width: 260,
                        stroke: Colors.white,
                        strokeWidth: 6,
                        bg: AppColors.lilac,
                      ),
                    ),
                  ),
                  // Botões de autenticação
                  Positioned(
                    left: 26,
                    right: 26,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deep,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                            textStyle: AppTextStyles.sans(
                                size: 16, weight: FontWeight.w800),
                          ),
                          child: const Text('Entrar'),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, '/cadastro-tutor'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.deep,
                            backgroundColor: Colors.white.withValues(alpha: 0.75),
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            textStyle: AppTextStyles.sans(
                                size: 16, weight: FontWeight.w800),
                          ),
                          child: const Text('Criar conta gratuita'),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, '/home'),
                            child: Text(
                              'Explorar sem conta',
                              style: AppTextStyles.sans(
                                  size: 13,
                                  weight: FontWeight.w700,
                                  color: AppColors.deep2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
