// lib/src/rendering/renderers/primitives/flag_renderer.dart

import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../theme/music_score_theme.dart';
import '../../smufl_positioning_engine.dart';
import '../base_glyph_renderer.dart';

/// Renderizador especializado APENAS para bandeirolas (flags) de notas.
///
/// Responsabilidade única: desenhar bandeirolas usando
/// âncoras SMuFL para posicionamento preciso.
class FlagRenderer extends BaseGlyphRenderer {
  final MusicScoreTheme theme;
  final SMuFLPositioningEngine positioningEngine;

  // ========== AJUSTES PARA BANDEIROLA PARA CIMA (stemUp = true) ==========
  /// Ajuste visual empírico em X para bandeirola PARA CIMA
  /// Valor proporcional ao staffSpace (em unidades de space)
  static const double flagUpXOffsetSpaces = 0.07; // ~0.7px para staffSpace = 10px

  /// Ajuste visual empírico em Y para bandeirola PARA CIMA
  /// Valor proporcional ao staffSpace (em unidades de space)
  static const double flagUpYOffsetSpaces = 0.0; // sem ajuste vertical

  // ========== AJUSTES PARA BANDEIROLA PARA BAIXO (stemUp = false) ==========
  /// Ajuste visual empírico em X para bandeirola PARA BAIXO
  /// Valor proporcional ao staffSpace (em unidades de space)
  static const double flagDownXOffsetSpaces = 0.07; // ~0.7px para staffSpace = 10px

  /// Ajuste visual empírico em Y para bandeirola PARA BAIXO
  /// Valor proporcional ao staffSpace (em unidades de space)
  static const double flagDownYOffsetSpaces = 0.05; // ~0.5px para staffSpace = 10px

  FlagRenderer({
    required super.metadata,
    required this.theme,
    required super.coordinates,
    required super.glyphSize,
    required this.positioningEngine,
  });

  /// Renderiza bandeirola de uma nota.
  ///
  /// [canvas] - Canvas onde desenhar
  /// [stemEnd] - Posição do final da haste
  /// [duration] - Duração da nota
  /// [stemUp] - Se a haste vai para cima
  void render(
    Canvas canvas,
    Offset stemEnd,
    DurationType duration,
    bool stemUp,
  ) {
    final flagGlyph = _getFlagGlyph(duration, stemUp);
    if (flagGlyph == null) return;

    // Obter âncora da bandeirola
    final flagAnchor = positioningEngine.getFlagAnchor(flagGlyph);

    // Converter âncora de spaces para pixels
    // CORREÇÃO CRÍTICA: SMuFL usa Y+ para cima, Flutter usa Y+ para baixo
    final flagAnchorPixels = Offset(
      flagAnchor.dx * coordinates.staffSpace,
      -flagAnchor.dy * coordinates.staffSpace, // INVERTER Y!
    );

    // Calcular posição da bandeirola com ajustes visuais (diferentes para cima/baixo)
    // Agora proporcionais ao staffSpace para escalar corretamente
    final xOffset = (stemUp ? flagUpXOffsetSpaces : flagDownXOffsetSpaces) * coordinates.staffSpace;
    final yOffset = (stemUp ? flagUpYOffsetSpaces : flagDownYOffsetSpaces) * coordinates.staffSpace;

    final flagX = stemEnd.dx - flagAnchorPixels.dx - xOffset;
    final flagY = stemEnd.dy - flagAnchorPixels.dy - yOffset;

    // Desenhar bandeirola
    drawGlyphWithBBox(
      canvas,
      glyphName: flagGlyph,
      position: Offset(flagX, flagY),
      color: theme.stemColor,
      options: const GlyphDrawOptions(), // Sem centralização
    );
  }

  /// Retorna o glifo SMuFL correto para a bandeirola.
  String? _getFlagGlyph(DurationType duration, bool stemUp) {
    return switch (duration) {
      DurationType.eighth => stemUp ? 'flag8thUp' : 'flag8thDown',
      DurationType.sixteenth => stemUp ? 'flag16thUp' : 'flag16thDown',
      DurationType.thirtySecond => stemUp ? 'flag32ndUp' : 'flag32ndDown',
      DurationType.sixtyFourth => stemUp ? 'flag64thUp' : 'flag64thDown',
      _ => null,
    };
  }
}
