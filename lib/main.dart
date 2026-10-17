
import 'package:flutter/material.dart';

void main() {
  runApp(const CareerStar());
}

class CareerStar extends StatelessWidget {
  const CareerStar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Star 27',
      theme: ThemeData.dark(),
      home: const CareerHome(),
    );
  }
}

class CareerHome extends StatefulWidget {
  const CareerHome({super.key});

  @override
  State<CareerHome> createState() => _CareerHomeState();
}

class _CareerHomeState extends State<CareerHome> {
  double x = 0;
  double y = 0;
  int goals = 0;
  int energy = 100;
  String message = 'تحرك باللاعب وسجّل هدفك!';

  void move(double dx, double dy) {
    setState(() {
      x = (x + dx).clamp(-0.85, 0.85).toDouble();
      y = (y + dy).clamp(-0.65, 0.65).toDouble();
      energy = (energy - 1).clamp(0, 100);
      message = 'واصل الهجوم!';
    });
  }

  void shoot() {
    setState(() {
      goals++;
      energy = (energy - 5).clamp(0, 100);
      message = 'جوووول! سجلت هدفًا ⚽';
    });
  }

  Widget control(String label, VoidCallback action) {
    return SizedBox(
      width: 76,
      height: 54,
      child: ElevatedButton(
        onPressed: action,
        child: Text(label, style: const TextStyle(fontSize: 22)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAREER STAR 27 ⚽'),
        centerTitle: true,
        backgroundColor: Colors.green.shade900,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('الأهداف: $goals'),
                Text('الطاقة: $energy%'),
                const Text('المستوى: 1'),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: PitchPainter()),
                ),
                Align(
                  alignment: Alignment(0, -0.88),
                  child: Container(
                    width: 130,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Center(
                      child: Text('🥅', style: TextStyle(fontSize: 30)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(x, y),
                  child: const Text('🔵', style: TextStyle(fontSize: 38)),
                ),
                Align(
                  alignment: Alignment(
                    (x + 0.12).clamp(-0.9, 0.9).toDouble(),
                    (y - 0.08).clamp(-0.75, 0.75).toDouble(),
                  ),
                  child: const Text('⚽', style: TextStyle(fontSize: 25)),
                ),
                Align(
                  alignment: const Alignment(0.55, -0.35),
                  child: const Text('🔴', style: TextStyle(fontSize: 38)),
                ),
                Align(
                  alignment: const Alignment(0, 0.96),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                control('⬆️', () => move(0, -0.15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    control('⬅️', () => move(-0.15, 0)),
                    const SizedBox(width: 12),
                    control('⬇️', () => move(0, 0.15)),
                    const SizedBox(width: 12),
                    control('➡️', () => move(0.15, 0)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: shoot,
                      icon: const Icon(Icons.sports_soccer),
                      label: const Text('تسديد'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          message = 'مررت الكرة إلى زميلك!';
                          energy = (energy - 2).clamp(0, 100);
                        });
                      },
                      icon: const Icon(Icons.swap_horiz),
                      label: const Text('تمرير'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grass = Paint()..color = const Color(0xFF16853A);
    canvas.drawRect(Offset.zero & size, grass);

    final stripe = Paint()..color = const Color(0xFF209747);
    for (int i = 0; i < 6; i++) {
      if (i.isEven) {
        canvas.drawRect(
          Rect.fromLTWH(0, size.height * i / 6, size.width,
              size.height / 6),
          stripe,
        );
      }
    }

    final line = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final field = Rect.fromLTWH(
      12, 12, size.width - 24, size.height - 24,
    );
    canvas.drawRect(field, line);
    canvas.drawLine(
      Offset(12, size.height / 2),
      Offset(size.width - 12, size.height / 2),
      line,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      45,
      line,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.25, 12,
          size.width * 0.5, 95),
      line,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
