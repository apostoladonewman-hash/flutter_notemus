# Changelog

All notable changes to Flutter Notemus will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] - 2025-11-10

### 🎉 Initial Release

First public release of Flutter Notemus - a professional music notation rendering package for Flutter with complete SMuFL support.

### ✨ Added

#### Core Features
- Complete SMuFL (Standard Music Font Layout) support with 2932 glyphs from Bravura font
- Professional music notation rendering engine
- Staff position calculation system with precise pitch-to-position conversion
- Collision detection and smart spacing system
- Customizable theme system with colors and styles

#### Musical Elements
- **Notes & Rests**: All durations from whole to 1024th notes
- **Clefs**: Treble, bass, alto, tenor, percussion, and tablature clefs
- **Key Signatures**: Support for all major and minor keys
- **Time Signatures**: Simple, compound, and complex meters
- **Accidentals**: Natural, sharp, flat, double sharp/flat, and microtonal accidentals
- **Articulations**: Staccato, accent, tenuto, marcato, fermata, and more
- **Ornaments**: Trills, turns, mordents, and grace notes
- **Dynamics**: Full range from ppp to fff, crescendos, diminuendos
- **Chords**: Multi-note chords with proper stem alignment and spacing
- **Augmentation Dots**: Single, double, and triple dots with correct positioning
- **Ledger Lines**: Automatic ledger lines for notes outside the staff
- **Beams**: Note beaming support
- **Tuplets**: Triplets, quintuplets, and other irregular groupings
- **Slurs & Ties**: Curved connectors between notes
- **Repeat Marks**: Segno, coda, and other navigation symbols
- **Barlines**: Single, double, final, and repeat barlines using official SMuFL glyphs
- **Breath Marks**: Comma, tick, and caesura marks for wind/vocal music

#### Specialized Renderers (SRP Architecture)
- `NoteRenderer` - Note head rendering
- `StemRenderer` - Note stem rendering with SMuFL anchors
- `FlagRenderer` - Note flag rendering
- `DotRenderer` - Augmentation dot positioning and rendering
- `LedgerLineRenderer` - Ledger line rendering
- `AccidentalRenderer` - Accidental rendering with collision detection
- `ChordRenderer` - Multi-note chord rendering with custom stem lengths
- `DynamicRenderer` - Dynamic markings and hairpins
- `RepeatMarkRenderer` - Repeat symbols (segno, coda)
- `TextRenderer` - Musical text rendering

#### Data & Parsing
- JSON music data parser
- JSON export functionality
- Programmatic API for building music notation

#### Examples
- Complete working examples for all musical elements
- Demonstration of clefs, key signatures, time signatures
- Rhythm notation examples
- Chord and harmony examples
- Articulation and ornament examples
- Dynamic marking examples
- Augmentation dot examples
- Ledger line examples

### 🏗️ Architecture

#### Design Principles
- **Single Responsibility Principle**: Each renderer has one well-defined purpose
- **Modular Design**: Easy to extend and customize
- **SMuFL Compliant**: Follows SMuFL specification for glyph positioning
- **Typography-Aware**: Uses optical centers and engraving standards

#### Key Systems
- **Staff Coordinate System**: Unified coordinate system for staff elements
- **SMuFL Positioning Engine**: Precise glyph positioning using SMuFL metadata
- **Base Glyph Renderer**: Shared rendering logic with bounding box support
- **Collision Detector**: Smart spacing to avoid overlapping elements
- **Layout Engine**: Intelligent layout with proper spacing

### 📚 Documentation
- Comprehensive README with quick start guide
- API reference documentation
- Architecture documentation
- Complete example application
- Inline code documentation

### 🎨 Themes & Customization
- Default theme with professional appearance
- Customizable colors for all elements
- Support for dark mode
- Theme inheritance and composition
- Adjustable staff space sizing
- Configurable barline and staff line margins

### 📦 Database Integration
- Complete JSON format for storage
- SQLite integration examples
- Database schema recommendations
- Full CRUD operation examples
- Cloud sync patterns (Firebase, Supabase)

#### Layout & Rendering
- **Horizontal Justification**: Measures stretch proportionally to fill available width
- **Intelligent Line Breaking**: Automatic line breaks every 4 measures
- **Optimized Staff Lines**: Lines end exactly where music ends with smart barline detection
- **Configurable Margins**: Type-aware staff line margins (normal vs final barlines)
- **Multi-System Support**: Correct rendering across multiple staff systems

#### Advanced Beaming System
- **Primary Beams**: Colcheias (8th notes) with automatic slope calculation
- **Secondary Beams**: Semicolcheias, fusas, semifusas (up to 128th notes)
- **Broken Beams**: Fractional beams for dotted rhythms following "Behind Bars" rules
- **Smart Breaking**: "Two levels above" rule implementation
- **SMuFL Precision**: 0.5 SS thickness, 0.25 SS gap, perfect geometry

#### Measure Validation System
- **Automatic Validation**: Music theory-based validation
- **Real-time Capacity Checking**: Prevents overfilled measures
- **Detailed Error Messages**: Shows exactly what's wrong
- **Tuplet-Aware**: Correctly handles complex rhythms

### 🐛 Critical Bug Fixes

#### Barline Rendering
- **Multi-System Alignment**: Fixed barlines appearing outside staff on systems 1+
  - Root cause: Inconsistent coordinate systems between staff lines and barlines
  - Solution: Use `StaffCoordinateSystem.getStaffLineY()` as single source of truth
- **Repeat Barline Positioning**: Adjusted X offset (-1.0 SS) for proper alignment
- **SMuFL Baseline Correction**: Applied `barlineYOffset = -2.05` for typographic accuracy

#### Other Fixes
- **Augmentation Dot Positioning**: Fixed vertical alignment using real note position
- **Stem Lengths**: Corrected stem lengths for both individual notes and chords
- **Ledger Lines**: Fixed alignment with noteheads
- **Baseline Correction**: Applied proper SMuFL glyph baseline correction

### 🔧 Technical Improvements
- Optimized glyph rendering with TextPainter caching
- Efficient collision detection algorithm
- Memory-efficient asset loading
- Clean separation of concerns
- Complete removal of debug logging for production
- Zero TODO comments - all planned features documented in README

### 📦 Dependencies
- Flutter SDK: >=1.17.0
- Dart SDK: >=3.8.1
- xml: ^6.5.0 (for future MusicXML support)

---

## [Unreleased] - v0.2.0 (Planned for January 2026)

### 📅 Planned Features

#### Multi-Staff Support
- **Piano Grand Staff**: Two interconnected staves with shared barlines
- **SATB Vocal Scores**: Four-part vocal notation with proper grouping
- **Cross-Staff Beaming**: Beams spanning multiple staves

#### Notation Enhancements
- **Tablature**: 4-string (bass) and 6-string (guitar) tablature rendering
- **Chord Symbols**: Jazz/pop chord symbols with proper typography
- **Grace Notes**: Appoggiatura and acciaccatura with correct spacing
- **Multiple Voices**: Independent rhythms on same staff

#### Additional Features
- MusicXML import/export support
- MIDI playback integration
- Percussion notation improvements
- Performance optimizations

### 🚫 Current Limitations (v0.1.0)
See README.md for detailed information on features not yet implemented but planned for v0.2.0.

---

## Notes

### Version Numbering
- **Major** (X.0.0): Breaking API changes
- **Minor** (0.X.0): New features, backward compatible
- **Patch** (0.0.X): Bug fixes, backward compatible

### SMuFL Compliance
All rendering follows the SMuFL 1.40 specification for professional music engraving.

### Engraving Standards
Follows industry-standard engraving practices from:
- "Behind Bars" by Elaine Gould
- "The Art of Music Engraving" by Ted Ross

---

**Flutter Notemus** - Professional music notation for Flutter 🎵
