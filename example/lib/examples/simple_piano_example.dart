// example/lib/examples/simple_piano_example.dart
// Exemplo Simples de Piano - Grand Staff (Clave de Sol + Clave de Fá)

import 'package:flutter/material.dart';
import 'package:flutter_notemus/flutter_notemus.dart';

class SimplePianoExample extends StatelessWidget {
  const SimplePianoExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🎹 PARTITURA DE PIANO - Grand Staff
    // Mão Direita: Clave de Sol (Treble)
    final rightHandStaff = Staff();

    final rightMeasure1 = Measure();
    rightMeasure1.add(Clef(clefType: ClefType.treble));
    rightMeasure1.add(KeySignature(0));
    rightMeasure1.add(TimeSignature(numerator: 4, denominator: 4));
    rightMeasure1.add(Note.simple('C5', DurationType.quarter));
    rightMeasure1.add(Note.simple('D5', DurationType.quarter));
    rightMeasure1.add(Note.simple('E5', DurationType.quarter));
    rightMeasure1.add(Note.simple('F5', DurationType.quarter));
    rightHandStaff.add(rightMeasure1);

    final rightMeasure2 = Measure();
    rightMeasure2.add(Note.simple('G5', DurationType.quarter));
    rightMeasure2.add(Note.simple('A5', DurationType.quarter));
    rightMeasure2.add(Note.simple('B5', DurationType.quarter));
    rightMeasure2.add(Note.simple('C6', DurationType.quarter));
    rightMeasure2.add(Barline(barlineType: BarlineType.final_));
    rightHandStaff.add(rightMeasure2);

    // Mão Esquerda: Clave de Fá (Bass)
    final leftHandStaff = Staff();

    final leftMeasure1 = Measure();
    leftMeasure1.add(Clef(clefType: ClefType.bass));
    leftMeasure1.add(KeySignature(0));
    leftMeasure1.add(TimeSignature(numerator: 4, denominator: 4));
    leftMeasure1.add(Note.simple('C3', DurationType.half));
    leftMeasure1.add(Note.simple('G3', DurationType.half));
    leftHandStaff.add(leftMeasure1);

    final leftMeasure2 = Measure();
    leftMeasure2.add(Note.simple('C3', DurationType.half));
    leftMeasure2.add(Note.simple('C4', DurationType.half));
    leftMeasure2.add(Barline(barlineType: BarlineType.final_));
    leftHandStaff.add(leftMeasure2);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Piano - Grand Staff'),
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildScoreCard('Mão Direita (Clave de Sol)', rightHandStaff),
            const SizedBox(height: 24),
            _buildScoreCard('Mão Esquerda (Clave de Fá)', leftHandStaff),
            const SizedBox(height: 24),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎹 Partitura de Piano',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Exemplo de Grand Staff (Clave de Sol + Clave de Fá)',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontStyle: FontStyle.italic,
          ),
        ),
        const Divider(height: 32, thickness: 2),
      ],
    );
  }

  Widget _buildScoreCard(String title, Staff staff) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.music_note, color: Colors.indigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo.shade100, width: 2),
              ),
              padding: const EdgeInsets.all(32),
              child: MusicScore(
                staff: staff,
                theme: const MusicScoreTheme(
                  noteheadColor: Colors.black,
                  stemColor: Colors.black,
                  staffLineColor: Colors.black87,
                  barlineColor: Colors.black,
                ),
                staffSpace: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.indigo, size: 28),
                SizedBox(width: 12),
                Text(
                  'Sobre o Grand Staff',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoPoint(
              '🎹 Grand Staff',
              'Sistema de duas pautas conectadas usado para piano e teclado.',
            ),
            _buildInfoPoint(
              '🎼 Clave de Sol (Mão Direita)',
              'Usada para notas mais agudas, geralmente tocadas com a mão direita.',
            ),
            _buildInfoPoint(
              '🎵 Clave de Fá (Mão Esquerda)',
              'Usada para notas mais graves, geralmente tocadas com a mão esquerda.',
            ),
            _buildInfoPoint(
              '📐 Notação Padrão',
              'As duas pautas são conectadas por uma chave (brace) e barras de compasso compartilhadas.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
