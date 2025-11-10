// lib/core/grace_note.dart

import 'duration.dart';
import 'pitch.dart';

/// Tipos de grace notes suportados pelo Flutter Notemus.
///
/// * [GraceNoteType.appoggiatura] - Executada **sobre** o tempo, geralmente sem slash.
/// * [GraceNoteType.acciaccatura] - Executada **antes** do tempo, com slash diagonal.
enum GraceNoteType {
  appoggiatura,
  acciaccatura,
}

/// Modelo de dados para uma grace note (appoggiatura ou acciaccatura).
///
/// Uma grace note pertence semanticamente a uma nota principal e deve ser
/// renderizada imediatamente antes dela, seguindo as regras de notação
/// profissional descritas em "Behind Bars" (Elaine Gould) e na especificação
/// SMuFL/Bravura.
class GraceNote {
  /// Altura musical da grace note.
  final Pitch pitch;

  /// Duração nominal da grace note (semibreve = 1.0, etc.).
  /// Em geral utiliza-se valores curtos (colcheia, semicolcheia), mas a
  /// especificação permite qualquer duração.
  final Duration duration;

  /// Tipo de grace note (appoggiatura ou acciaccatura).
  final GraceNoteType type;

  /// Indica se deve haver uma ligadura (slur) conectando a grace note à nota
  /// principal. Por padrão `false`.
  final bool slurToMainNote;

  /// Quando `true`, a grace note faz parte de um acorde (várias alturas
  /// simultâneas). O posicionamento horizontal deve respeitar o voicing do
  /// acorde principal. Por padrão `false`.
  final bool isChordComponent;

  const GraceNote({
    required this.pitch,
    required this.duration,
    required this.type,
    this.slurToMainNote = false,
    this.isChordComponent = false,
  });

  /// Conveniência: indica se a grace note deve exibir slash diagonal na haste.
  bool get hasSlash => type == GraceNoteType.acciaccatura;
}
