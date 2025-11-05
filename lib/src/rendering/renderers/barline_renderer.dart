// lib/src/rendering/renderers/barline_renderer.dart

import 'package:flutter/material.dart';

import '../../../core/core.dart'; // 🆕 Tipos do core
import '../../layout/collision_detector.dart'; // CORREÇÃO: Import collision detector
import '../../smufl/smufl_metadata_loader.dart';
import '../../theme/music_score_theme.dart';
import '../staff_coordinate_system.dart';

class BarlineRenderer {
  final StaffCoordinateSystem coordinates;
  final SmuflMetadata metadata;
  final MusicScoreTheme theme;
  final CollisionDetector? collisionDetector; // CORREÇÃO: Adicionar collision detector

  BarlineRenderer({
    required this.coordinates,
    required this.metadata,
    required this.theme,
    this.collisionDetector, // CORREÇÃO: Parâmetro opcional
  });

  void render(Canvas canvas, Barline barline, Offset position) {
    // CORREÇÃO: Garantir espessura mínima visível para barlines
    final thickness = metadata.getEngravingDefault('thinBarlineThickness');
    final minThickness = coordinates.staffSpace * 0.16; // Behind Bars recomenda 0.16 SS
    final finalThickness = thickness > minThickness ? thickness : minThickness;
    
    final paint = Paint()
      ..color = theme.barlineColor
      ..strokeWidth = finalThickness
      ..strokeCap = StrokeCap.butt; // CRÍTICO: Pontas retas para linhas verticais
    
    // Desenhar do topo até o fundo do pentagrama
    canvas.drawLine(
      Offset(position.dx, coordinates.getStaffLineY(1)),
      Offset(position.dx, coordinates.getStaffLineY(5)),
      paint,
    );
  }
}
