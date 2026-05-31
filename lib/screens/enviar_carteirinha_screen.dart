import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_push_header.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/syringe_icon.dart';

enum _Step { upload, analyzing, aiDone, vetReview, vetDone }

class EnviarCarteirinhaScreen extends StatefulWidget {
  const EnviarCarteirinhaScreen({super.key});

  @override
  State<EnviarCarteirinhaScreen> createState() =>
      _EnviarCarteirinhaScreenState();
}

class _EnviarCarteirinhaScreenState extends State<EnviarCarteirinhaScreen> {
  _Step _step = _Step.upload;
  String _fileName = '';

  void _pickFile(bool isPdf) {
    setState(() {
      _fileName = isPdf ? 'carteirinha_mingau.pdf' : 'foto_carteirinha_01.jpg';
      _step = _Step.analyzing;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _step = _Step.aiDone);
    });
  }

  void _sendToVet() {
    setState(() => _step = _Step.vetReview);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _step = _Step.vetDone);
    });
  }

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
              const PvPushHeader(title: 'Analisar carteirinha'),
              _StepBar(step: _step),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                child: KeyedSubtree(
                  key: ValueKey(_step),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return switch (_step) {
      _Step.upload => _UploadSection(onPick: _pickFile),
      _Step.analyzing => const _AnalyzingSection(),
      _Step.aiDone => _AiResultSection(fileName: _fileName, onSendToVet: _sendToVet),
      _Step.vetReview => const _VetWaitingSection(),
      _Step.vetDone => _VetDoneSection(onAgendar: () => Navigator.pushNamed(context, '/agendar')),
    };
  }
}

// ─── Step bar ─────────────────────────────────────────────────────────────────

class _StepBar extends StatelessWidget {
  final _Step step;
  const _StepBar({required this.step});

  @override
  Widget build(BuildContext context) {
    final stepIndex = switch (step) {
      _Step.upload => 0,
      _Step.analyzing || _Step.aiDone => 1,
      _Step.vetReview || _Step.vetDone => 2,
    };
    const labels = ['Envio', 'Verificação', 'Veterinário'];

    return Row(
      children: List.generate(labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          final lineIndex = i ~/ 2;
          return Expanded(
            child: Container(
              height: 2,
              color: lineIndex < stepIndex ? AppColors.deep : AppColors.line,
            ),
          );
        }
        final si = i ~/ 2;
        final done = si < stepIndex;
        final active = si == stepIndex;
        return Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: done
                    ? AppColors.green
                    : active
                        ? AppColors.deep
                        : AppColors.line,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: done
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text(
                        '${si + 1}',
                        style: AppTextStyles.sans(
                          size: 13,
                          weight: FontWeight.w800,
                          color: active ? Colors.white : AppColors.muted,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              labels[si],
              style: AppTextStyles.sans(
                size: 11,
                weight: FontWeight.w700,
                color: active ? AppColors.deep : AppColors.muted,
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Upload section ───────────────────────────────────────────────────────────

class _UploadSection extends StatelessWidget {
  final void Function(bool isPdf) onPick;
  const _UploadSection({required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Envie a carteirinha', style: AppTextStyles.h2()),
        const SizedBox(height: 6),
        Text(
          'Verificamos automaticamente seus registros de vacinação e alertamos sobre pendências.',
          style: AppTextStyles.meta(),
        ),
        const SizedBox(height: 22),
        _PickCard(
          icon: Icons.photo_camera_outlined,
          iconBg: AppColors.chip,
          iconColor: AppColors.deep,
          title: 'Tirar foto ou galeria',
          subtitle: 'JPG, PNG · até 10 MB por imagem',
          onTap: () => onPick(false),
        ),
        const SizedBox(height: 12),
        _PickCard(
          icon: Icons.picture_as_pdf_outlined,
          iconBg: AppColors.redBg,
          iconColor: AppColors.red,
          title: 'Enviar PDF',
          subtitle: 'PDF · até 25 MB',
          onTap: () => onPick(true),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.chip,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock_outline, size: 18, color: AppColors.deep3),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Seus documentos são criptografados e acessados apenas pelo veterinário autorizado.',
                  style: AppTextStyles.meta(size: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PickCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _PickCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line, width: 1.5),
          ),
          child: Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 28, color: iconColor),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTextStyles.sans(
                  size: 15,
                  weight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 3),
              Text(subtitle, style: AppTextStyles.meta()),
            ],
          ),
        ),
      );
}

// ─── Analyzing section ────────────────────────────────────────────────────────

class _AnalyzingSection extends StatelessWidget {
  const _AnalyzingSection();

  @override
  Widget build(BuildContext context) => PvCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const CircularProgressIndicator(color: AppColors.deep),
            const SizedBox(height: 20),
            Text('Verificando documento...', style: AppTextStyles.h3()),
            const SizedBox(height: 8),
            Text(
              'Extraindo vacinas, datas e informações do documento. Aguarde um momento.',
              style: AppTextStyles.meta(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

// ─── AI result section ────────────────────────────────────────────────────────

class _AiResultSection extends StatelessWidget {
  final String fileName;
  final VoidCallback onSendToVet;
  const _AiResultSection({required this.fileName, required this.onSendToVet});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.greenBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.check_circle_outline,
                    color: AppColors.green, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text('Verificação concluída', style: AppTextStyles.h3())),
            ],
          ),
          const SizedBox(height: 4),
          Text(fileName, style: AppTextStyles.meta()),
          const SizedBox(height: 16),
          PvCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vacinas identificadas',
                  style: AppTextStyles.sans(
                    size: 12.5,
                    weight: FontWeight.w800,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 14),
                _AiVaxRow(
                  nome: 'V4 (Quádrupla felina)',
                  data: '10/03/2025',
                  variant: TagVariant.green,
                  label: 'Em dia',
                ),
                _AiVaxRow(
                  nome: 'Antirrábica',
                  data: '22/12/2024',
                  variant: TagVariant.amber,
                  label: 'Vence em breve',
                ),
                _AiVaxRow(
                  nome: 'Leucemia felina (FeLV)',
                  data: '15/01/2025',
                  variant: TagVariant.green,
                  label: 'Em dia',
                  last: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.amberBg,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: AppColors.amber.withValues(alpha: 0.35)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_outlined,
                    size: 20, color: AppColors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1 vacina com atenção',
                        style: AppTextStyles.sans(
                          size: 13,
                          weight: FontWeight.w800,
                          color: const Color(0xFF9C6A1C),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'A Antirrábica vence em 22/12/2025. Recomendamos revisão veterinária para confirmação.',
                        style: AppTextStyles.sans(size: 12, color: AppColors.amber),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onSendToVet,
              icon: const Icon(Icons.send_outlined, size: 18),
              label: const Text('Enviar ao veterinário para revisão'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deep,
                foregroundColor: Colors.white,
                textStyle: AppTextStyles.sans(
                  size: 15,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          ),
        ],
      );
}

class _AiVaxRow extends StatelessWidget {
  final String nome;
  final String data;
  final TagVariant variant;
  final String label;
  final bool last;
  const _AiVaxRow({
    required this.nome,
    required this.data,
    required this.variant,
    required this.label,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(
                  bottom: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: AppColors.chip,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: SyringeIcon(size: 18, color: AppColors.deep)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome,
                      style: AppTextStyles.sans(
                          size: 13.5, weight: FontWeight.w800)),
                  Text(data, style: AppTextStyles.meta(size: 12)),
                ],
              ),
            ),
            PvTag(label: label, variant: variant),
          ],
        ),
      );
}

// ─── Vet waiting section ──────────────────────────────────────────────────────

class _VetWaitingSection extends StatelessWidget {
  const _VetWaitingSection();

  @override
  Widget build(BuildContext context) => PvCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const CircularProgressIndicator(color: AppColors.deep3),
            const SizedBox(height: 20),
            Text(
              'Aguardando revisão veterinária',
              style: AppTextStyles.h3(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'O Dr. Francisco foi notificado e está revisando sua carteirinha. Você receberá um aviso quando a análise estiver pronta.',
              style: AppTextStyles.meta(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

// ─── Vet done section ─────────────────────────────────────────────────────────

class _VetDoneSection extends StatelessWidget {
  final VoidCallback onAgendar;
  const _VetDoneSection({required this.onAgendar});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PvCard(
            color: AppColors.greenBg,
            shadow: false,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.verified_outlined,
                    color: AppColors.green, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revisão concluída',
                        style: AppTextStyles.sans(
                          size: 15,
                          weight: FontWeight.w800,
                          color: const Color(0xFF2F7D5B),
                        ),
                      ),
                      Text(
                        'Dr. Francisco · há 2 min',
                        style: AppTextStyles.meta(size: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          PvCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parecer do veterinário',
                  style: AppTextStyles.sans(
                    size: 12.5,
                    weight: FontWeight.w800,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Carteirinha validada com sucesso. A vacina Antirrábica da Mingau está vencendo em dezembro — recomendo agendar o reforço com antecedência. As demais vacinas estão em dia. Parabéns pelo cuidado!',
                  style: AppTextStyles.sans(size: 14, weight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                const Divider(color: AppColors.line),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.chip,
                      child: const Icon(Icons.person_outline,
                          color: AppColors.deep3, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Francisco Alves',
                          style: AppTextStyles.sans(
                              size: 13, weight: FontWeight.w800),
                        ),
                        Text(
                          'CRMV 12.345 · Veterinário geral',
                          style: AppTextStyles.meta(size: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAgendar,
              icon: const Icon(Icons.calendar_month_outlined, size: 18),
              label: const Text('Agendar reforço da Antirrábica'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deep,
                foregroundColor: Colors.white,
                textStyle: AppTextStyles.sans(
                  size: 15,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          ),
        ],
      );
}
