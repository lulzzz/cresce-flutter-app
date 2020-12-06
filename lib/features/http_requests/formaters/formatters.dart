import 'decoders.dart';

abstract class Formatters implements Decoder, Encoder {
  const Formatters();
  dynamic decode(String data);
  String encode(Map<String, dynamic> data);
  String encodeList(List<Map<String, dynamic>> data);
  String getContentType();

  Decoder get decoder => this;
  Encoder get encoder => this;
}
