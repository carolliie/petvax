import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PetKind { cat, dog, generic }

/// Ícone de animal. Usar [PetKind.cat] para gatos, [PetKind.dog] para cães,
/// [PetKind.generic] para patinha genérica (equivalente ao PawIcon anterior).
class PetIcon extends StatelessWidget {
  final double size;
  final Color color;
  final PetKind kind;

  const PetIcon({
    super.key,
    this.size = 24,
    required this.color,
    this.kind = PetKind.generic,
  });

  @override
  Widget build(BuildContext context) {
    final h = _hex(color);
    final svg = switch (kind) {
      PetKind.cat => _catSvg(h),
      PetKind.dog => _dogSvg(h),
      PetKind.generic => _pawSvg(h),
    };
    return SvgPicture.string(svg, width: size, height: size);
  }

  // ── Cat face ────────────────────────────────────────────────────────────────
  static String _catSvg(String h) =>
      '<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">'
      // orelhas pontudas
      '<polygon points="6,15 8.5,4 14.5,11" fill="$h"/>'
      '<polygon points="26,15 23.5,4 17.5,11" fill="$h"/>'
      // contorno interno das orelhas
      '<polygon points="8,13.5 9.5,6.5 13.5,11" fill="white" fill-opacity="0.35"/>'
      '<polygon points="24,13.5 22.5,6.5 18.5,11" fill="white" fill-opacity="0.35"/>'
      // cabeça
      '<circle cx="16" cy="18.5" r="9.5" fill="$h"/>'
      // olhos
      '<ellipse cx="12.5" cy="17.5" rx="2" ry="2.3" fill="white" fill-opacity="0.9"/>'
      '<ellipse cx="19.5" cy="17.5" rx="2" ry="2.3" fill="white" fill-opacity="0.9"/>'
      // pupilas (fendas de gato)
      '<ellipse cx="12.5" cy="17.8" rx="0.9" ry="1.7" fill="$h" fill-opacity="0.7"/>'
      '<ellipse cx="19.5" cy="17.8" rx="0.9" ry="1.7" fill="$h" fill-opacity="0.7"/>'
      // nariz pequeno (coração simplificado)
      '<ellipse cx="16" cy="21.2" rx="1.4" ry="0.9" fill="white" fill-opacity="0.7"/>'
      '</svg>';

  // ── Dog face ────────────────────────────────────────────────────────────────
  static String _dogSvg(String h) =>
      '<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">'
      // orelhas floppy
      '<ellipse cx="7.5" cy="18" rx="5.5" ry="7.5" fill="$h"/>'
      '<ellipse cx="24.5" cy="18" rx="5.5" ry="7.5" fill="$h"/>'
      // reflexo das orelhas
      '<ellipse cx="7.5" cy="18" rx="3.2" ry="5" fill="white" fill-opacity="0.2"/>'
      '<ellipse cx="24.5" cy="18" rx="3.2" ry="5" fill="white" fill-opacity="0.2"/>'
      // cabeça
      '<circle cx="16" cy="16" r="9.5" fill="$h"/>'
      // focinho
      '<ellipse cx="16" cy="21" rx="4.2" ry="2.8" fill="$h" fill-opacity="0.85"/>'
      // olhos
      '<circle cx="12" cy="14.5" r="2" fill="white" fill-opacity="0.9"/>'
      '<circle cx="20" cy="14.5" r="2" fill="white" fill-opacity="0.9"/>'
      // pupilas
      '<circle cx="12.2" cy="14.8" r="1.1" fill="$h" fill-opacity="0.7"/>'
      '<circle cx="20.2" cy="14.8" r="1.1" fill="$h" fill-opacity="0.7"/>'
      // nariz
      '<ellipse cx="16" cy="20.5" rx="2" ry="1.4" fill="white" fill-opacity="0.75"/>'
      '</svg>';

  // ── Generic paw (mantido para usos decorativos) ─────────────────────────────
  static String _pawSvg(String h) =>
      '<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">'
      '<ellipse cx="16" cy="21" rx="7.2" ry="6" fill="$h"/>'
      '<ellipse cx="7.5" cy="14.5" rx="3.1" ry="3.7" fill="$h"/>'
      '<ellipse cx="24.5" cy="14.5" rx="3.1" ry="3.7" fill="$h"/>'
      '<ellipse cx="12" cy="9" rx="2.7" ry="3.4" fill="$h"/>'
      '<ellipse cx="20" cy="9" rx="2.7" ry="3.4" fill="$h"/>'
      '</svg>';

  static String _hex(Color c) {
    final r = (c.r * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (c.g * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (c.b * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}
