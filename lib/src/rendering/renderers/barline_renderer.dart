// lib/src/rendering/renderers/barline_renderer.dart

import 'package:flutter/painting.dart';

import '../../../core/core.dart';
import '../../smufl/smufl_metadata_loader.dart';
import '../../theme/music_score_theme.dart';
import '../staff_coordinate_system.dart';
import 'glyph_renderer.dart'; // 🎵 Para renderizar glyphs SMuFL

/// ✨ USA GLYPHS SMuFL OFICIAIS DA FONTE BRAVURA!
/// Ajustes manuais disponíveis através de constantes abaixo
class BarlineRenderer {
  // 🎚️ CONSTANTES DE AJUSTE MANUAL
  // Ajuste o tamanho vertical das barlines (multiplicador de staff spaces)
  static const double barlineHeightMultiplier =
      4.10; // Padrão: 4 SS (linha 1 a 5)

  // Ajuste Y offset (em staff spaces) - positivo = para baixo, negativo = para cima
  // ⚠️ IMPORTANTE: -2.05 compensa a diferença entre baseline tipográfica e topo visual
  static const double barlineYOffset = -2.05;

  // Ajuste X offset (em staff spaces) - positivo = direita, negativo = esquerda
  static const double barlineXOffset = 0.0; // Padrão: sem offset

  // Offset X específico para barras de repetição (que são mais largas)
  static const double repeatBarlineXOffset = -1.0; // Ajustar para esquerda
  final StaffCoordinateSystem coordinates;
  final SmuflMetadata metadata;
  final MusicScoreTheme theme;
  final GlyphRenderer glyphRenderer;
  final double glyphSize;

  BarlineRenderer({
    required this.coordinates,
    required this.metadata,
    required this.theme,
    required this.glyphRenderer,
    required this.glyphSize,
  });

  /// 🎵 Renderiza barline usando glyph SMuFL da fonte Bravura
  /// Ajuste as constantes acima para calibrar o posicionamento
  void render(Canvas canvas, Barline barline, Offset position) {
    final glyphName = _getGlyphName(barline.type);

    // ✅ Baseline tipográfica na linha 1 + offset de ajuste
    final line1Y = coordinates.getStaffLineY(1);
    final offsetAmount = barlineYOffset * coordinates.staffSpace;
    final topY = line1Y + offsetAmount;

    // Usar offset X específico para barras de repetição
    final isRepeatBar =
        barline.type == BarlineType.repeatBackward ||
        barline.type == BarlineType.repeatForward ||
        barline.type == BarlineType.repeatBoth;
    final xOffset = isRepeatBar ? repeatBarlineXOffset : barlineXOffset;
    final x = position.dx + (xOffset * coordinates.staffSpace);

    // Altura ajustável
    final barlineHeight = coordinates.staffSpace * barlineHeightMultiplier;

    final renderPosition = Offset(x, topY);

    // Renderizar glyph SMuFL oficial da Bravura!
    glyphRenderer.drawGlyph(
      canvas,
      glyphName: glyphName,
      position: renderPosition,
      size: barlineHeight,
      color: theme.barlineColor,
      centerVertically: false,
    );
  }

  /// Mapeia BarlineType para o nome do glyph SMuFL
  String _getGlyphName(BarlineType type) {
    switch (type) {
      case BarlineType.single:
        return 'barlineSingle';
      case BarlineType.double:
        return 'barlineDouble';
      case BarlineType.final_:
        return 'barlineFinal';
      case BarlineType.repeatForward:
        return 'repeatLeft'; // :|| (pontos à esquerda)
      case BarlineType.repeatBackward:
        return 'repeatRight'; // ||: (pontos à direita)
      case BarlineType.repeatBoth:
        return 'repeatLeftRight'; // :||: (pontos em ambos os lados)
      case BarlineType.dashed:
        return 'barlineDashed';
      case BarlineType.heavy:
        return 'barlineHeavy';
      case BarlineType.tick:
        return 'barlineTick';
      case BarlineType.short_:
        return 'barlineShort';
      default:
        return 'barlineSingle';
    }
  }
}
