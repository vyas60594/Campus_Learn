import 'dart:io';
import 'package:image/image.dart' as img;

Future<void> main() async {
  const int size = 1024;
  final image = img.Image(width: size, height: size);

  // Blue -> purple diagonal gradient
  const int startColor = 0xFF3A7BFF;
  const int endColor = 0xFF7A53FF;
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      final t = ((x + y) / (size * 2)).clamp(0.0, 1.0);
      final r = ((1 - t) * ((startColor >> 16) & 0xFF) + t * ((endColor >> 16) & 0xFF)).round();
      final g = ((1 - t) * ((startColor >> 8) & 0xFF) + t * ((endColor >> 8) & 0xFF)).round();
      final b = ((1 - t) * (startColor & 0xFF) + t * (endColor & 0xFF)).round();
      image.setPixelRgb(x, y, r, g, b);
    }
  }

  // Simple white minimal mark
  final white = img.ColorRgba8(255, 255, 255, 255);
  // Central circle
  img.fillCircle(image, x: 512, y: 470, radius: 120, color: white);
  // Base rectangle
  img.fillRect(image, x1: 396, y1: 568, x2: 396 + 232, y2: 568 + 110, color: white);
  // Tassel curve from right of circle
  _strokeBezier(image, (628, 470), (680, 560), (648, 650), 18, white);
  img.fillCircle(image, x: 648, y: 650, radius: 22, color: white);

  final outDir = Directory('assets/icons');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);
  final outPath = 'assets/icons/app_icon.png';
  final pngBytes = img.encodePng(image);
  File(outPath).writeAsBytesSync(pngBytes);
  stdout.writeln('Wrote $outPath');
}

void _strokeBezier(img.Image dst, (int,int) p0, (int,int) p1, (int,int) p2, int width, img.Color color) {
  const int segments = 60;
  (double,double) pt(double t) {
    final x = (1 - t) * (1 - t) * p0.$1 + 2 * (1 - t) * t * p1.$1 + t * t * p2.$1;
    final y = (1 - t) * (1 - t) * p0.$2 + 2 * (1 - t) * t * p1.$2 + t * t * p2.$2;
    return (x, y);
  }
  var prev = pt(0);
  for (int i = 1; i <= segments; i++) {
    final t = i / segments;
    final cur = pt(t);
    img.drawLine(
      dst,
      x1: prev.$1.round(),
      y1: prev.$2.round(),
      x2: cur.$1.round(),
      y2: cur.$2.round(),
      color: color,
      thickness: width,
    );
    prev = cur;
  }
}

