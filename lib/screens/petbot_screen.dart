import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/paw_icon.dart';

class PetBotScreen extends StatefulWidget {
  const PetBotScreen({super.key});

  @override
  State<PetBotScreen> createState() => _PetBotScreenState();
}

class _PetBotScreenState extends State<PetBotScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  final List<_Msg> _messages = [
    _Msg(
      text: 'Olá! Sou o PetBot, seu assistente veterinário virtual 🐾',
      isBot: true,
    ),
    _Msg(
      text: 'Posso ajudar com dúvidas sobre vacinas, sintomas, alimentação e muito mais. Como posso te ajudar hoje?',
      isBot: true,
    ),
  ];

  final List<String> _suggestions = [
    'Quando vacinar meu gato?',
    'Meu pet está com febre',
    'Alimentos proibidos para cães',
    'Ver calendário de vacinas',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text: trimmed, isBot: false));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _messages.add(_Msg(text: _reply(trimmed), isBot: true)));
      Future.delayed(const Duration(milliseconds: 80), _scrollToBottom);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  String _reply(String text) {
    final t = text.toLowerCase();
    if (t.contains('vacin')) {
      return 'Para gatos, as vacinas principais são V4 (Quádrupla felina), Antirrábica e FeLV. Para cães, V8/V10, Antirrábica e Giárdia. Verifique a carteirinha do Mingau pelo menu principal para ver o próximo agendamento!';
    }
    if (t.contains('febre') || t.contains('doent') || t.contains('mal')) {
      return 'Se o seu pet tem temperatura acima de 39,5°C, letargia ou recusa de comida por mais de 24h, recomendo consulta veterinária urgente. Posso ajudá-lo a agendar uma consulta pelo app!';
    }
    if (t.contains('aliment') || t.contains('comida') || t.contains('comer')) {
      return 'Alimentos proibidos para cães: uva, chocolate, cebola, alho, macadâmia, abacate e xilitol. Para gatos, acrescenta-se excesso de leite e atum em conserva. Sempre consulte um nutricionista veterinário para a dieta ideal!';
    }
    if (t.contains('calendário') || t.contains('calendario') || t.contains('agenda')) {
      return 'Você pode acessar o calendário completo de vacinas pelo menu Serviços na tela inicial. Lá você verá todas as vacinas agendadas e os alertas de vencimento do Mingau!';
    }
    return 'Entendi! Para uma resposta mais precisa, recomendo consultar um veterinário. Posso ajudar a agendar uma consulta pelo app ou esclarecer outras dúvidas gerais sobre saúde animal. 🐾';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const PvStatusBar(),
            _Header(),
            const Divider(color: AppColors.line, height: 1),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _Bubble(msg: _messages[i]),
              ),
            ),
            if (_messages.length <= 3) _Suggestions(items: _suggestions, onTap: _send),
            const SizedBox(height: 8),
            _InputBar(controller: _controller, onSend: _send),
          ],
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 4, 22, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.line, width: 1.5),
              ),
              child: const Icon(Icons.chevron_left, color: AppColors.deep, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(color: AppColors.deep, shape: BoxShape.circle),
            child: Center(child: PawIcon(size: 22, color: Colors.white)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PetBot', style: AppTextStyles.h3(size: 17)),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text('Online agora', style: AppTextStyles.meta(size: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert_outlined, color: AppColors.muted, size: 22),
        ],
      ),
    );
  }
}

// ─── Suggestions ─────────────────────────────────────────────────────────────

class _Suggestions extends StatelessWidget {
  final List<String> items;
  final void Function(String) onTap;
  const _Suggestions({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, i) => const SizedBox(width: 8),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => onTap(items[i]),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.chip,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.line),
            ),
            child: Text(
              items[i],
              style: AppTextStyles.sans(
                size: 13,
                weight: FontWeight.w700,
                color: AppColors.deep,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Input bar ───────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSend;
  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.fromLTRB(14, 6, 6, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.sans(size: 14),
              decoration: InputDecoration(
                hintText: 'Pergunte algo ao PetBot...',
                hintStyle: AppTextStyles.sans(size: 14, color: AppColors.faint),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onSubmitted: onSend,
            ),
          ),
          GestureDetector(
            onTap: () => onSend(controller.text),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: AppColors.deep,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Message bubble ───────────────────────────────────────────────────────────

class _Msg {
  final String text;
  final bool isBot;
  _Msg({required this.text, required this.isBot});
}

class _Bubble extends StatelessWidget {
  final _Msg msg;
  const _Bubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment:
            msg.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (msg.isBot) ...[
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.deep,
                shape: BoxShape.circle,
              ),
              child: Center(child: PawIcon(size: 15, color: Colors.white)),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
              decoration: BoxDecoration(
                color: msg.isBot ? Colors.white : AppColors.deep,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(msg.isBot ? 4 : 18),
                  bottomRight: Radius.circular(msg.isBot ? 18 : 4),
                ),
                boxShadow: msg.isBot
                    ? [
                        BoxShadow(
                          color: AppColors.deep.withValues(alpha: 0.10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.sans(
                  size: 14,
                  weight: FontWeight.w600,
                  color: msg.isBot ? AppColors.ink : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
