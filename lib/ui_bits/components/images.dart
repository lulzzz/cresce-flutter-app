import 'dart:convert';
import 'dart:typed_data';

import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

abstract class BitImage {
  Uint8List getBytes();
  String toBase64();
}

class BitImageBase64 implements BitImage {
  final String base64Image;

  BitImageBase64(this.base64Image);

  @override
  Uint8List getBytes() =>
      base64Image != null ? base64.decode(base64Image) : Uint8List.fromList([]);

  @override
  String toBase64() => base64Image;
}

class BitImageBytes implements BitImage {
  final Uint8List bytes;

  BitImageBytes(this.bytes);

  @override
  Uint8List getBytes() => bytes;

  @override
  String toBase64() {
    return base64.encode(bytes);
  }
}

class CircleImageWidget extends StatelessWidget {
  final double width;
  final Future<BitImage> image;

  const CircleImageWidget({
    Key key,
    @required this.width,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BitImage>(
      future: image,
      builder: (context, snapshot) {
        return Container(
          width: width * 0.75,
          height: width * 0.75,
          decoration: buildBoxDecoration(snapshot),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration(AsyncSnapshot<BitImage> snapshot) {
    if (!snapshot.hasData || snapshot.data.getBytes().isEmpty) {
      return BoxDecoration();
    }

    return BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: MemoryImage(snapshot.data.getBytes()),
      ),
    );
  }
}
