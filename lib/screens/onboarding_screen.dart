import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
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
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: PetDuo(
                        width: 300,
                        stroke: Colors.white,
                        strokeWidth: 6,
                        bg: AppColors.lilac,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 26,
                    bottom: 22,
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.deep,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deep.withValues(alpha: 0.7),
                              blurRadius: 22,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 26),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const PvBottomNav(active: 'home'),
          ],
        ),
      ),
    );
  }
}
