import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../widgets/pv_status_bar.dart';
import '../widgets/pv_bottom_nav.dart';
import '../widgets/pv_card.dart';
import '../widgets/pv_tag.dart';
import '../widgets/hatch_box.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});
  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  String _category = 'Todas';

  static const _categories = ['Todas', 'Vacinação', 'Saúde', 'Prevenção', 'Alertas'];

  static const _articles = [
    (
      category: 'Vacinação',
      title: 'Campanha de vacinação antirrábica gratuita em setembro',
      source: 'Secretaria de Saúde',
      time: 'há 2 dias',
      featured: true,
    ),
    (
      category: 'Alertas',
      title: 'Alerta: surto de cinomose registrado na Grande São Paulo',
      source: 'SESP-SP',
      time: 'há 3 dias',
      featured: false,
    ),
    (
      category: 'Saúde',
      title: 'Novo protocolo de vacinas para cães: o que mudou em 2025',
      source: 'Conselho Federal de MV',
      time: 'há 5 dias',
      featured: false,
    ),
    (
      category: 'Prevenção',
      title: 'Leishmaniose: como proteger seu pet nas estações quentes',
      source: 'VetNews',
      time: 'há 1 semana',
      featured: false,
    ),
    (
      category: 'Saúde',
      title: 'Os benefícios da castração: saúde, comportamento e bem-estar',
      source: 'PetSaúde',
      time: 'há 2 semanas',
      featured: false,
    ),
    (
      category: 'Vacinação',
      title: 'Entenda o calendário de vacinas para gatos adultos',
      source: 'Revista Pet',
      time: 'há 3 semanas',
      featured: false,
    ),
  ];

  List<({String category, String title, String source, String time, bool featured})> get _filtered =>
      _category == 'Todas' ? _articles : _articles.where((a) => a.category == _category).toList();

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
                      children: [
                        Expanded(child: Text('Notícias', style: AppTextStyles.h1(size: 27))),
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.tune_outlined, color: AppColors.deep, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Search
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.line, width: 1.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 18, color: AppColors.faint),
                          const SizedBox(width: 8),
                          Text('Buscar notícias…', style: AppTextStyles.sans(size: 14, color: AppColors.faint)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Category chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((c) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _category = c),
                            child: _CatChip(label: c, selected: _category == c),
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Featured article (first one)
                    if (_filtered.isNotEmpty && _filtered.first.featured) ...[
                      _FeaturedCard(article: _filtered.first),
                      const SizedBox(height: 14),
                      if (_filtered.length > 1) ..._filtered.skip(1).map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ArticleCard(article: a),
                      )),
                    ] else
                      ..._filtered.map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ArticleCard(article: a),
                      )),
                    if (_filtered.isEmpty)
                      _EmptyState(category: _category),
                  ],
                ),
              ),
            ),
            const PvBottomNav(active: 'home'),
          ],
        ),
      ),
    );
  }
}

class _CatChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _CatChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.deep : Colors.white,
        border: Border.all(color: selected ? AppColors.deep : AppColors.line, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: AppTextStyles.sans(size: 13, weight: FontWeight.w800, color: selected ? Colors.white : AppColors.muted)),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final ({String category, String title, String source, String time, bool featured}) article;
  const _FeaturedCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return PvCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HatchBox(
              width: double.infinity,
              height: 160,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12, left: 12,
                    child: PvTag(label: article.category, variant: TagVariant.soft),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title, style: AppTextStyles.sans(size: 15, weight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(article.source, style: AppTextStyles.meta(size: 12)),
                      const SizedBox(width: 6),
                      Text('·', style: AppTextStyles.meta(size: 12)),
                      const SizedBox(width: 6),
                      Text(article.time, style: AppTextStyles.meta(size: 12)),
                    ],
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

class _ArticleCard extends StatelessWidget {
  final ({String category, String title, String source, String time, bool featured}) article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final isAlert = article.category == 'Alertas';
    return PvCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HatchBox(
            width: 64,
            height: 64,
            borderRadius: BorderRadius.circular(14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PvTag(label: article.category, variant: isAlert ? TagVariant.red : TagVariant.soft),
                  ],
                ),
                const SizedBox(height: 5),
                Text(article.title, style: AppTextStyles.sans(size: 13.5, weight: FontWeight.w800), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('${article.source} · ${article.time}', style: AppTextStyles.meta(size: 11.5)),
              ],
            ),
          ),
          const Icon(Icons.bookmark_border_outlined, size: 18, color: AppColors.faint),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String category;
  const _EmptyState({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(color: AppColors.chip, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.newspaper_outlined, size: 36, color: AppColors.deep3),
            ),
            const SizedBox(height: 16),
            Text('Nenhuma notícia em "$category"', style: AppTextStyles.h3(size: 16)),
            const SizedBox(height: 8),
            Text('Tente outra categoria.', style: AppTextStyles.meta()),
          ],
        ),
      ),
    );
  }
}
