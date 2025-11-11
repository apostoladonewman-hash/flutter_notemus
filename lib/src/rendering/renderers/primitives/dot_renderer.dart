// lib/src/rendering/renderers/primitives/dot_renderer.dart

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../theme/music_score_theme.dart';
import '../base_glyph_renderer.dart';

/// Renderizador especializado APENAS para pontos de aumento.
///
/// Responsabilidade única: desenhar pontos de aumento seguindo
/// a especificação SMuFL.
///
/// Regras SMuFL:
/// - Notas em LINHAS (staffPosition PAR): ponto na mesma linha
/// - Notas em ESPAÇOS (staffPosition ÍMPAR): ponto no espaço acima
class DotRenderer extends BaseGlyphRenderer {
  final MusicScoreTheme theme;

  /// Compensação para baseline correction do TextPainter (em staff spaces)
  ///
  /// O TextPainter aplica uma correção de baseline de -2.5 SS às noteheads.
  /// Estes valores compensam essa correção para posicionar os pontos corretamente.
  /// Baseado em: README.md seção "Technical Notes: Flutter TextPainter & SMuFL"
  static const double BASELINE_CORRECTION_COMPENSATION_ABOVE = -2.5;
  static const double BASELINE_CORRECTION_COMPENSATION_BELOW = 2.5;
  static const double BASELINE_CORRECTION_COMPENSATION_SPACE = 2.0;

  /// Distância horizontal do ponto em relação ao centro da nota (em SS)
  /// Behind Bars (p.14): "aproximadamente 1 staff space da nota"
  /// Cálculo: metade da largura da nota (~0.59 SS) + clearance (~0.4 SS) + margem
  static const double DOT_HORIZONTAL_OFFSET = 1.3;

  /// Espaçamento entre múltiplos pontos (em SS)
  /// Behind Bars (p.14): "0.5 staff spaces entre pontos"
  static const double DOT_SPACING = 0.5;

  DotRenderer({
    required super.metadata,
    required this.theme,
    required super.coordinates,
    required super.glyphSize,
  });

  /// Renderiza pontos de aumento para uma nota.
  ///
  /// [canvas] - Canvas onde desenhar
  /// [note] - Nota com pontos de aumento
  /// [notePosition] - Posição da cabeça da nota (centro)
  /// [staffPosition] - Posição da nota na pauta (em meios de staff space)
  void render(
    Canvas canvas,
    Note note,
    Offset notePosition,
    int staffPosition,
  ) {
    if (note.duration.dots == 0) return;

    // CORREÇÃO SMuFL: Posicionamento horizontal conforme Behind Bars
    final dotStartX =
        notePosition.dx + (coordinates.staffSpace * DOT_HORIZONTAL_OFFSET);

    // CORREÇÃO CRÍTICA: Posição Y deve alinhar EXATAMENTE ao centro da cabeça
    final dotY = _calculateDotY(notePosition.dy, staffPosition);

    // Desenhar cada ponto (múltiplos pontos ficam horizontalmente espaçados)
    for (int i = 0; i < note.duration.dots; i++) {
      final dotX = dotStartX + (i * coordinates.staffSpace * DOT_SPACING);
      _drawDot(canvas, Offset(dotX, dotY));
    }
  }

  /// Calcula a posição Y do ponto seguindo especificação SMuFL.
  ///
  /// **REGRA FUNDAMENTAL:** Pontos SEMPRE nos espaços, NUNCA nas linhas!
  ///
  /// [noteY] - Posição Y REAL da nota (em pixels)
  /// [staffPosition] - Posição da nota no pentagrama
  double _calculateDotY(double noteY, int staffPosition) {
    // ESPECIFICAÇÃO SMuFL (Behind Bars, p.14):
    // - Notas em LINHAS (staffPosition PAR): ponto fica NO ESPAÇO adjacente
    // - Notas em ESPAÇOS (staffPosition ÍMPAR): ponto fica no mesmo espaço
    //
    // Valores compensam a baseline correction do TextPainter (-2.5 SS)

    if (staffPosition.isEven) {
      // Nota em LINHA: ponto vai para o ESPAÇO mais próximo do centro
      if (staffPosition > 0) {
        // Nota acima do centro → ponto vai para BAIXO
        return noteY +
            (coordinates.staffSpace * BASELINE_CORRECTION_COMPENSATION_ABOVE);
      } else {
        // Nota no centro ou abaixo → ponto vai para CIMA
        return noteY -
            (coordinates.staffSpace * BASELINE_CORRECTION_COMPENSATION_BELOW);
      }
    } else {
      // Nota em ESPAÇO: ponto fica no MESMO espaço
      return noteY -
          (coordinates.staffSpace * BASELINE_CORRECTION_COMPENSATION_SPACE);
    }
  }

  /// Desenha um único ponto de aumento.
  void _drawDot(Canvas canvas, Offset position) {
    drawGlyphWithBBox(
      canvas,
      glyphName: 'augmentationDot',
      position: position,
      color: theme.noteheadColor,
      options: const GlyphDrawOptions(
        centerHorizontally: true,
        centerVertically:
            true, // Centralizar verticalmente na posição calculada
        disableBaselineCorrection:
            true, // CRÍTICO: Não aplicar correção de baseline nos pontos!
        size: null,
        scale: 1.0, // Tamanho padrão SMuFL
        trackBounds: false, // Pontos não precisam de collision detection
      ),
    );
  }
}
