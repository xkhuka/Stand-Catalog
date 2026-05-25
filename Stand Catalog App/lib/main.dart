import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const JojoApp());

// ============================================================
// MODEL
// ============================================================

class Stand {
  final String nama;
  final String pengguna;
  final String part;
  final String kemampuan;
  final String deskripsi;
  final String tipe;
  final int power, speed, durability;
  final Color warna;
  final String nomorTarot;
  final Widget Function() buildIcon;

  const Stand({
    required this.nama,
    required this.pengguna,
    required this.part,
    required this.kemampuan,
    required this.deskripsi,
    required this.tipe,
    required this.power,
    required this.speed,
    required this.durability,
    required this.warna,
    required this.nomorTarot,
    required this.buildIcon,
  });
}

// ============================================================
// VECTOR ICONS (CustomPainter)
// ============================================================

// Star Platinum — mahkota berduri
class _StarPlatinumIcon extends CustomPainter {
  final Color c;
  _StarPlatinumIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    // Bintang 6 titik
    for (int i = 0; i < 6; i++) {
      final a = i * math.pi / 3 - math.pi / 2;
      canvas.drawLine(
        Offset(cx, cy),
        Offset(cx + 22 * math.cos(a), cy + 22 * math.sin(a)),
        p,
      );
      canvas.drawCircle(Offset(cx + 22 * math.cos(a), cy + 22 * math.sin(a)), 3, p..style = PaintingStyle.fill);
      p.style = PaintingStyle.stroke;
    }
    canvas.drawCircle(Offset(cx, cy), 10, p);
  }
  @override bool shouldRepaint(_) => false;
}

// The World — lingkaran + garis silang
class _TheWorldIcon extends CustomPainter {
  final Color c;
  _TheWorldIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(Offset(cx, cy), 20, p);
    canvas.drawCircle(Offset(cx, cy), 10, p);
    canvas.drawLine(Offset(cx - 20, cy), Offset(cx + 20, cy), p);
    canvas.drawLine(Offset(cx, cy - 20), Offset(cx, cy + 20), p);
  }
  @override bool shouldRepaint(_) => false;
}

// Gold Experience — daun/spiral
class _GoldExpIcon extends CustomPainter {
  final Color c;
  _GoldExpIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path();
    path.moveTo(cx, cy + 22);
    path.cubicTo(cx - 20, cy + 10, cx - 20, cy - 10, cx, cy - 22);
    path.cubicTo(cx + 20, cy - 10, cx + 20, cy + 10, cx, cy + 22);
    canvas.drawPath(path, p);
    canvas.drawLine(Offset(cx, cy + 22), Offset(cx, cy - 22), p);
  }
  @override bool shouldRepaint(_) => false;
}

// Killer Queen — tengkorak simpel
class _KillerQueenIcon extends CustomPainter {
  final Color c;
  _KillerQueenIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    // kepala
    canvas.drawCircle(Offset(cx, cy - 5), 16, p);
    // mata
    canvas.drawCircle(Offset(cx - 6, cy - 7), 4, p..style = PaintingStyle.fill);
    canvas.drawCircle(Offset(cx + 6, cy - 7), 4, p);
    p.style = PaintingStyle.stroke;
    // gigi
    for (int i = -1; i <= 1; i++) {
      canvas.drawLine(Offset(cx + i * 6.0, cy + 8), Offset(cx + i * 6.0, cy + 14), p);
    }
    canvas.drawLine(Offset(cx - 9, cy + 8), Offset(cx + 9, cy + 8), p);
  }
  @override bool shouldRepaint(_) => false;
}

// Crazy Diamond — berlian
class _CrazyDiamondIcon extends CustomPainter {
  final Color c;
  _CrazyDiamondIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path()
      ..moveTo(cx, cy - 22)
      ..lineTo(cx + 16, cy - 4)
      ..lineTo(cx, cy + 22)
      ..lineTo(cx - 16, cy - 4)
      ..close();
    canvas.drawPath(path, p);
    canvas.drawLine(Offset(cx - 16, cy - 4), Offset(cx + 16, cy - 4), p);
    canvas.drawLine(Offset(cx, cy - 22), Offset(cx, cy + 22), p);
  }
  @override bool shouldRepaint(_) => false;
}

// King Crimson — mata + tangan
class _KingCrimsonIcon extends CustomPainter {
  final Color c;
  _KingCrimsonIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    // mata di dahi
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - 12), width: 14, height: 8), p);
    canvas.drawCircle(Offset(cx, cy - 12), 2, p..style = PaintingStyle.fill);
    p.style = PaintingStyle.stroke;
    // tangan
    canvas.drawLine(Offset(cx - 18, cy + 10), Offset(cx + 18, cy + 10), p);
    for (int i = -2; i <= 2; i++) {
      canvas.drawLine(Offset(cx + i * 9.0, cy + 10), Offset(cx + i * 9.0, cy + 18), p);
    }
  }
  @override bool shouldRepaint(_) => false;
}

// Sticky Fingers — resleting
class _StickyFingersIcon extends CustomPainter {
  final Color c;
  _StickyFingersIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx, cy - 20), Offset(cx, cy + 20), p);
    for (int i = -3; i <= 3; i++) {
      canvas.drawLine(Offset(cx, cy + i * 6.0), Offset(cx + 12, cy + i * 6.0 - 4), p);
      canvas.drawLine(Offset(cx, cy + i * 6.0), Offset(cx - 12, cy + i * 6.0 + 4), p);
    }
  }
  @override bool shouldRepaint(_) => false;
}

// Echoes — telur/lingkaran berlapis
class _EchoesIcon extends CustomPainter {
  final Color c;
  _EchoesIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: 28, height: 38), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: 16, height: 22), p);
    canvas.drawCircle(Offset(cx, cy), 4, p..style = PaintingStyle.fill);
  }
  @override bool shouldRepaint(_) => false;
}

// Moody Blues — not musik
class _MoodyBluesIcon extends CustomPainter {
  final Color c;
  _MoodyBluesIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(Offset(cx - 8, cy + 12), 7, p);
    canvas.drawCircle(Offset(cx + 10, cy + 6), 7, p);
    canvas.drawLine(Offset(cx - 1, cy + 12), Offset(cx - 1, cy - 14), p);
    canvas.drawLine(Offset(cx + 17, cy + 6), Offset(cx + 17, cy - 20), p);
    canvas.drawLine(Offset(cx - 1, cy - 14), Offset(cx + 17, cy - 20), p);
  }
  @override bool shouldRepaint(_) => false;
}

// Soft & Wet — gelembung
class _SoftWetIcon extends CustomPainter {
  final Color c;
  _SoftWetIcon(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = c..style = PaintingStyle.stroke..strokeWidth = 2.5;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(Offset(cx, cy), 18, p);
    canvas.drawCircle(Offset(cx - 10, cy - 10), 8, p);
    canvas.drawCircle(Offset(cx + 12, cy + 8), 6, p);
    canvas.drawCircle(Offset(cx + 4, cy - 16), 4, p);
  }
  @override bool shouldRepaint(_) => false;
}

Widget standIcon(CustomPainter painter, {double size = 56}) {
  return CustomPaint(painter: painter, size: Size(size, size));
}

// ============================================================
// DATA
// ============================================================

final List<Stand> daftarStand = [
  Stand(
    nama: 'Star Platinum', pengguna: 'Jotaro Kujo', part: 'Part 3',
    kemampuan: 'Bisa ngehentiin waktu — "Za Warudo!"',
    deskripsi: 'Stand jarak dekat terkuat di Part 3. Kecepatan dan pukulannya hampir ga ada tandingannya. Bisa ngehentiin waktu beberapa detik.',
    tipe: 'Close-Range', power: 10, speed: 10, durability: 10,
    warna: const Color(0xFF7B2FFF), nomorTarot: 'I',
    buildIcon: () => standIcon(_StarPlatinumIcon(const Color(0xFF7B2FFF))),
  ),
  Stand(
    nama: 'The World', pengguna: 'Dio Brando', part: 'Part 3',
    kemampuan: 'Ngehentiin waktu — "ZA WARUDO!"',
    deskripsi: 'Stand milik Dio yang bisa ngehentiin waktu sampe 9 detik. Hampir identik sama Star Platinum tapi bisa lebih lama.',
    tipe: 'Close-Range', power: 10, speed: 10, durability: 10,
    warna: const Color(0xFFFF4444), nomorTarot: 'XXII',
    buildIcon: () => standIcon(_TheWorldIcon(const Color(0xFFFF4444))),
  ),
  Stand(
    nama: 'Gold Experience', pengguna: 'Giorno Giovanna', part: 'Part 5',
    kemampuan: 'Ngubah benda mati jadi makhluk hidup',
    deskripsi: 'Bisa mengubah benda apapun jadi makhluk hidup. Versi Requiem-nya hampir ga ada lawannya.',
    tipe: 'Close-Range', power: 8, speed: 8, durability: 8,
    warna: const Color(0xFFD4A017), nomorTarot: 'V',
    buildIcon: () => standIcon(_GoldExpIcon(const Color(0xFFD4A017))),
  ),
  Stand(
    nama: 'Killer Queen', pengguna: 'Yoshikage Kira', part: 'Part 4',
    kemampuan: 'Ngubah apapun yang disentuh jadi bom',
    deskripsi: 'Punya tiga kemampuan bom berbeda. Bom pertama ngehancurin tanpa bekas, bom kedua ngikutin target.',
    tipe: 'Close-Range', power: 9, speed: 7, durability: 8,
    warna: const Color(0xFFCC44FF), nomorTarot: 'XIII',
    buildIcon: () => standIcon(_KillerQueenIcon(const Color(0xFFCC44FF))),
  ),
  Stand(
    nama: 'Crazy Diamond', pengguna: 'Josuke Higashikata', part: 'Part 4',
    kemampuan: 'Restore / memperbaiki benda dan orang',
    deskripsi: 'Bisa nge-repair apa aja ke kondisi semula. Ga bisa nyembuhin diri sendiri tapi kekuatan fisiknya gede banget.',
    tipe: 'Close-Range', power: 9, speed: 8, durability: 9,
    warna: const Color(0xFF00BBFF), nomorTarot: 'VIII',
    buildIcon: () => standIcon(_CrazyDiamondIcon(const Color(0xFF00BBFF))),
  ),
  Stand(
    nama: 'King Crimson', pengguna: 'Diavolo', part: 'Part 5',
    kemampuan: 'Skip waktu beberapa detik ke depan',
    deskripsi: 'Bisa "ngehapus" waktu beberapa detik. Semua kejadian tetap terjadi tapi ga ada yang ngerasain, jadi serangan musuh meleset.',
    tipe: 'Close-Range', power: 10, speed: 10, durability: 8,
    warna: const Color(0xFFFF2266), nomorTarot: 'XI',
    buildIcon: () => standIcon(_KingCrimsonIcon(const Color(0xFFFF2266))),
  ),
  Stand(
    nama: 'Sticky Fingers', pengguna: 'Bruno Bucciarati', part: 'Part 5',
    kemampuan: 'Bikin resleting di permukaan apapun',
    deskripsi: 'Pukulannya bikin resleting muncul di mana aja — tembok, lantai, bahkan tubuh manusia.',
    tipe: 'Close-Range', power: 8, speed: 8, durability: 7,
    warna: const Color(0xFF4488FF), nomorTarot: 'IX',
    buildIcon: () => standIcon(_StickyFingersIcon(const Color(0xFF4488FF))),
  ),
  Stand(
    nama: 'Echoes', pengguna: 'Koichi Hirose', part: 'Part 4',
    kemampuan: 'Act 1-3: dari nulis suara sampe ngebebanin objek',
    deskripsi: 'Stand langka yang bisa evolusi jadi 3 bentuk. Makin lama makin kuat dan kemampuannya beda tiap Act.',
    tipe: 'Special', power: 6, speed: 7, durability: 6,
    warna: const Color(0xFF44CC44), nomorTarot: 'XIV',
    buildIcon: () => standIcon(_EchoesIcon(const Color(0xFF44CC44))),
  ),
  Stand(
    nama: 'Moody Blues', pengguna: 'Leone Abbacchio', part: 'Part 5',
    kemampuan: 'Replay ulang kejadian masa lalu',
    deskripsi: 'Bisa nge-replay semua kejadian yang pernah terjadi di suatu tempat. Berguna banget buat investigasi.',
    tipe: 'Special', power: 5, speed: 5, durability: 7,
    warna: const Color(0xFFCCAA00), nomorTarot: 'XVIII',
    buildIcon: () => standIcon(_MoodyBluesIcon(const Color(0xFFCCAA00))),
  ),
  Stand(
    nama: 'Soft & Wet', pengguna: 'Josuke (Part 8)', part: 'Part 8',
    kemampuan: 'Nyuri "sifat" dari objek pake gelembung',
    deskripsi: 'Nembak gelembung yang nyuri sifat dari objek — misal nyuri "licin" dari lantai terus dipindah ke musuh.',
    tipe: 'Close-Range', power: 7, speed: 8, durability: 7,
    warna: const Color(0xFF00DDCC), nomorTarot: 'XVI',
    buildIcon: () => standIcon(_SoftWetIcon(const Color(0xFF00DDCC))),
  ),
];

// ============================================================
// APP
// ============================================================

class JojoApp extends StatelessWidget {
  const JojoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Stand Catalog',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF0A0A0F)),
    home: const HalamanUtama(),
  );
}

// ============================================================
// HALAMAN UTAMA
// ============================================================

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Stand Catalog', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('JoJo\'s Bizarre Adventure • ${daftarStand.length} stand', style: TextStyle(color: Colors.white38, fontSize: 12)),
                  const SizedBox(height: 12),
                  Divider(color: Colors.white.withOpacity(0.08)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.6,
                ),
                itemCount: daftarStand.length,
                itemBuilder: (ctx, i) => _TarotCard(stand: daftarStand[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KARTU TAROT
// ============================================================

class _TarotCard extends StatelessWidget {
  final Stand stand;
  const _TarotCard({required this.stand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HalamanDetail(stand: stand))),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111118),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: stand.warna.withOpacity(0.35), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Nomor tarot
              Text(stand.nomorTarot, style: TextStyle(color: stand.warna.withOpacity(0.5), fontSize: 10, letterSpacing: 2)),
              const SizedBox(height: 8),
              // Icon area
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: stand.warna.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: stand.warna.withOpacity(0.15)),
                ),
                child: Center(child: stand.buildIcon()),
              ),
              const SizedBox(height: 10),
              // Nama
              Text(
                stand.nama,
                textAlign: TextAlign.center,
                style: TextStyle(color: stand.warna, fontSize: 12, fontWeight: FontWeight.bold, height: 1.3),
              ),
              const SizedBox(height: 2),
              Text(stand.pengguna, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              const Spacer(),
              Divider(color: stand.warna.withOpacity(0.15)),
              const SizedBox(height: 4),
              // Stats kecil
              _miniStat('PWR', stand.power, stand.warna),
              const SizedBox(height: 3),
              _miniStat('SPD', stand.speed, stand.warna),
              const SizedBox(height: 3),
              _miniStat('DUR', stand.durability, stand.warna),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: stand.warna.withOpacity(0.25)),
                ),
                child: Text(stand.tipe, style: TextStyle(color: stand.warna.withOpacity(0.7), fontSize: 8)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStat(String label, int val, Color c) => Row(
    children: [
      SizedBox(width: 24, child: Text(label, style: const TextStyle(color: Colors.white30, fontSize: 9))),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: val / 10,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(c.withOpacity(0.7)),
            minHeight: 4,
          ),
        ),
      ),
      const SizedBox(width: 4),
      Text('$val', style: TextStyle(color: c, fontSize: 9, fontWeight: FontWeight.bold)),
    ],
  );
}

// ============================================================
// HALAMAN DETAIL
// ============================================================

class HalamanDetail extends StatelessWidget {
  final Stand stand;
  const HalamanDetail({super.key, required this.stand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(stand.nama, style: TextStyle(color: stand.warna, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon besar di tengah
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: stand.warna.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: stand.warna.withOpacity(0.3), width: 1.5),
                ),
                child: Center(child: standIcon(
                  (){
                    // return the right painter based on nama
                    final painters = {
                      'Star Platinum': _StarPlatinumIcon(stand.warna),
                      'The World': _TheWorldIcon(stand.warna),
                      'Gold Experience': _GoldExpIcon(stand.warna),
                      'Killer Queen': _KillerQueenIcon(stand.warna),
                      'Crazy Diamond': _CrazyDiamondIcon(stand.warna),
                      'King Crimson': _KingCrimsonIcon(stand.warna),
                      'Sticky Fingers': _StickyFingersIcon(stand.warna),
                      'Echoes': _EchoesIcon(stand.warna),
                      'Moody Blues': _MoodyBluesIcon(stand.warna),
                      'Soft & Wet': _SoftWetIcon(stand.warna),
                    };
                    return painters[stand.nama] ?? _StarPlatinumIcon(stand.warna);
                  }(),
                  size: 90,
                )),
              ),
            ),

            const SizedBox(height: 16),

            // Nomor tarot + nama
            Center(child: Text(stand.nomorTarot, style: TextStyle(color: stand.warna.withOpacity(0.4), fontSize: 12, letterSpacing: 3))),
            const SizedBox(height: 4),
            Center(child: Text(stand.nama, style: TextStyle(color: stand.warna, fontSize: 22, fontWeight: FontWeight.bold))),
            Center(child: Text('Pengguna: ${stand.pengguna}', style: const TextStyle(color: Colors.white38, fontSize: 13))),

            const SizedBox(height: 20),

            // Deskripsi
            Text(stand.deskripsi, style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.6)),

            const SizedBox(height: 20),

            // Stats
            const Text('Stats', style: TextStyle(color: Colors.white30, fontSize: 10, letterSpacing: 1.5)),
            const SizedBox(height: 10),
            _statBar('Power', stand.power, stand.warna),
            const SizedBox(height: 8),
            _statBar('Speed', stand.speed, stand.warna),
            const SizedBox(height: 8),
            _statBar('Durability', stand.durability, stand.warna),

            const SizedBox(height: 20),

            // Info
            const Text('Info', style: TextStyle(color: Colors.white30, fontSize: 10, letterSpacing: 1.5)),
            const SizedBox(height: 10),
            _infoRow(Icons.bolt, 'Kemampuan', stand.kemampuan, stand.warna),
            _infoRow(Icons.category_outlined, 'Tipe', stand.tipe, stand.warna),
            _infoRow(Icons.book_outlined, 'Muncul di', stand.part, stand.warna),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: stand.warna.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('← Kembali', style: TextStyle(color: stand.warna)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statBar(String label, int val, Color c) => Padding(
    padding: const EdgeInsets.only(bottom: 0),
    child: Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: val / 10, backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(c), minHeight: 10,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('$val/10', style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String label, String val, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF111118),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withOpacity(0.07)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: c.withOpacity(0.6), size: 15),
        const SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white30, fontSize: 10)),
            const SizedBox(height: 2),
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        )),
      ],
    ),
  );
}
