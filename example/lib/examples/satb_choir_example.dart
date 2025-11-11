// example/lib/examples/satb_choir_example.dart
// Exemplo de Partitura Coral SATB (Soprano, Alto, Tenor, Baixo)

import 'package:flutter/material.dart';
import 'package:flutter_notemus/flutter_notemus.dart';

class SATBChoirExample extends StatelessWidget {
  const SATBChoirExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🎤 SOPRANO (Clave de Sol - voz feminina aguda)
    final sopranoStaff = Staff();
    final soprano1 = Measure();
    soprano1.add(Clef(clefType: ClefType.treble));
    soprano1.add(KeySignature(0));
    soprano1.add(TimeSignature(numerator: 4, denominator: 4));
    soprano1.add(Note.simple('C5', DurationType.whole));
    sopranoStaff.add(soprano1);

    final soprano2 = Measure();
    soprano2.add(Note.simple('E5', DurationType.whole));
    soprano2.add(Barline(barlineType: BarlineType.final_));
    sopranoStaff.add(soprano2);

    // 🎤 CONTRALTO/ALTO (Clave de Sol - voz feminina grave)
    final altoStaff = Staff();
    final alto1 = Measure();
    alto1.add(Clef(clefType: ClefType.treble));
    alto1.add(KeySignature(0));
    alto1.add(TimeSignature(numerator: 4, denominator: 4));
    alto1.add(Note.simple('E4', DurationType.whole));
    altoStaff.add(alto1);

    final alto2 = Measure();
    alto2.add(Note.simple('G4', DurationType.whole));
    alto2.add(Barline(barlineType: BarlineType.final_));
    altoStaff.add(alto2);

    // 🎤 TENOR (Clave de Sol 8vb - voz masculina aguda)
    final tenorStaff = Staff();
    final tenor1 = Measure();
    tenor1.add(Clef(clefType: ClefType.treble8vb));
    tenor1.add(KeySignature(0));
    tenor1.add(TimeSignature(numerator: 4, denominator: 4));
    tenor1.add(Note.simple('G3', DurationType.whole));
    tenorStaff.add(tenor1);

    final tenor2 = Measure();
    tenor2.add(Note.simple('C4', DurationType.whole));
    tenor2.add(Barline(barlineType: BarlineType.final_));
    tenorStaff.add(tenor2);

    // 🎤 BAIXO/BASS (Clave de Fá - voz masculina grave)
    final bassStaff = Staff();
    final bass1 = Measure();
    bass1.add(Clef(clefType: ClefType.bass));
    bass1.add(KeySignature(0));
    bass1.add(TimeSignature(numerator: 4, denominator: 4));
    bass1.add(Note.simple('C3', DurationType.whole));
    bassStaff.add(bass1);

    final bass2 = Measure();
    bass2.add(Note.simple('C3', DurationType.whole));
    bass2.add(Barline(barlineType: BarlineType.final_));
    bassStaff.add(bass2);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Coral SATB'),
        backgroundColor: Colors.purple,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildScoreCard('🎤 Soprano', sopranoStaff, Colors.pink),
            const SizedBox(height: 16),
            _buildScoreCard('🎤 Alto', altoStaff, Colors.orange),
            const SizedBox(height: 16),
            _buildScoreCard('🎤 Tenor', tenorStaff, Colors.blue),
            const SizedBox(height: 16),
            _buildScoreCard('🎤 Baixo', bassStaff, Colors.deepPurple),
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
          '🎤 Partitura Coral SATB',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Soprano, Alto, Tenor e Baixo (4 vozes)',
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

  Widget _buildScoreCard(String title, Staff staff, Color color) {
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
                Icon(Icons.mic, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
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
            colors: [Colors.purple.shade50, Colors.white],
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
                Icon(Icons.info_outline, color: Colors.purple, size: 28),
                SizedBox(width: 12),
                Text(
                  'Sobre SATB',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoPoint(
              '🎤 SATB',
              'Soprano, Alto, Tenor, Baixo - as 4 vozes tradicionais da música coral.',
            ),
            _buildInfoPoint(
              '👩 Soprano',
              'Voz feminina mais aguda (Clave de Sol). Tessitura: C4-A5.',
            ),
            _buildInfoPoint(
              '👩 Alto/Contralto',
              'Voz feminina mais grave (Clave de Sol). Tessitura: G3-E5.',
            ),
            _buildInfoPoint(
              '👨 Tenor',
              'Voz masculina mais aguda (Clave de Sol 8vb). Tessitura: C3-A4.',
            ),
            _buildInfoPoint(
              '👨 Baixo/Bass',
              'Voz masculina mais grave (Clave de Fá). Tessitura: E2-E4.',
            ),
            const Divider(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Em uma partitura real, todas as vozes seriam mostradas simultaneamente em um único sistema!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
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
              color: Colors.purple,
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
